-- 017b_normalize_recipe_diet_tags_safe.sql
-- Normaliza dietas/etiquetas sin chocar con UNIQUE(receta_id, etiqueta).
-- Estrategia: insertar la etiqueta canónica (ON CONFLICT DO NOTHING)
-- y luego borrar los sinónimos/variantes. Finalmente, aplicar reglas
-- de exclusión entre dietas base.

BEGIN;

-- 0) Normalizar a minúsculas sin violar UNIQUE
INSERT INTO public.receta_etiquetas (receta_id, etiqueta)
SELECT receta_id, lower(etiqueta)
FROM public.receta_etiquetas
WHERE etiqueta <> lower(etiqueta)
ON CONFLICT (receta_id, etiqueta) DO NOTHING;

DELETE FROM public.receta_etiquetas
WHERE etiqueta <> lower(etiqueta);

-- 1) Mapeo de sinónimos → forma canónica
CREATE TEMP TABLE tmp_tag_map(alias text, canonical text) ON COMMIT DROP;

INSERT INTO tmp_tag_map(alias, canonical) VALUES
-- sin gluten
('sin_gluten','sin gluten'),
('sin-gluten','sin gluten'),
('singluten','sin gluten'),
('gluten free','sin gluten'),
('gluten-free','sin gluten'),
-- vegana
('vegano','vegana'),
('vegans','vegana'),
('vegan','vegana'),
-- vegetariana
('vegetariano','vegetariana'),
('vegetarian','vegetariana'),
-- omnívora
('omnivora','omnívora'),
('omn\u00edvora','omnívora'),
('omnivoro','omnívora'),
('omnívoro','omnívora'),
('omnivore','omnívora'),
-- pescetariana
('pescetariano','pescetariana'),
('pesquetariana','pescetariana'),
('pesco','pescetariana'),
('pescetarian','pescetariana'),
-- cetogénica
('keto','cetogénica'),
('cetogenica','cetogénica'),
('cetogenico','cetogénica'),
('cetogénico','cetogénica');

-- 2) Insertar etiquetas canónicas donde se detecte un alias (evita colisiones)
INSERT INTO public.receta_etiquetas (receta_id, etiqueta)
SELECT DISTINCT re.receta_id, m.canonical
FROM public.receta_etiquetas re
JOIN tmp_tag_map m ON re.etiqueta = m.alias
ON CONFLICT (receta_id, etiqueta) DO NOTHING;

-- 3) Borrar los alias (ya existe la canónica)
DELETE FROM public.receta_etiquetas re
USING tmp_tag_map m
WHERE re.etiqueta = m.alias;

-- 4) Reglas de exclusión entre dietas base
-- 4.1 Si hay 'vegana', eliminar 'vegetariana'
DELETE FROM public.receta_etiquetas a
USING public.receta_etiquetas b
WHERE a.receta_id = b.receta_id
  AND a.etiqueta = 'vegetariana'
  AND b.etiqueta = 'vegana';

-- 4.2 Si hay 'pescetariana', eliminar 'omnívora'
DELETE FROM public.receta_etiquetas a
USING public.receta_etiquetas b
WHERE a.receta_id = b.receta_id
  AND a.etiqueta = 'omnívora'
  AND b.etiqueta = 'pescetariana';

-- 4.3 Si hay 'vegetariana' o 'vegana', eliminar 'omnívora' y 'pescetariana'
DELETE FROM public.receta_etiquetas a
USING public.receta_etiquetas b
WHERE a.receta_id = b.receta_id
  AND a.etiqueta IN ('omnívora','pescetariana')
  AND b.etiqueta IN ('vegetariana','vegana');

COMMIT;

-- Comprobaciones sugeridas:
-- SELECT receta_id, string_agg(etiqueta, ', ' ORDER BY etiqueta) AS tags
-- FROM public.receta_etiquetas GROUP BY 1 ORDER BY 1;
