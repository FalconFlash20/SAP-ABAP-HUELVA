CLASS zcl_cp01_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cp01_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*  " 1. Borramos contenido anterior para evitar duplicados
*    DELETE FROM zvuelos_20.
*
*    " 2. Preparamos los registros de la imagen con la sintaxis VALUE
*    DATA lt_vuelos TYPE TABLE OF zvuelos_20.
*
*    lt_vuelos = VALUE #(
*      ( aerolinea = 'LH' n_vuelo = '0400' origen = 'FRA' destino = 'JFK' precio = '899.00'  moneda = 'EUR' plazas_libres = 15 )
*      ( aerolinea = 'AA' n_vuelo = '0017' origen = 'JFK' destino = 'SFO' precio = '450.50'  moneda = 'EUR' plazas_libres = 0  )
*      ( aerolinea = 'IB' n_vuelo = '3740' origen = 'MAD' destino = 'BCN' precio = '120.00'  moneda = 'EUR' plazas_libres = 42 )
*      ( aerolinea = 'LH' n_vuelo = '0455' origen = 'FRA' destino = 'MAD' precio = '310.75'  moneda = 'EUR' plazas_libres = 8  )
*      ( aerolinea = 'AA' n_vuelo = '0064' origen = 'SFO' destino = 'JFK' precio = '510.00'  moneda = 'EUR' plazas_libres = 3  )
*      ( aerolinea = 'IB' n_vuelo = '3950' origen = 'BCN' destino = 'LHR' precio = '275.30'  moneda = 'EUR' plazas_libres = 0  )
*      ( aerolinea = 'LH' n_vuelo = '2030' origen = 'MUC' destino = 'FRA' precio = '95.00'   moneda = 'EUR' plazas_libres = 60 )
*      ( aerolinea = 'SQ' n_vuelo = '0026' origen = 'SIN' destino = 'FRA' precio = '1250.00' moneda = 'EUR' plazas_libres = 5  )
*    ).
*
*    " 3. Inserción masiva en la tabla transparente
*    INSERT zvuelos_20 FROM TABLE @lt_vuelos.
*
*    " 4. Verificación y salida por consola
*    IF sy-subrc = 0.
*      out->write( |Carga completada con éxito. Se han insertado { lines( lt_vuelos ) } registros.| ).
*    ELSE.
*      out->write( |Error al insertar los registros en ZVUELOS_20.| ).
*    ENDIF.
" Cargar los vuelos existentes desde la DB
    SELECT * FROM zvuelos_20 INTO TABLE @DATA(lt_vuelos).

    IF lt_vuelos IS INITIAL.
      out->write( 'La tabla ZVUELOS_20 está vacía. Ejecuta primero la carga de datos.' ).
      RETURN.
    ENDIF.

    " =====================================================================
    " TAREA 1.1 – Clasificación por precio
    " =====================================================================
    out->write( '=== TAREA 1.1: Clasificación por Precio ===' ).

    LOOP AT lt_vuelos INTO DATA(ls_vuelo).
      DATA(lv_categoria) = COND string(
        WHEN ls_vuelo-precio < 150 THEN 'Económico'
        WHEN ls_vuelo-precio BETWEEN 150 AND 500 THEN 'Estándar'
        WHEN ls_vuelo-precio BETWEEN 500 AND 1000 THEN 'Premium'
        WHEN ls_vuelo-precio > 1000 THEN 'First Class'
        ELSE 'Sin categoría'
      ).

      out->write( |Vuelo { ls_vuelo-aerolinea }-{ ls_vuelo-n_vuelo } ({ ls_vuelo-precio } { ls_vuelo-moneda }) -> Categoría: { lv_categoria }| ).
    ENDLOOP.

    " =====================================================================
    " TAREA 1.2 – Filtrado con operadores lógicos
    " =====================================================================
    out->write( |\n=== TAREA 1.2: Vuelos Filtrados ===| ).

    DATA lt_filtrados TYPE TABLE OF zvuelos_20.

    LOOP AT lt_vuelos INTO DATA(ls_f)
      WHERE plazas_libres > 0
        AND ( origen = 'FRA' OR destino = 'FRA' )
        AND precio <= 1000.

      APPEND ls_f TO lt_filtrados.
      out->write( |Cumple filtro: { ls_f-aerolinea }-{ ls_f-n_vuelo } | &&
                  |[{ ls_f-origen } -> { ls_f-destino }] | &&
                  |Precio: { ls_f-precio } € Plazas: { ls_f-plazas_libres }| ).
    ENDLOOP.

    " =====================================================================
    " TAREA 1.3 – Transformación de cadenas
    " =====================================================================
    out->write( |\n=== TAREA 1.3: Transformación de Cadenas (Vuelos Filtrados) ===| ).

    LOOP AT lt_filtrados INTO DATA(ls_filt).
      " 1. Concatenar código de vuelo
      DATA(lv_codigo_vuelo) = |{ ls_filt-aerolinea }-{ ls_filt-n_vuelo }|.

      " 2. Convertir destino a minúsculas
      DATA(lv_destino_minus) = to_lower( ls_filt-destino ).

      " 3. Longitud del código generado
      DATA(lv_longitud) = strlen( lv_codigo_vuelo ).

      " 4. Salida en formato: CÓDIGO | destino_minus | longitud
      out->write( |{ lv_codigo_vuelo }  { lv_destino_minus }  { lv_longitud }| ).
    ENDLOOP.

    " =====================================================================
    " TAREA 1.4 – Resumen con funciones numéricas
    " =====================================================================
    out->write( |\n=== TAREA 1.4: Resumen Numérico ===| ).

    " Precio Máximo y Mínimo usando la expresión REDUCE
    DATA(lv_precio_max) = REDUCE zvuelos_20-precio(
      INIT max = CONV zvuelos_20-precio( 0 )
      FOR ls_p IN lt_vuelos
      NEXT max = nmax( val1 = max val2 = ls_p-precio )
    ).

    DATA(lv_precio_min) = REDUCE zvuelos_20-precio(
      INIT min = lt_vuelos[ 1 ]-precio
      FOR ls_p IN lt_vuelos
      NEXT min = nmin( val1 = min val2 = ls_p-precio )
    ).

    " Total precio y suma de plazas libres
    DATA(lv_suma_precios) = REDUCE zvuelos_20-precio(
      INIT sum_p = CONV zvuelos_20-precio( 0 )
      FOR ls_p IN lt_vuelos
      NEXT sum_p = sum_p + ls_p-precio
    ).

    DATA(lv_total_plazas) = REDUCE i(
      INIT sum_pl = 0
      FOR ls_p IN lt_vuelos
      NEXT sum_pl = sum_pl + ls_p-plazas_libres
    ).

    " Cálculo del precio medio redondeado a 2 decimales con round()
    DATA(lv_num_vuelos) = lines( lt_vuelos ).
    DATA(lv_precio_medio_raw) = CONV decfloat34( lv_suma_precios / lv_num_vuelos ).
    DATA(lv_precio_medio) = round( val = lv_precio_medio_raw dec = 2 ).

    " Salida por consola
    out->write( |Precio Máximo: { lv_precio_max } €| ).
    out->write( |Precio Mínimo: { lv_precio_min } €| ).
    out->write( |Precio Medio:  { lv_precio_medio } €| ).
    out->write( |Total Plazas Libres: { lv_total_plazas }| ).
  ENDMETHOD.
ENDCLASS.
