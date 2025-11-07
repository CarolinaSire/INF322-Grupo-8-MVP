-- Script para eliminar recetas duplicadas
-- Mantiene solo la receta más antigua (menor ID) de cada nombre duplicado

DO $$
DECLARE
  v_deleted_count integer;
BEGIN
  -- Eliminar recetas duplicadas (mantener la más antigua)
  WITH duplicates AS (
    SELECT 
      id,
      nombre,
      ROW_NUMBER() OVER (PARTITION BY LOWER(TRIM(nombre)) ORDER BY created_at ASC, id ASC) as rn
    FROM public.recetas
  )
  DELETE FROM public.recetas
  WHERE id IN (
    SELECT id FROM duplicates WHERE rn > 1
  );

  GET DIAGNOSTICS v_deleted_count = ROW_COUNT;
  RAISE NOTICE 'Eliminadas % recetas duplicadas', v_deleted_count;

  -- Eliminar ingredientes huérfanos (sin receta)
  DELETE FROM public.receta_ingredientes
  WHERE receta_id NOT IN (SELECT id FROM public.recetas);

  GET DIAGNOSTICS v_deleted_count = ROW_COUNT;
  RAISE NOTICE 'Eliminados % ingredientes huérfanos', v_deleted_count;

  -- Eliminar etiquetas huérfanas (sin receta)
  DELETE FROM public.receta_etiquetas
  WHERE receta_id NOT IN (SELECT id FROM public.recetas);

  GET DIAGNOSTICS v_deleted_count = ROW_COUNT;
  RAISE NOTICE 'Eliminadas % etiquetas huérfanas', v_deleted_count;

  -- Eliminar ingredientes duplicados en la misma receta
  WITH ingredient_duplicates AS (
    SELECT 
      id,
      receta_id,
      ingrediente_id,
      ROW_NUMBER() OVER (PARTITION BY receta_id, ingrediente_id ORDER BY created_at ASC, id ASC) as rn
    FROM public.receta_ingredientes
  )
  DELETE FROM public.receta_ingredientes
  WHERE id IN (
    SELECT id FROM ingredient_duplicates WHERE rn > 1
  );

  GET DIAGNOSTICS v_deleted_count = ROW_COUNT;
  RAISE NOTICE 'Eliminados % ingredientes duplicados en recetas', v_deleted_count;

END $$;
