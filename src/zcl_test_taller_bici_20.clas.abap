CLASS zcl_test_taller_bici_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_taller_bici_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_taller) = NEW zcl_taller_bici_20(  ).
    DATA: lv_id_1       TYPE ztaller_bicis_20-id_reparacion,
          lv_id_2       TYPE ztaller_bicis_20-id_reparacion,
          lv_cliente    TYPE ztaller_bicis_20-cliente,
          lv_averia     TYPE ztaller_bicis_20-averia,
          lv_estado     TYPE ztaller_bicis_20-estado,
          lv_encontrado TYPE abap_bool,
          lv_exito      TYPE abap_bool.

    lv_id_1 = lo_taller->registrar_reparacion(
      iv_cliente = 'Carlos Gomez'
      iv_averia  = 'Frenos'
    ).
    lv_id_2 = lo_taller->registrar_reparacion(
      iv_cliente = 'Ana Martinez'
      iv_averia  = 'Cadena'
    ).
    out->write( |Reparaciones registradas:| ).
    out->write( |   -> ID Reparacion 1: { lv_id_1 } (Carlos Gomez)| ).
    out->write( |   -> ID Reparacion 2: { lv_id_2 } (Ana Martinez)| ).
    lv_encontrado = lo_taller->consultar_reparacion(
      EXPORTING
        iv_id_reparacion = lv_id_1
      IMPORTING
        ev_cliente       = lv_cliente
        ev_averia        = lv_averia
        ev_estado        = lv_estado
    ).

    IF lv_encontrado = abap_true.
      out->write( |Consulta de la Reparacion { lv_id_1 }:| ).
      out->write( |   -> Cliente: { lv_cliente } | ).
      out->write( |   -> Averia:  { lv_averia } | ).
      out->write( |   -> Estado:  { lv_estado } | ).
    ELSE.
      out->write( |La reparacion { lv_id_1 } no existe.| ).
    ENDIF.
    lv_exito = lo_taller->cambiar_estado(
      iv_id_reparacion = lv_id_1
      iv_nuevo_estado  = 'CU'
    ).

    IF lv_exito = abap_true.
      out->write( |Estado de la Reparacion { lv_id_1 } cambiado con exito a EN CURSO.| ).
      lo_taller->consultar_reparacion(
        EXPORTING
          iv_id_reparacion = lv_id_1
        IMPORTING
          ev_estado        = lv_estado
      ).
      out->write( |   -> Estado comprobado tras el cambio: { lv_estado }| ).
    ELSE.
      out->write( |No se pudo cambiar el estado de la reparacion { lv_id_1 }.| ).
    ENDIF.
    lv_exito = lo_taller->eliminar_reparacion( lv_id_2 ).

    IF lv_exito = abap_true.
      out->write( |Reparacion { lv_id_2 } eliminada de la base de datos.| ).
    ENDIF.
    lv_encontrado = lo_taller->consultar_reparacion(
      EXPORTING
        iv_id_reparacion = lv_id_2
      IMPORTING
        ev_cliente       = lv_cliente
    ).
    IF lv_encontrado = abap_false.
      out->write( |   -> Comprobacion: La reparacion { lv_id_2 } ya NO existe en la tabla.| ).
    ELSE.
      out->write( |   -> Error: La reparacion { lv_id_2 } sigue existiendo.| ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
