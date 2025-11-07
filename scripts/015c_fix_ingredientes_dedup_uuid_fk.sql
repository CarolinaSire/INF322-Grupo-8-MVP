-- 015c_fix_ingredientes_dedup_uuid_fk.sql
-- DEDUP con UUID y ACTUALIZANDO TODAS LAS FKs antes de borrar duplicados.
-- Evita romper el CHECK (ingrediente_id XOR receta_id) en registro_alimentos.

BEGIN;

-- 0) Columna normalizada
ALTER TABLE public.ingredientes
  ADD COLUMN IF NOT EXISTS nombre_norm text
  GENERATED ALWAYS AS (lower(btrim(nombre))) STORED;

-- 1) Mapeo de duplicados a su "canónico"
CREATE TEMP TABLE tmp_ing_dedup AS
SELECT
  id,
  nombre_norm,
  ROW_NUMBER() OVER (PARTITION BY nombre_norm ORDER BY id) AS rn,
  FIRST_VALUE(id) OVER (PARTITION BY nombre_norm ORDER BY id) AS keep_id
FROM public.ingredientes;

-- 2) Reencaminar FKs (ANTES de borrar)
-- 2.1 receta_ingredientes
UPDATE public.receta_ingredientes ri
SET ingrediente_id = m.keep_id
FROM tmp_ing_dedup m
WHERE ri.ingrediente_id = m.id
  AND m.rn > 1;

-- 2.2 registro_alimentos (resuelve el error del CHECK)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema='public' AND table_name='registro_alimentos' AND column_name='ingrediente_id'
  ) THEN
    UPDATE public.registro_alimentos ra
    SET ingrediente_id = m.keep_id
    FROM tmp_ing_dedup m
    WHERE ra.ingrediente_id = m.id
      AND m.rn > 1;
  END IF;
END $$;

-- 2.3 Preferencias/intolerancias si referencian ingredientes (defensivo)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema='public' AND table_name='preferencias_alimentos' AND column_name='ingrediente_id'
  ) THEN
    UPDATE public.preferencias_alimentos pa
    SET ingrediente_id = m.keep_id
    FROM tmp_ing_dedup m
    WHERE pa.ingrediente_id = m.id
      AND m.rn > 1;
  END IF;

  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema='public' AND table_name='intolerancias' AND column_name='ingrediente_id'
  ) THEN
    UPDATE public.intolerancias it
    SET ingrediente_id = m.keep_id
    FROM tmp_ing_dedup m
    WHERE it.ingrediente_id = m.id
      AND m.rn > 1;
  END IF;
END $$;

-- 3) Borrar ingredientes duplicados (ya sin referencias)
DELETE FROM public.ingredientes i
USING tmp_ing_dedup m
WHERE i.id = m.id
  AND m.rn > 1;

-- 4) Limpiar posibles duplicados en la tabla puente
WITH dup AS (
  SELECT id,
         ROW_NUMBER() OVER (PARTITION BY receta_id, ingrediente_id ORDER BY id) AS rn
  FROM public.receta_ingredientes
)
DELETE FROM public.receta_ingredientes ri
USING dup
WHERE ri.id = dup.id
  AND dup.rn > 1;

-- 5) Evitar futuros duplicados
ALTER TABLE public.ingredientes
  DROP CONSTRAINT IF EXISTS uq_ingredientes_nombre_norm;

ALTER TABLE public.ingredientes
  ADD CONSTRAINT uq_ingredientes_nombre_norm UNIQUE (nombre_norm);


DROP TABLE IF EXISTS tmp_ing_dedup;

COMMIT;

-- Verificación
-- SELECT nombre_norm, COUNT(*) FROM public.ingredientes GROUP BY 1 HAVING COUNT(*)>1;
-- SELECT nombre, calorias FROM public.ingredientes WHERE nombre ILIKE '%leche descremada%' ORDER BY nombre;