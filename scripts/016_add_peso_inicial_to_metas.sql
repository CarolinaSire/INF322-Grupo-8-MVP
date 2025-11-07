-- Agregar campo peso_inicial a metas_salud
ALTER TABLE public.metas_salud ADD COLUMN IF NOT EXISTS peso_inicial numeric(5,2);

-- Migrar datos existentes: establecer peso_inicial basado en el primer progreso o peso del perfil
DO $$
DECLARE
  meta_record RECORD;
  primer_peso numeric(5,2);
BEGIN
  FOR meta_record IN SELECT id, user_id FROM public.metas_salud WHERE peso_inicial IS NULL
  LOOP
    -- Intentar obtener el peso del primer progreso de esta meta
    SELECT peso INTO primer_peso
    FROM public.progreso_salud
    WHERE meta_id = meta_record.id AND peso IS NOT NULL
    ORDER BY fecha ASC, created_at ASC
    LIMIT 1;
    
    -- Si no hay progreso, usar el peso del perfil
    IF primer_peso IS NULL THEN
      SELECT peso INTO primer_peso
      FROM public.profiles
      WHERE id = meta_record.user_id;
    END IF;
    
    -- Actualizar la meta con el peso inicial
    IF primer_peso IS NOT NULL THEN
      UPDATE public.metas_salud
      SET peso_inicial = primer_peso
      WHERE id = meta_record.id;
    END IF;
  END LOOP;
END $$;
