-- Normalizar todas las etiquetas existentes a minúsculas para evitar duplicados
-- y eliminar duplicados case-insensitive

do $$
begin
  -- Primero eliminar duplicados case-insensitive (mantener el de menor id)
  delete from public.receta_etiquetas a
  using public.receta_etiquetas b
  where a.id > b.id
    and a.receta_id = b.receta_id
    and lower(a.etiqueta) = lower(b.etiqueta);
  
  -- Luego normalizar todas las etiquetas restantes a minúsculas
  update public.receta_etiquetas
  set etiqueta = lower(etiqueta);
  
  raise notice 'Etiquetas normalizadas correctamente';
end $$;
