-- Script para poblar recetas base saludables
-- Este script crea recetas públicas con ingredientes y etiquetas

-- Primero, obtenemos o creamos un usuario del sistema para las recetas públicas
-- Si no existe ningún usuario, las recetas se crearán sin autor (NULL)
do $$
declare
  v_user_id uuid;
  v_receta_id uuid;
  v_ingrediente_id uuid;
begin
  select id into v_user_id from auth.users limit 1;
  
  -- Receta 1: Ensalada Mediterránea
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Ensalada Mediterránea',
    'Ensalada fresca y nutritiva con vegetales y aceite de oliva',
    '1. Lavar y cortar todos los vegetales en trozos medianos. 2. Mezclar en un bowl grande. 3. Agregar aceite de oliva y mezclar bien. 4. Servir fresco.',
    15,
    2,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  -- Ingredientes para Ensalada Mediterránea
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 150.0 as cantidad from public.ingredientes where nombre = 'Tomate'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Lechuga'
    union all
    select id, 50.0 from public.ingredientes where nombre = 'Pepino'
    union all
    select id, 30.0 from public.ingredientes where nombre = 'Cebolla'
    union all
    select id, 15.0 from public.ingredientes where nombre = 'Aceite de oliva'
  ) as ingredientes;
  
  -- Etiquetas para Ensalada Mediterránea
    -- Etiquetas (redefinidas) para Ensalada Mediterránea
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Receta 2: Pollo a la Plancha con Brócoli
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Pollo a la Plancha con Brócoli',
    'Pechuga de pollo saludable acompañada de brócoli al vapor',
    '1. Sazonar la pechuga de pollo. 2. Cocinar a la plancha 6-7 minutos por lado. 3. Cocinar el brócoli al vapor 5 minutos. 4. Servir caliente.',
    25,
    1,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 150.0 as cantidad from public.ingredientes where nombre = 'Pechuga de pollo'
    union all
    select id, 200.0 from public.ingredientes where nombre = 'Brócoli'
    union all
    select id, 10.0 from public.ingredientes where nombre = 'Aceite de oliva'
  ) as ingredientes;
  
    -- Etiquetas (redefinidas) para Pollo a la Plancha con Brócoli
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Receta 3: Bowl de Quinoa y Palta
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Bowl de Quinoa y Palta',
    'Bowl nutritivo con quinoa, palta y vegetales frescos',
    '1. Cocinar el arroz integral según instrucciones. 2. Cortar la palta y vegetales. 3. Mezclar todo en un bowl. 4. Agregar aceite de oliva.',
    30,
    2,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 150.0 as cantidad from public.ingredientes where nombre = 'Arroz integral'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Palta'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Tomate'
    union all
    select id, 50.0 from public.ingredientes where nombre = 'Espinaca'
    union all
    select id, 10.0 from public.ingredientes where nombre = 'Aceite de oliva'
  ) as ingredientes;
  
    -- Etiquetas (redefinidas) para Bowl de Quinoa y Palta
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Receta 4: Salmón al Horno con Espárragos
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Salmón al Horno con Vegetales',
    'Salmón rico en omega-3 con vegetales asados',
    '1. Precalentar horno a 180°C. 2. Colocar el salmón en una bandeja. 3. Agregar vegetales alrededor. 4. Rociar con aceite de oliva. 5. Hornear 20 minutos.',
    35,
    1,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 150.0 as cantidad from public.ingredientes where nombre = 'Salmón'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Brócoli'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Zanahoria'
    union all
    select id, 15.0 from public.ingredientes where nombre = 'Aceite de oliva'
  ) as ingredientes;
  
    -- Etiquetas (redefinidas) para Salmón al Horno con Vegetales
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'pescetariana'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Receta 5: Avena con Frutas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Avena con Frutas y Frutos Secos',
    'Desayuno energético con avena, frutas frescas y almendras',
    '1. Cocinar la avena con leche descremada. 2. Cortar las frutas. 3. Servir la avena caliente con frutas encima. 4. Agregar almendras picadas.',
    10,
    1,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 50.0 as cantidad from public.ingredientes where nombre = 'Avena'
    union all
    select id, 200.0 from public.ingredientes where nombre = 'Leche descremada'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Plátano'
    union all
    select id, 50.0 from public.ingredientes where nombre = 'Fresa'
    union all
    select id, 20.0 from public.ingredientes where nombre = 'Almendras'
  ) as ingredientes;
  
    -- Etiquetas (redefinidas) para Avena con Frutas y Frutos Secos
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'desayuno'),
    (v_receta_id, 'vegetariana');
-- Receta 6: Ensalada de Lentejas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Ensalada de Lentejas',
    'Ensalada proteica con lentejas y vegetales frescos',
    '1. Cocinar las lentejas hasta que estén tiernas. 2. Dejar enfriar. 3. Mezclar con vegetales picados. 4. Aliñar con aceite de oliva.',
    40,
    3,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 200.0 as cantidad from public.ingredientes where nombre = 'Lentejas'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Tomate'
    union all
    select id, 50.0 from public.ingredientes where nombre = 'Cebolla'
    union all
    select id, 50.0 from public.ingredientes where nombre = 'Pimiento'
    union all
    select id, 15.0 from public.ingredientes where nombre = 'Aceite de oliva'
  ) as ingredientes;
  
    -- Etiquetas (redefinidas) para Ensalada de Lentejas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Receta 7: Tortilla de Espinacas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Tortilla de Espinacas',
    'Tortilla proteica con espinacas frescas',
    '1. Batir los huevos. 2. Saltear las espinacas. 3. Agregar los huevos a la sartén. 4. Cocinar hasta que cuaje. 5. Voltear y cocinar el otro lado.',
    15,
    1,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 100.0 as cantidad from public.ingredientes where nombre = 'Huevo'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Espinaca'
    union all
    select id, 10.0 from public.ingredientes where nombre = 'Aceite de oliva'
  ) as ingredientes;
  
    -- Etiquetas (redefinidas) para Tortilla de Espinacas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'desayuno'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegetariana');
-- Receta 8: Smoothie Verde
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Smoothie Verde Energético',
    'Batido nutritivo con espinacas, plátano y frutas',
    '1. Colocar todos los ingredientes en la licuadora. 2. Licuar hasta obtener consistencia suave. 3. Servir inmediatamente.',
    5,
    1,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 50.0 as cantidad from public.ingredientes where nombre = 'Espinaca'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Plátano'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Manzana'
    union all
    select id, 200.0 from public.ingredientes where nombre = 'Leche descremada'
  ) as ingredientes;
  
    -- Etiquetas (redefinidas) para Smoothie Verde Energético
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'desayuno'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'vegetariana');
-- Receta 9: Tofu Salteado con Vegetales
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Tofu Salteado con Vegetales',
    'Plato vegano rico en proteínas con tofu y vegetales coloridos',
    '1. Cortar el tofu en cubos. 2. Saltear en aceite hasta dorar. 3. Agregar vegetales cortados. 4. Cocinar 5-7 minutos. 5. Servir caliente.',
    20,
    2,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 200.0 as cantidad from public.ingredientes where nombre = 'Tofu'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Brócoli'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Pimiento'
    union all
    select id, 50.0 from public.ingredientes where nombre = 'Zanahoria'
    union all
    select id, 15.0 from public.ingredientes where nombre = 'Aceite de oliva'
  ) as ingredientes;
  
    -- Etiquetas (redefinidas) para Tofu Salteado con Vegetales
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Receta 10: Yogur con Frutas y Granola
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Yogur con Frutas y Granola',
    'Desayuno o snack saludable con yogur natural y frutas frescas',
    '1. Servir el yogur en un bowl. 2. Cortar las frutas. 3. Agregar frutas sobre el yogur. 4. Espolvorear avena y frutos secos encima.',
    5,
    1,
    true,
    v_user_id
  ) returning id into v_receta_id;
  
  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 200.0 as cantidad from public.ingredientes where nombre = 'Yogur natural'
    union all
    select id, 100.0 from public.ingredientes where nombre = 'Fresa'
    union all
    select id, 50.0 from public.ingredientes where nombre = 'Plátano'
    union all
    select id, 30.0 from public.ingredientes where nombre = 'Avena'
    union all
    select id, 20.0 from public.ingredientes where nombre = 'Almendras'
  ) as ingredientes;
  
    -- Etiquetas (redefinidas) para Yogur con Frutas y Granola
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'desayuno'),
    (v_receta_id, 'vegetariana');
-- Carbonada
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Carbonada',
    'Guiso/sopa tradicional con carne, papas, zapallo, arroz y verduras.',
    '1. Sofreír cebolla y ajo en aceite. 2. Agregar carne en cubos y dorar. 3. Incorporar zanahoria, papas, zapallo, choclo y arvejas; cubrir con agua o caldo. 4. Añadir arroz, aliñar y cocinar a fuego medio hasta que todo esté tierno.',
    55, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 300.0 as cantidad from public.ingredientes where nombre = 'Carne de vacuno'
    union all select id, 300.0 from public.ingredientes where nombre = 'Papa'
    union all select id, 250.0 from public.ingredientes where nombre = 'Zapallo'
    union all select id, 150.0 from public.ingredientes where nombre = 'Zanahoria'
    union all select id, 150.0 from public.ingredientes where nombre = 'Choclo'
    union all select id, 100.0 from public.ingredientes where nombre = 'Arvejas'
    union all select id, 60.0  from public.ingredientes where nombre = 'Arroz'
    union all select id, 120.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 10.0  from public.ingredientes where nombre = 'Ajo'
    union all select id, 15.0  from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Carbonada
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Cazuela de Pollo
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Cazuela de Pollo',
    'Caldo con presa de pollo, papa, zapallo y choclo.',
    '1. Sellar el pollo. 2. Agregar cebolla, zanahoria y aliños; cubrir con agua. 3. Añadir papas, zapallo y choclo; hervir suave hasta que todo esté tierno. 4. Servir con cilantro.',
    60, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Pechuga de pollo'
    union all select id, 400.0 from public.ingredientes where nombre = 'Papa'
    union all select id, 300.0 from public.ingredientes where nombre = 'Zapallo'
    union all select id, 200.0 from public.ingredientes where nombre = 'Choclo'
    union all select id, 150.0 from public.ingredientes where nombre = 'Zanahoria'
    union all select id, 120.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 10.0  from public.ingredientes where nombre = 'Ajo'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Cazuela de Pollo
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Charquicán
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Charquicán',
    'Guiso espeso de zapallo y papa con pino (carne/cebolla) y choclo.',
    '1. Sofreír cebolla con ají de color y comino. 2. Agregar carne molida y dorar. 3. Incorporar papa y zapallo en cubos; cubrir con agua/caldo y cocinar. 4. Añadir choclo y arvejas; aplastar levemente para espesar.',
    50, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 350.0 as cantidad from public.ingredientes where nombre = 'Carne molida'
    union all select id, 500.0 from public.ingredientes where nombre = 'Papa'
    union all select id, 500.0 from public.ingredientes where nombre = 'Zapallo'
    union all select id, 200.0 from public.ingredientes where nombre = 'Choclo'
    union all select id, 120.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 80.0  from public.ingredientes where nombre = 'Arvejas'
    union all select id, 6.0   from public.ingredientes where nombre = 'Ají de color'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Charquicán
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Pastel de Choclo
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Pastel de Choclo',
    'Clásico con pino (carne/cebolla), pollo, huevo, aceituna y cubierta de choclo con albahaca.',
    '1. Preparar pino (cebolla + carne + aliños). 2. Procesar choclo con leche/manteca y albahaca; cocinar hasta espesar. 3. Montar fuente con pino, pollo, huevo, aceituna y pasas; cubrir con pastelera. 4. Hornear hasta dorar.',
    90, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 500.0 as cantidad from public.ingredientes where nombre = 'Choclo'
    union all select id, 300.0 from public.ingredientes where nombre = 'Carne molida'
    union all select id, 200.0 from public.ingredientes where nombre = 'Pollo cocido desmenuzado'
    union all select id, 200.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 4.0   from public.ingredientes where nombre = 'Huevo'
    union all select id, 80.0  from public.ingredientes where nombre = 'Aceitunas grandes'
    union all select id, 80.0  from public.ingredientes where nombre = 'Pasas'
    union all select id, 10.0  from public.ingredientes where nombre = 'Albahaca'
    union all select id, 20.0  from public.ingredientes where nombre = 'Manteca'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Pastel de Choclo
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'sin_gluten');
-- Humitas Chilena
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Humitas Chilena',
    'Pasta de choclo con cebolla, albahaca y leche, envuelta en hojas.',
    '1. Moler choclo con leche y albahaca. 2. Sofreír cebolla con manteca/ají de color. 3. Mezclar, ajustar sal y rellenar las pailas/hojas. 4. Cocer en agua hirviendo o al vapor.',
    90, 8, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 1000.0 as cantidad from public.ingredientes where nombre = 'Choclo'
    union all select id, 300.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 300.0 from public.ingredientes where nombre = 'Leche'
    union all select id, 20.0  from public.ingredientes where nombre = 'Manteca'
    union all select id, 8.0   from public.ingredientes where nombre = 'Ají de color'
    union all select id, 10.0  from public.ingredientes where nombre = 'Albahaca'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Humitas Chilena
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'vegetariana');
-- Tomaticán
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Tomaticán',
    'Salteado/guiso de tomate, cebolla y choclo; puede llevar carne.',
    '1. Sofreír cebolla. 2. Agregar tomate en cubos y choclo; cocinar. 3. (Opcional) añadir tiras de carne; aliñar con comino/orégano. 4. Servir con arroz o papas.',
    35, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 500.0 as cantidad from public.ingredientes where nombre = 'Tomate'
    union all select id, 250.0 from public.ingredientes where nombre = 'Choclo'
    union all select id, 150.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 300.0 from public.ingredientes where nombre = 'Carne de vacuno'
    union all select id, 5.0   from public.ingredientes where nombre = 'Orégano'
    union all select id, 3.0   from public.ingredientes where nombre = 'Comino'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Tomaticán
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Porotos con Rienda
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Porotos con Rienda',
    'Porotos con zapallo y tiras de fideo; a veces con longaniza.',
    '1. Cocer porotos remojados con cebolla/ajo. 2. Agregar zapallo en cubos y cocinar. 3. Añadir fideos (rienda) y, opcional, longaniza salteada. 4. Rectificar sazón.',
    70, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 500.0 as cantidad from public.ingredientes where nombre = 'Porotos'
    union all select id, 300.0 from public.ingredientes where nombre = 'Zapallo'
    union all select id, 150.0 from public.ingredientes where nombre = 'Fideos'
    union all select id, 150.0 from public.ingredientes where nombre = 'Longaniza'
    union all select id, 120.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 10.0  from public.ingredientes where nombre = 'Ajo'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Porotos con Rienda
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'sin_lactosa');
-- Lentejas Chilenas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Lentejas Chilenas',
    'Guiso de lentejas con sofrito y verduras; puede llevar arroz.',
    '1. Sofreír cebolla, zanahoria y ajo. 2. Agregar lentejas y cubrir con caldo; cocinar a fuego bajo. 3. (Opcional) añadir un puñado de arroz al final.',
    45, 5, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 400.0 as cantidad from public.ingredientes where nombre = 'Lentejas'
    union all select id, 150.0 from public.ingredientes where nombre = 'Zanahoria'
    union all select id, 150.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 10.0  from public.ingredientes where nombre = 'Ajo'
    union all select id, 60.0  from public.ingredientes where nombre = 'Arroz'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Lentejas Chilenas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Sopaipillas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Sopaipillas',
    'Masa frita de harina y zapallo, ideal con pebre o chancaca.',
    '1. Cocer y moler zapallo. 2. Mezclar con harina, sal, manteca y agua tibia; amasar. 3. Uslerear, cortar y freír hasta dorar.',
    50, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 500.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'
    union all select id, 300.0 from public.ingredientes where nombre = 'Zapallo'
    union all select id, 50.0  from public.ingredientes where nombre = 'Manteca'
    union all select id, 500.0 from public.ingredientes where nombre = 'Aceite vegetal'
    union all select id, 8.0   from public.ingredientes where nombre = 'Sal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Sopaipillas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'vegetariana');
-- Empanadas de Pino
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Empanadas de pino',
    'Empanada tradicional con pino de carne y cebolla; lleva huevo, aceituna y pasas.',
    '1. Masa: harina, manteca, agua y sal; reposar. 2. Pino: sofreír cebolla, agregar carne y aliños. 3. Rellenar con pino, huevo, aceituna y pasa; hornear.',
    120, 12, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 800.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'
    union all select id, 120.0 from public.ingredientes where nombre = 'Manteca'
    union all select id, 600.0 from public.ingredientes where nombre = 'Carne molida'
    union all select id, 600.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 6.0   from public.ingredientes where nombre = 'Huevo'
    union all select id, 100.0 from public.ingredientes where nombre = 'Aceitunas grandes'
    union all select id, 100.0 from public.ingredientes where nombre = 'Pasas'
    union all select id, 8.0   from public.ingredientes where nombre = 'Ají de color'
    union all select id, 4.0   from public.ingredientes where nombre = 'Comino'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Empanadas de pino
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'sin_lactosa');
-- Machas a la Parmesana
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Machas a la parmesana',
    'Machas gratinadas con mantequilla, ajo, vino blanco y queso.',
    '1. Disponer machas en sus conchas. 2. Cubrir con mantequilla, ajo y un chorrito de vino. 3. Espolvorear queso y gratinar hasta dorar.',
    25, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 500.0 as cantidad from public.ingredientes where nombre = 'Machas'
    union all select id, 50.0  from public.ingredientes where nombre = 'Mantequilla'
    union all select id, 8.0   from public.ingredientes where nombre = 'Ajo'
    union all select id, 80.0  from public.ingredientes where nombre = 'Queso parmesano'
    union all select id, 60.0  from public.ingredientes where nombre = 'Vino blanco'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Machas a la parmesana
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'vegetariana');
-- Ceviche Chileno
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Ceviche Chileno',
    'Pescado blanco marinado en jugo de limón con cebolla, cilantro y ají.',
    '1. Cortar pescado en cubos; cubrir con jugo de limón. 2. Añadir cebolla pluma lavada, cilantro y ají; refrigerar 20–30 min. 3. Servir.',
    35, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Pescado blanco'
    union all select id, 250.0 from public.ingredientes where nombre = 'Limón'
    union all select id, 200.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 40.0  from public.ingredientes where nombre = 'Cilantro'
    union all select id, 30.0  from public.ingredientes where nombre = 'Ají verde'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Ceviche Chileno
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'pescetariana'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Chorrillana
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Chorrillana',
    'Papas fritas con carne salteada, cebolla, longaniza y huevos.',
    '1. Freír papas. 2. Saltear cebolla, carne y longaniza. 3. Servir sobre las papas y coronar con huevos fritos.',
    45, 3, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 800.0 as cantidad from public.ingredientes where nombre = 'Papa'
    union all select id, 300.0 from public.ingredientes where nombre = 'Carne de vacuno'
    union all select id, 200.0 from public.ingredientes where nombre = 'Longaniza'
    union all select id, 200.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 4.0   from public.ingredientes where nombre = 'Huevo'
    union all select id, 500.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Chorrillana
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Chupe de Mariscos
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Chupe de mariscos',
    'Cazuela espesa de mariscos con pan remojado/leche y gratinado.',
    '1. Sofreír cebolla. 2. Hacer roux con mantequilla/harina; agregar caldo, leche y vino. 3. Mezclar mariscos y pan remojado; ajustar sazón. 4. Cubrir con queso y gratinar.',
    60, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Mariscos surtidos'
    union all select id, 200.0 from public.ingredientes where nombre = 'Pan'
    union all select id, 400.0 from public.ingredientes where nombre = 'Leche'
    union all select id, 120.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 40.0  from public.ingredientes where nombre = 'Mantequilla'
    union all select id, 40.0  from public.ingredientes where nombre = 'Harina de trigo'
    union all select id, 80.0  from public.ingredientes where nombre = 'Queso'
    union all select id, 60.0  from public.ingredientes where nombre = 'Vino blanco'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Chupe de mariscos
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'pescetariana');
-- Pastel de Jaiba
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Pastel de Jaiba',
    'Jaiba salteada con sofrito y pan remojado, cremosa y gratinada.',
    '1. Sofreír cebolla/ajo con ají de color y comino. 2. Agregar jaiba y vino; reducir. 3. Incorporar pan remojado en leche y crema; ajustar. 4. Cubrir con queso y gratinar.',
    55, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 450.0 as cantidad from public.ingredientes where nombre = 'Carne de jaiba'
    union all select id, 200.0 from public.ingredientes where nombre = 'Pan'
    union all select id, 250.0 from public.ingredientes where nombre = 'Leche'
    union all select id, 150.0 from public.ingredientes where nombre = 'Crema'
    union all select id, 150.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 50.0  from public.ingredientes where nombre = 'Queso'
    union all select id, 60.0  from public.ingredientes where nombre = 'Vino blanco'
    union all select id, 6.0   from public.ingredientes where nombre = 'Ají de color'
    union all select id, 3.0   from public.ingredientes where nombre = 'Comino'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Pastel de Jaiba
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'omnivora');
-- Ensalada Chilena
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Ensalada Chilena',
    'Tomate en gajos con cebolla pluma (lavada), aliñada con aceite y vinagre; ají verde opcional.',
    '1. Lavar y cortar tomates. 2. Cebolla a la pluma y lavar para suavizar. 3. Mezclar, aliñar con aceite, vinagre, sal y pimienta.',
    15, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Tomate'
    union all select id, 200.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 30.0  from public.ingredientes where nombre = 'Aceite vegetal'
    union all select id, 15.0  from public.ingredientes where nombre = 'Vinagre'
    union all select id, 30.0  from public.ingredientes where nombre = 'Ají verde'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Ensalada Chilena
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Pebre chileno
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Pebre chileno',
    'Salsa de cilantro, cebolla, tomate, ají, aceite y vinagre.',
    '1. Picar finamente cebolla, cilantro, tomate y ají. 2. Aliñar con aceite, vinagre y sal. 3. Reposar 10 minutos.',
    10, 10, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 150.0 as cantidad from public.ingredientes where nombre = 'Cilantro'
    union all select id, 120.0 from public.ingredientes where nombre = 'Cebolla'
    union all select id, 120.0 from public.ingredientes where nombre = 'Tomate'
    union all select id, 50.0  from public.ingredientes where nombre = 'Ají verde'
    union all select id, 30.0  from public.ingredientes where nombre = 'Aceite vegetal'
    union all select id, 20.0  from public.ingredientes where nombre = 'Vinagre'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Pebre chileno
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Completo Chileno
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Completo Chileno',
    'Hot-dog con tomate, palta, chucrut y mayonesa (“italiano”).',
    '1. Calentar salchichas y pan. 2. Armar con tomate en cubos, palta molida, chucrut y mayonesa.',
    15, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 4.0 as cantidad from public.ingredientes where nombre = 'Pan de hotdog'
    union all select id, 4.0   from public.ingredientes where nombre = 'Salchicha'
    union all select id, 250.0 from public.ingredientes where nombre = 'Tomate'
    union all select id, 250.0 from public.ingredientes where nombre = 'Palta'
    union all select id, 150.0 from public.ingredientes where nombre = 'Chucrut'
    union all select id, 120.0 from public.ingredientes where nombre = 'Mayonesa'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Completo Chileno
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'omnivora');
-- Chacarero
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Chacarero',
    'Sándwich de carne en marraqueta con porotos verdes, tomate y ají.',
    '1. Saltear láminas de carne. 2. Armar en pan con porotos verdes blanqueados, tomate y ají; añadir mayonesa a gusto.',
    20, 2, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 250.0 as cantidad from public.ingredientes where nombre = 'Carne de vacuno'
    union all select id, 200.0 from public.ingredientes where nombre = 'Porotos verdes'
    union all select id, 150.0 from public.ingredientes where nombre = 'Tomate'
    union all select id, 2.0   from public.ingredientes where nombre = 'Marraqueta'
    union all select id, 60.0  from public.ingredientes where nombre = 'Mayonesa'
    union all select id, 30.0  from public.ingredientes where nombre = 'Ají verde'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Chacarero
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'omnivora');
-- Churrasco Italiano
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Churrasco Italiano',
    'Sándwich de carne con tomate, palta y mayonesa.',
    '1. Sellar láminas de lomo. 2. Armar en pan con tomate, palta y mayonesa.',
    20, 2, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 250.0 as cantidad from public.ingredientes where nombre = 'Lomo de vacuno'
    union all select id, 150.0 from public.ingredientes where nombre = 'Tomate'
    union all select id, 150.0 from public.ingredientes where nombre = 'Palta'
    union all select id, 2.0   from public.ingredientes where nombre = 'Pan'
    union all select id, 60.0  from public.ingredientes where nombre = 'Mayonesa'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Churrasco Italiano
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'omnivora');
-- Budín de Coliflor
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Budín de Coliflor'::text, 'Budín al horno de coliflor con queso y huevo.'::text, '1. Cocer coliflor y picar. 2. Mezclar con queso, huevo, sofrito de cebolla y condimentos. 3. Llevar a fuente y hornear hasta cuajar y dorar.'::text, 60, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 700.0 as cantidad from public.ingredientes where nombre = 'Coliflor'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Queso'    
    union all 
    select id, 4.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 120.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Leche'    
    union all 
    select id, 20.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Budín de Coliflor
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'vegetariana');
-- Budín de Zapallitos
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Budín de Zapallitos'::text, 'Budín suave de zapallo italiano con queso.'::text, '1. Rallar o picar zapallitos y saltear brevemente. 2. Mezclar con huevo, queso y condimentos. 3. Hornear hasta dorar.'::text, 55, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 700.0 as cantidad from public.ingredientes where nombre = 'Zapallo italiano'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Queso'    
    union all 
    select id, 4.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 100.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 20.0 from public.ingredientes where nombre = 'Aceite vegetal'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Leche'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Budín de Zapallitos
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'vegetariana');
-- Fritos de Coliflor
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Fritos de Coliflor'::text, 'Bocaditos fritos de coliflor rebozada.'::text, '1. Cocer coliflor en ramitos. 2. Pasar por batido de harina y huevo. 3. Freír hasta dorar.'::text, 40, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Coliflor'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 2.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 600.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Fritos de Coliflor
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegetariana');
-- Guiso de Quinoa
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Guiso de Quinoa'::text, 'Guiso vegetariano de quinoa con verduras.'::text, '1. Sofreír cebolla, ajo y zanahoria. 2. Agregar quinoa lavada y caldo. 3. Incorporar zapallo y arvejas; cocinar a punto.'::text, 40, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 200.0 as cantidad from public.ingredientes where nombre = 'Quinoa'    
    union all 
    select id, 120.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 10.0 from public.ingredientes where nombre = 'Ajo'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Zanahoria'    
    union all 
    select id, 250.0 from public.ingredientes where nombre = 'Zapallo'    
    union all 
    select id, 120.0 from public.ingredientes where nombre = 'Arvejas'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Guiso de Quinoa
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Tortilla de Choclo
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Tortilla de Choclo'::text, 'Tortilla de choclo cuajada en sartén.'::text, '1. Saltear choclo y cebolla. 2. Mezclar con huevo y albahaca. 3. Cuajar por ambos lados en sartén.'::text, 25, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 350.0 as cantidad from public.ingredientes where nombre = 'Choclo'    
    union all 
    select id, 80.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 4.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 20.0 from public.ingredientes where nombre = 'Aceite vegetal'    
    union all 
    select id, 6.0 from public.ingredientes where nombre = 'Albahaca'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Tortilla de Choclo
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'desayuno'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegetariana');
-- Tortilla de Espinacas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Tortilla de Espinacas'::text, 'Tortilla verde con espinacas.'::text, '1. Saltear espinacas. 2. Mezclar con huevo batido y cuajar en sartén.'::text, 20, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 300.0 as cantidad from public.ingredientes where nombre = 'Espinaca'    
    union all 
    select id, 4.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 20.0 from public.ingredientes where nombre = 'Aceite vegetal'    
    union all 
    select id, 60.0 from public.ingredientes where nombre = 'Cebolla'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Tortilla de Espinacas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'desayuno'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegetariana');
-- Tortilla de Porotos Verdes
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Tortilla de Porotos Verdes'::text, 'Tortilla con porotos verdes blanqueados.'::text, '1. Blanquear porotos verdes. 2. Mezclar con huevo y cuajar en sartén.'::text, 20, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 300.0 as cantidad from public.ingredientes where nombre = 'Porotos verdes'    
    union all 
    select id, 4.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 20.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Tortilla de Porotos Verdes
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'desayuno'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegetariana');
-- Tortilla de Zapallitos Italianos
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Tortilla de Zapallitos Italianos'::text, 'Tortilla jugosa de zapallo italiano.'::text, '1. Saltear zapallo italiano y cebolla. 2. Mezclar con huevo y cuajar.'::text, 20, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 350.0 as cantidad from public.ingredientes where nombre = 'Zapallo italiano'    
    union all 
    select id, 80.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 4.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 20.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Tortilla de Zapallitos Italianos
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'desayuno'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegetariana');
-- Anticucho
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Anticucho'::text, 'Brochetas de carne con longaniza y verduras.'::text, '1. Cortar carne y verduras en cubos; marinar. 2. Enfierrar alternando con longaniza. 3. Asar a la parrilla.'::text, 45, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Carne de vacuno'    
    union all 
    select id, 250.0 from public.ingredientes where nombre = 'Longaniza'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Pimiento'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Cebolla'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Anticucho
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Causeo Chileno
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Causeo Chileno'::text, 'Ensalada rústica de papas cocidas con cebolla, tomate y ají.'::text, '1. Cocer papas y cortar en trozos. 2. Mezclar con cebolla pluma, tomate y ají; aliñar con aceite y vinagre.'::text, 25, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Papa'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 300.0 from public.ingredientes where nombre = 'Tomate'    
    union all 
    select id, 40.0 from public.ingredientes where nombre = 'Ají verde'    
    union all 
    select id, 30.0 from public.ingredientes where nombre = 'Aceite vegetal'    
    union all 
    select id, 20.0 from public.ingredientes where nombre = 'Vinagre'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Causeo Chileno
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Empanadas de locos
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Empanadas de locos'::text, 'Empanadas horneadas rellenas de locos con sofrito.'::text, '1. Masa base de harina, agua y grasa. 2. Relleno de locos salteados con cebolla y aliños. 3. Hornear hasta dorar.'::text, 120, 12, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 800.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 120.0 from public.ingredientes where nombre = 'Manteca'    
    union all 
    select id, 600.0 from public.ingredientes where nombre = 'Locos'    
    union all 
    select id, 300.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 6.0 from public.ingredientes where nombre = 'Ají de color'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Empanadas de locos
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'pescetariana');
-- Empanadas de queso
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Empanadas de queso'::text, 'Empanadas fritas u horneadas con relleno de queso fundido.'::text, '1. Preparar masa. 2. Rellenar con queso. 3. Freír u hornear hasta dorar.'::text, 60, 12, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 800.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 600.0 from public.ingredientes where nombre = 'Queso'    
    union all 
    select id, 600.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Empanadas de queso
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'vegetariana');
-- Papas rellenas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Papas rellenas'::text, 'Croquetas de papa con relleno de pino.'::text, '1. Hacer puré espeso de papa. 2. Rellenar con pino de carne. 3. Cerrar, pasar por batido y freír.'::text, 70, 8, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 1000.0 as cantidad from public.ingredientes where nombre = 'Papa'    
    union all 
    select id, 400.0 from public.ingredientes where nombre = 'Carne molida'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 2.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 100.0 from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 800.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Papas rellenas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'sin_lactosa');
-- Barros Lucos
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Barros Lucos'::text, 'Sándwich de carne y queso caliente.'::text, '1. Sellar carne a la plancha. 2. Armar en marraqueta con queso fundido.'::text, 15, 2, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 2.0 as cantidad from public.ingredientes where nombre = 'Marraqueta'    
    union all 
    select id, 250.0 from public.ingredientes where nombre = 'Lomo de vacuno'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Queso'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Barros Lucos
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'omnivora');
-- Estofado
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Estofado'::text, 'Guiso de carne con papas y verduras cocinado lento.'::text, '1. Dorar carne con cebolla y ajo. 2. Agregar papas, zanahoria, vino y caldo; cocinar lento hasta tierno.'::text, 80, 5, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Carne de vacuno'    
    union all 
    select id, 600.0 from public.ingredientes where nombre = 'Papa'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Zanahoria'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 120.0 from public.ingredientes where nombre = 'Vino tinto'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Estofado
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Guiso de Acelga
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Guiso de Acelga'::text, 'Guiso cremoso de acelga con papas.'::text, '1. Sofreír cebolla. 2. Agregar acelga picada y papas en cubos; cocinar con caldo. 3. Terminar con un toque de leche.'::text, 40, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 400.0 as cantidad from public.ingredientes where nombre = 'Acelga'    
    union all 
    select id, 400.0 from public.ingredientes where nombre = 'Papa'    
    union all 
    select id, 120.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Leche'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Guiso de Acelga
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'vegetariana');
-- Pastel de Papas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Pastel de Papas'::text, 'Capas de puré de papa con pino de carne, al horno.'::text, '1. Preparar pino. 2. Hacer puré de papa. 3. Armar capas y hornear hasta dorar.'::text, 70, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 1200.0 as cantidad from public.ingredientes where nombre = 'Papa'    
    union all 
    select id, 500.0 from public.ingredientes where nombre = 'Carne molida'    
    union all 
    select id, 250.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 3.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 80.0 from public.ingredientes where nombre = 'Aceituna negra'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Pastel de Papas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
-- Alfajores Chilenos
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Alfajores Chilenos'::text, 'Galletas finas rellenas con manjar, espolvoreadas con azúcar flor.'::text, '1. Masa de harina, yemas y mantequilla. 2. Hornear tapas delgadas. 3. Rellenar con manjar.'::text, 90, 20, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Mantequilla'    
    union all 
    select id, 4.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Azúcar'    
    union all 
    select id, 400.0 from public.ingredientes where nombre = 'Manjar'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Alfajores Chilenos
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'postre'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegetariana');
-- Alfajores de Maicena
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Alfajores de Maicena'::text, 'Tapas de maicena y harina, rellenas con manjar y coco opcional.'::text, '1. Masa con maicena, harina y mantequilla. 2. Hornear y rellenar con manjar.'::text, 90, 20, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 400.0 as cantidad from public.ingredientes where nombre = 'Maicena'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Mantequilla'    
    union all 
    select id, 3.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 400.0 from public.ingredientes where nombre = 'Manjar'    
    union all 
    select id, 80.0 from public.ingredientes where nombre = 'Coco rallado'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Alfajores de Maicena
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'postre'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegetariana');
-- Berlines
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Berlines'::text, 'Bollos fritos u horneados rellenos de crema o manjar.'::text, '1. Masa leudada. 2. Formar y fermentar. 3. Freír u hornear y rellenar.'::text, 120, 12, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 250.0 from public.ingredientes where nombre = 'Leche'    
    union all 
    select id, 3.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 80.0 from public.ingredientes where nombre = 'Mantequilla'    
    union all 
    select id, 120.0 from public.ingredientes where nombre = 'Azúcar'    
    union all 
    select id, 8.0 from public.ingredientes where nombre = 'Levadura'    
    union all 
    select id, 800.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Berlines
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'postre'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegetariana');
-- Brazo de Reina
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Brazo de Reina'::text, 'Brazo de bizcocho enrollado con manjar y coco.'::text, '1. Bizcochuelo delgado. 2. Rellenar con manjar y enrollar. 3. Cubrir con coco.'::text, 70, 10, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 200.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 6.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Azúcar'    
    union all 
    select id, 400.0 from public.ingredientes where nombre = 'Manjar'    
    union all 
    select id, 80.0 from public.ingredientes where nombre = 'Coco rallado'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Brazo de Reina
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'postre'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegetariana');
-- Calzones Rotos
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Calzones Rotos'::text, 'Masa dulce frita espolvoreada con azúcar flor.'::text, '1. Amasar con harina, huevo y mantequilla. 2. Estirar, cortar y freír.'::text, 45, 10, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 500.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 3.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 60.0 from public.ingredientes where nombre = 'Mantequilla'    
    union all 
    select id, 80.0 from public.ingredientes where nombre = 'Azúcar'    
    union all 
    select id, 800.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Calzones Rotos
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'vegetariana');
-- Cocadas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Cocadas'::text, 'Bocaditos de coco y leche condensada, horneados.'::text, '1. Mezclar coco con leche condensada y huevo. 2. Formar y hornear.'::text, 35, 12, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 300.0 as cantidad from public.ingredientes where nombre = 'Coco rallado'    
    union all 
    select id, 400.0 from public.ingredientes where nombre = 'Leche condensada'    
    union all 
    select id, 2.0 from public.ingredientes where nombre = 'Huevo'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Cocadas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'postre'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegetariana');
-- Empolvados
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Empolvados'::text, 'Galletas aireadas rellenas de manjar y espolvoreadas con azúcar.'::text, '1. Batir y formar tapas aireadas. 2. Hornear y rellenar con manjar.'::text, 60, 16, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 300.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Maicena'    
    union all 
    select id, 6.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Azúcar'    
    union all 
    select id, 400.0 from public.ingredientes where nombre = 'Manjar'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Empolvados
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'postre'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegetariana');
-- Panqueques con Manjar
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Panqueques con Manjar'::text, 'Panqueques delgados rellenos de manjar.'::text, '1. Batir masa de panqueques. 2. Cocinar en sartén. 3. Rellenar con manjar.'::text, 35, 8, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 250.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 300.0 from public.ingredientes where nombre = 'Leche'    
    union all 
    select id, 3.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 40.0 from public.ingredientes where nombre = 'Mantequilla'    
    union all 
    select id, 300.0 from public.ingredientes where nombre = 'Manjar'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Panqueques con Manjar
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'desayuno'),
    (v_receta_id, 'postre'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegetariana');
-- Picarones
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Picarones'::text, 'Aros fritos de zapallo y harina, con chancaca.'::text, '1. Hacer masa con puré de zapallo y harina. 2. Fermentar. 3. Freír y bañar con chancaca.'::text, 90, 10, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 400.0 as cantidad from public.ingredientes where nombre = 'Zapallo'    
    union all 
    select id, 500.0 from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 8.0 from public.ingredientes where nombre = 'Levadura'    
    union all 
    select id, 300.0 from public.ingredientes where nombre = 'Chancaca'    
    union all 
    select id, 1000.0 from public.ingredientes where nombre = 'Aceite vegetal'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Picarones
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'postre'),
    (v_receta_id, 'sin_lactosa'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Pie de Limón
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Pie de Limón'::text, 'Base de galletas o masa, relleno de limón y merengue.'::text, '1. Preparar base. 2. Hacer crema de limón. 3. Cubrir con merengue y hornear.'::text, 70, 10, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 250.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 120.0 from public.ingredientes where nombre = 'Mantequilla'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Azúcar'    
    union all 
    select id, 4.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Limón'    
    union all 
    select id, 400.0 from public.ingredientes where nombre = 'Leche condensada'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Pie de Limón
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'postre'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegetariana');
-- Betarragas rellenas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Betarragas rellenas'::text, 'Betarragas cocidas rellenas con ensalada/atún o huevo.'::text, '1. Cocer betarragas y ahuecar. 2. Rellenar con mezcla a gusto (atún, huevo, mayo, verduras).'::text, 40, 4, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 600.0 as cantidad from public.ingredientes where nombre = 'Betarraga'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Atún'    
    union all 
    select id, 2.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 100.0 from public.ingredientes where nombre = 'Mayonesa'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Betarragas rellenas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'alta_en_proteinas'),
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'paleo'),
    (v_receta_id, 'pescetariana'),
    (v_receta_id, 'sin_gluten');
-- Ensalada Rusa
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Ensalada Rusa'::text, 'Ensalada de papas, zanahoria, arvejas y mayo.'::text, '1. Cocer papas y zanahorias en cubos. 2. Mezclar con arvejas y mayonesa.'::text, 30, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 700.0 as cantidad from public.ingredientes where nombre = 'Papa'    
    union all 
    select id, 250.0 from public.ingredientes where nombre = 'Zanahoria'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Arvejas'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Mayonesa'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Ensalada Rusa
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'vegana'),
    (v_receta_id, 'vegetariana');
-- Queque
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Queque'::text, 'Queque esponjoso tradicional.'::text, '1. Batir mantequilla con azúcar. 2. Agregar huevos y harina con polvos. 3. Hornear.'::text, 60, 10, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 400.0 as cantidad from public.ingredientes where nombre = 'Harina de trigo'    
    union all 
    select id, 4.0 from public.ingredientes where nombre = 'Huevo'    
    union all 
    select id, 250.0 from public.ingredientes where nombre = 'Azúcar'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Mantequilla'    
    union all 
    select id, 12.0 from public.ingredientes where nombre = 'Polvos de hornear'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Queque
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'postre'),
    (v_receta_id, 'snack'),
    (v_receta_id, 'vegetariana');
-- Chaparritas
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Chaparritas'::text, 'Masa de hojaldre o pan enrollada con vienesa y queso.'::text, '1. Extender masa y poner vienesa con queso. 2. Enrollar y hornear.'::text, 35, 8, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 500.0 as cantidad from public.ingredientes where nombre = 'Masa de hojaldre'    
    union all 
    select id, 8.0 from public.ingredientes where nombre = 'Salchicha'    
    union all 
    select id, 250.0 from public.ingredientes where nombre = 'Queso'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Chaparritas
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'cetogenica'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'postre'),
    (v_receta_id, 'snack');
-- Garbanzos con arroz y longaniza
  insert into public.recetas (nombre, descripcion, procedimiento, tiempo_preparacion, porciones, es_publica, created_by)
  values (
    'Garbanzos con arroz y longaniza'::text, 'Guiso de garbanzos con arroz y longaniza.'::text, '1. Cocer garbanzos remojados. 2. Sofreír longaniza con cebolla; agregar arroz y caldo. 3. Unir con garbanzos y cocinar.'::text, 60, 6, true, v_user_id
  ) returning id into v_receta_id;

  insert into public.receta_ingredientes (receta_id, ingrediente_id, cantidad)
  select v_receta_id, id, cantidad from (
    select id, 400.0 as cantidad from public.ingredientes where nombre = 'Garbanzos'    
    union all 
    select id, 200.0 from public.ingredientes where nombre = 'Arroz'    
    union all 
    select id, 250.0 from public.ingredientes where nombre = 'Longaniza'    
    union all 
    select id, 150.0 from public.ingredientes where nombre = 'Cebolla'    
    union all 
    select id, 10.0 from public.ingredientes where nombre = 'Ajo'
  ) as ingredientes;

    -- Etiquetas (redefinidas) para Garbanzos con arroz y longaniza
  insert into public.receta_etiquetas (receta_id, etiqueta)
  values 
    (v_receta_id, 'almuerzo'),
    (v_receta_id, 'cena'),
    (v_receta_id, 'omnivora'),
    (v_receta_id, 'sin_gluten'),
    (v_receta_id, 'sin_lactosa');
end $$;
