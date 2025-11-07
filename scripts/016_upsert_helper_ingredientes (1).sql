-- 016_upsert_helper_ingredientes.sql
-- Función helper para hacer idempotentes los seeds de ingredientes.
-- Usa la restricción UNIQUE (nombre_norm) creada en 015_fix_ingredientes_dedup.sql

CREATE OR REPLACE FUNCTION public.upsert_ingrediente(
  _nombre text,
  _calorias numeric,
  _proteinas numeric,
  _carbohidratos numeric,
  _grasas numeric,
  _fibra numeric,
  _categoria text,
  _es_publico boolean DEFAULT true
) RETURNS bigint
LANGUAGE plpgsql
AS $$
DECLARE
  v_id bigint;
BEGIN
  INSERT INTO public.ingredientes
    (nombre, calorias, proteinas, carbohidratos, grasas, fibra, categoria, es_publico)
  VALUES
    (_nombre, _calorias, _proteinas, _carbohidratos, _grasas, _fibra, _categoria, _es_publico)
  ON CONFLICT (nombre_norm) DO UPDATE
  SET calorias      = EXCLUDED.calorias,
      proteinas     = EXCLUDED.proteinas,
      carbohidratos = EXCLUDED.carbohidratos,
      grasas        = EXCLUDED.grasas,
      fibra         = EXCLUDED.fibra,
      categoria     = EXCLUDED.categoria,
      es_publico    = EXCLUDED.es_publico
  RETURNING id INTO v_id;

  RETURN v_id;
END;
$$;

-- Ejemplos de uso en tus seeds:
-- SELECT public.upsert_ingrediente('Leche descremada', 37, 3.7, 5.3, 0.0, 0.0, 'lacteo', true);
-- SELECT public.upsert_ingrediente('Leche en polvo descremada (instantánea)', 341, 34.0, 50.0, 0.8, 0.0, 'lacteo', true);
