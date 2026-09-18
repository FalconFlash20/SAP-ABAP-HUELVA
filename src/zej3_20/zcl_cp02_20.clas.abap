CLASS zcl_cp02_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_cp02_20 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " =====================================================================
    " TAREA 2.1 – Altas de reservas
    " =====================================================================
    out->write( '=== TAREA 2.1: Altas de Reservas ===' ).

    DATA lt_nuevas TYPE TABLE OF zreservas_20.
    lt_nuevas = VALUE #(
      ( id = '0000000009' aerolinea = 'IB' n_vuelo = '3950' pasajero = 'Elena Martín' fecha = '20260601' precio = '275.30' moneda = 'EUR' estado = 'A' )
      ( id = '0000000010' aerolinea = 'LH' n_vuelo = '2030' pasajero = 'Franz Weber'  fecha = '20260610' precio = '95.00'  moneda = 'EUR' estado = 'A' )
    ).

    " Inserción en la base de datos
    INSERT zreservas_20 FROM TABLE @lt_nuevas.

    " Cargar y mostrar la tabla completa tras las inserciones (INTO al final)
    SELECT * FROM zreservas_20 ORDER BY id ASCENDING INTO TABLE @DATA(lt_reservas).
    out->write( 'Tabla ZRESERVAS_20 completa tras inserciones:' ).
    out->write( lt_reservas ).

    " =====================================================================
    " TAREA 2.2 – Modificaciones
    " =====================================================================
    out->write( |\n=== TAREA 2.2: Modificaciones ===| ).

    " 1. Buscar la reserva con ID 3 y cambiar su precio a 480.00
    LOOP AT lt_reservas ASSIGNING FIELD-SYMBOL(<ls_reserva>) WHERE id = '0000000003'.
      <ls_reserva>-precio = '480.00'.
    ENDLOOP.

    " 2. Para todas las reservas de LH, aplicar un descuento del 10%
    LOOP AT lt_reservas ASSIGNING <ls_reserva> WHERE aerolinea = 'LH'.
      <ls_reserva>-precio = <ls_reserva>-precio * '0.90'.
    ENDLOOP.

    " Actualizar cambios en la base de datos
    MODIFY zreservas_20 FROM TABLE @lt_reservas.

    " Muestra los registros modificados (ID 3 y los de LH)
    out->write( 'Registros modificados (ID 3 y aerolínea LH):' ).
    LOOP AT lt_reservas INTO DATA(ls_mod) WHERE id = '0000000003' OR aerolinea = 'LH'.
      out->write( |ID: { ls_mod-id }  Aerolínea: { ls_mod-aerolinea }  Pasajero: { ls_mod-pasajero } Precio actual: { ls_mod-precio } { ls_mod-moneda }| ).
    ENDLOOP.

    " =====================================================================
    " TAREA 2.3 – Cancelaciones y borrados
    " =====================================================================
    out->write( |\n=== TAREA 2.3: Cancelaciones y Borrados ===| ).

    " 1. Cambiar estado de la reserva ID 4 a 'C' (cancelada)
    LOOP AT lt_reservas ASSIGNING <ls_reserva> WHERE id = '0000000004'.
      <ls_reserva>-estado = 'C'.
    ENDLOOP.
    MODIFY zreservas_20 FROM TABLE @lt_reservas.

    " 2. Eliminar físicamente de la tabla DB todas las reservas con estado 'C'
    DELETE FROM zreservas_20 WHERE estado = 'C'.
    DATA(lv_registros_eliminados) = sy-dbcnt.

    " Recargar la tabla local sincronizada con DB (INTO al final)
    SELECT * FROM zreservas_20 ORDER BY id ASCENDING INTO TABLE @lt_reservas.

    " 3. Mostrar la tabla resultante y el número de registros eliminados
    out->write( |Número de registros eliminados físicamente (Estado C): { lv_registros_eliminados }| ).
    out->write( 'Tabla resultante tras borrado:' ).
    out->write( lt_reservas ).

    " =====================================================================
    " TAREA 2.4 – Búsquedas
    " =====================================================================
    out->write( |\n=== TAREA 2.4: Búsquedas ===| ).

    " 1. Busca si existe una reserva para el pasajero "Lisa Tan" (TRANSPORTING NO FIELDS + sy-subrc)
    READ TABLE lt_reservas WITH KEY pasajero = 'Lisa Tan' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      out->write( '1. Se encontró la reserva para la pasajera Lisa Tan.' ).
    ELSE.
      out->write( '1. No se encontró la reserva para Lisa Tan.' ).
    ENDIF.

    " 2. Obtén una referencia (REFERENCE INTO) a la reserva con ID 6 y muestra sus datos
    READ TABLE lt_reservas REFERENCE INTO DATA(lr_reserva_6) WITH KEY id = '0000000006'.
    IF sy-subrc = 0.
      out->write( |2. Datos ID 6 (vía referencia): Pasajero={ lr_reserva_6->pasajero }, Vuelo={ lr_reserva_6->aerolinea }-{ lr_reserva_6->n_vuelo }, Precio={ lr_reserva_6->precio } { lr_reserva_6->moneda }| ).
    ENDIF.

    " 3. Usa la expresión de tabla itab[ ... ] para acceder directamente al pasajero del ID 1
    TRY.
        DATA(lv_pasajero_id1) = lt_reservas[ id = '0000000001' ]-pasajero.
        out->write( |3. Pasajero del ID 1 (Expresión de tabla): { lv_pasajero_id1 }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( '3. ID 1 no encontrado.' ).
    ENDTRY.

    " =====================================================================
    " TAREA 2.5 – Agrupación y agregados
    " =====================================================================
    out->write( |\n=== TAREA 2.5: Agrupación y Agregados (Reservas Activas) ===| ).

    " Agrupar por aerolínea usando LOOP AT ... GROUP BY
    LOOP AT lt_reservas INTO DATA(ls_res)
      WHERE estado = 'A'
      GROUP BY ( aerolinea = ls_res-aerolinea )
      ASSIGNING FIELD-SYMBOL(<grp_aerolinea>).

      DATA(lv_num_reservas) = 0.
      DATA lv_precio_tot TYPE zreservas_20-precio VALUE 0.

      " Calcular agregados para cada grupo
      LOOP AT GROUP <grp_aerolinea> INTO DATA(ls_miembro_grupo).
        lv_num_reservas = lv_num_reservas + 1.
        lv_precio_tot   = lv_precio_tot + ls_miembro_grupo-precio.
      ENDLOOP.

      DATA(lv_precio_med_raw) = CONV decfloat34( lv_precio_tot / lv_num_reservas ).
      DATA(lv_precio_medio)   = round( val = lv_precio_med_raw dec = 2 ).

      " Mostrar informe por consola por aerolínea
      out->write( |Aerolínea: { <grp_aerolinea>-aerolinea } | &&
                  |Nº Reservas: { lv_num_reservas } | &&
                  |Precio Total: { lv_precio_tot } EUR | &&
                  |Precio Medio: { lv_precio_medio } EUR| ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
