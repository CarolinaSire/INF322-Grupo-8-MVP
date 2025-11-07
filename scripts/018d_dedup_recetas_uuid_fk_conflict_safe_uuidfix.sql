-- 018d_dedup_recetas_uuid_fk_conflict_safe_uuidfix.sql
-- Dedup de recetas (UUID), seguro frente a UNIQUE(receta_id, etiqueta)
-- y sin usar MIN(uuid). Usa ROW_NUMBER() / FIRST_VALUE() para elegir filas.
-- - Colapsa etiquetas duplicadas dentro de cada receta duplicada.
-- - Evita colisiones con el keep_id.
-- - Colapsa etiquetas iguales provenientes de multiples duplicadas que confluyen al mismo keep_id.
-- - Reencamina FKs y elimina duplicados.
-- - Limpieza defensiva e índices únicos.
BEGIN;

-- 0) Columna normalizada del nombre (si no existe)
ALTER TABLE public.recetas
  ADD COLUMN IF NOT EXISTS nombre_norm text
  GENERATED ALWAYS AS (lower(btrim(nombre))) STORED;

-- 1) Mapeo canónico por nombre (elige keep_id por orden de id)
CREATE TEMP TABLE tmp_rec_dedup AS
SELECT
  id,
  nombre_norm,
  ROW_NUMBER() OVER (PARTITION BY nombre_norm ORDER BY id ASC) AS rn,
  FIRST_VALUE(id) OVER (PARTITION BY nombre_norm ORDER BY id ASC) AS keep_id
FROM public.recetas;

-- 2) PRE-NORMALIZAR receta_etiquetas PARA EVITAR COLISIONES
-- 2.0 A minúsculas sin romper UNIQUE
INSERT INTO public.receta_etiquetas (receta_id, etiqueta)
SELECT receta_id, lower(etiqueta)
FROM public.receta_etiquetas
WHERE etiqueta <> lower(etiqueta)
ON CONFLICT (receta_id, etiqueta) DO NOTHING;

DELETE FROM public.receta_etiquetas
WHERE etiqueta <> lower(etiqueta);

-- 2.1 Quitar duplicados internos en cada receta duplicada
WITH d AS (
  SELECT id,
         ROW_NUMBER() OVER (PARTITION BY receta_id, etiqueta ORDER BY id) AS rn
  FROM public.receta_etiquetas
  WHERE receta_id IN (SELECT id FROM tmp_rec_dedup WHERE rn > 1)
)
DELETE FROM public.receta_etiquetas e
USING d
WHERE e.id = d.id AND d.rn > 1;

-- 2.2 Si el keep ya tiene esa etiqueta, eliminar la del duplicado antes de mover
DELETE FROM public.receta_etiquetas src
USING tmp_rec_dedup m, public.receta_etiquetas tgt
WHERE src.receta_id = m.id AND m.rn > 1
  AND tgt.receta_id = m.keep_id
  AND tgt.etiqueta   = src.etiqueta;

-- 2.3 Colapsar etiquetas iguales entre TODAS las duplicadas que van al mismo keep_id
CREATE TEMP TABLE tmp_move_choice AS
SELECT keep_id, etiqueta, id AS chosen_id
FROM (
  SELECT m.keep_id, src.etiqueta, src.id,
         ROW_NUMBER() OVER (PARTITION BY m.keep_id, src.etiqueta ORDER BY src.id) AS rn
  FROM public.receta_etiquetas src
  JOIN tmp_rec_dedup m ON src.receta_id = m.id AND m.rn > 1
) t
WHERE rn = 1;

DELETE FROM public.receta_etiquetas src
USING tmp_move_choice c, tmp_rec_dedup m
WHERE src.receta_id = m.id AND m.rn > 1
  AND c.keep_id = m.keep_id
  AND c.etiqueta = src.etiqueta
  AND src.id <> c.chosen_id;

-- 3) Manejo similar para ingredientes (defensivo)
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables
             WHERE table_schema='public' AND table_name='receta_ingredientes') THEN

    -- 3.1 Quitar duplicados internos (misma (receta_id, ingrediente_id))
    WITH d AS (
      SELECT id,
             ROW_NUMBER() OVER (PARTITION BY receta_id, ingrediente_id ORDER BY id) AS rn
      FROM public.receta_ingredientes
      WHERE receta_id IN (SELECT id FROM tmp_rec_dedup WHERE rn > 1)
    )
    DELETE FROM public.receta_ingredientes ri
    USING d
    WHERE ri.id = d.id AND d.rn > 1;

    -- 3.2 Si el keep ya tiene ese ingrediente, eliminar la fila del duplicado
    DELETE FROM public.receta_ingredientes src
    USING tmp_rec_dedup m, public.receta_ingredientes tgt
    WHERE src.receta_id = m.id AND m.rn > 1
      AND tgt.receta_id = m.keep_id
      AND tgt.ingrediente_id = src.ingrediente_id;
  END IF;
END $$;

-- 4) Reencaminar FKs
UPDATE public.receta_etiquetas re
SET receta_id = m.keep_id
FROM tmp_rec_dedup m
WHERE re.receta_id = m.id AND m.rn > 1;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables
             WHERE table_schema='public' AND table_name='receta_ingredientes') THEN
    UPDATE public.receta_ingredientes ri
    SET receta_id = m.keep_id
    FROM tmp_rec_dedup m
    WHERE ri.receta_id = m.id AND m.rn > 1;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables
             WHERE table_schema='public' AND table_name='recetas_favoritas') THEN
    UPDATE public.recetas_favoritas rf
    SET receta_id = m.keep_id
    FROM tmp_rec_dedup m
    WHERE rf.receta_id = m.id AND m.rn > 1;
  END IF;

  IF EXISTS (SELECT 1 FROM information_schema.columns
             WHERE table_schema='public' AND table_name='registro_alimentos' AND column_name='receta_id') THEN
    UPDATE public.registro_alimentos ra
    SET receta_id = m.keep_id
    FROM tmp_rec_dedup m
    WHERE ra.receta_id = m.id AND m.rn > 1;
  END IF;
END $$;

-- 5) Borrar recetas duplicadas
DELETE FROM public.recetas r
USING tmp_rec_dedup m
WHERE r.id = m.id AND m.rn > 1;

-- 6) Limpiezas defensivas post-merge
WITH d1 AS (
  SELECT id, ROW_NUMBER() OVER (PARTITION BY receta_id, etiqueta ORDER BY id) AS rn
  FROM public.receta_etiquetas
)
DELETE FROM public.receta_etiquetas e
USING d1
WHERE e.id = d1.id AND d1.rn > 1;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables
             WHERE table_schema='public' AND table_name='receta_ingredientes') THEN
    WITH d2 AS (
      SELECT id, ROW_NUMBER() OVER (PARTITION BY receta_id, ingrediente_id ORDER BY id) AS rn
      FROM public.receta_ingredientes
    )
    DELETE FROM public.receta_ingredientes ri
    USING d2
    WHERE ri.id = d2.id AND d2.rn > 1;
  END IF;
END $$;

-- 7) Índices únicos (protección a futuro)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_indexes WHERE schemaname='public' AND indexname='uq_recetas_publicas_nombre_norm'
  ) THEN
    CREATE UNIQUE INDEX uq_recetas_publicas_nombre_norm
      ON public.recetas (nombre_norm)
      WHERE es_publica;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_indexes WHERE schemaname='public' AND indexname='uq_recetas_usuario_nombre_norm'
  ) THEN
    CREATE UNIQUE INDEX uq_recetas_usuario_nombre_norm
      ON public.recetas (created_by, nombre_norm)
      WHERE NOT es_publica;
  END IF;
END $$;

DROP TABLE IF EXISTS tmp_move_choice;
DROP TABLE IF EXISTS tmp_rec_dedup;

COMMIT;

-- Verificación
-- SELECT nombre, COUNT(*) FROM public.recetas GROUP BY 1 HAVING COUNT(*)>1 ORDER BY 2 DESC;
-- SELECT r.nombre, string_agg(e.etiqueta, ', ' ORDER BY e.etiqueta) AS tags
-- FROM public.recetas r JOIN public.receta_etiquetas e ON e.receta_id = r.id
-- GROUP BY r.id, r.nombre ORDER BY r.nombre;