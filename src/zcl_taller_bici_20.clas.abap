CLASS zcl_taller_bici_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: ty_id_reparacion TYPE ztaller_bicis_20-id_reparacion.

    METHODS:
      registrar_reparacion
        IMPORTING
          iv_cliente       TYPE ztaller_bicis_20-cliente
          iv_averia        TYPE ztaller_bicis_20-averia
        RETURNING
          VALUE(rv_id_rep) TYPE ty_id_reparacion,

      consultar_reparacion
        IMPORTING
          iv_id_reparacion     TYPE ty_id_reparacion
        EXPORTING
          ev_cliente           TYPE ztaller_bicis_20-cliente
          ev_averia            TYPE ztaller_bicis_20-averia
          ev_estado            TYPE ztaller_bicis_20-estado
        RETURNING
          VALUE(rv_encontrado) TYPE abap_bool,

      cambiar_estado
        IMPORTING
          iv_id_reparacion TYPE ty_id_reparacion
          iv_nuevo_estado  TYPE ztaller_bicis_20-estado
        RETURNING
          VALUE(rv_exito)  TYPE abap_bool,

      eliminar_reparacion
        IMPORTING
          iv_id_reparacion TYPE ty_id_reparacion
        RETURNING
          VALUE(rv_exito)  TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_taller_bici_20 IMPLEMENTATION.

  METHOD registrar_reparacion.
    DATA: lv_max_id TYPE ztaller_bicis_20-id_reparacion.
    SELECT MAX( id_reparacion )
      FROM ztaller_bicis_20
      INTO @lv_max_id.
    rv_id_rep = lv_max_id + 1.
    DATA(ls_reparacion) = VALUE ztaller_bicis_20(
      id_reparacion = rv_id_rep
      cliente       = iv_cliente
      averia        = iv_averia
      estado        = 'PE'
    ).
    INSERT ztaller_bicis_20 FROM @ls_reparacion.
  ENDMETHOD.
  METHOD consultar_reparacion.
    SELECT SINGLE cliente, averia, estado
      FROM ztaller_bicis_20
      WHERE id_reparacion = @iv_id_reparacion
      INTO (@ev_cliente, @ev_averia, @ev_estado).
    IF sy-subrc = 0.
      rv_encontrado = abap_true.
    ELSE.
      rv_encontrado = abap_false.
      CLEAR: ev_cliente, ev_averia, ev_estado.
    ENDIF.
  ENDMETHOD.


  METHOD cambiar_estado.
    UPDATE ztaller_bicis_20
       SET estado = @iv_nuevo_estado
     WHERE id_reparacion = @iv_id_reparacion.
    IF sy-subrc = 0.
      rv_exito = abap_true.
    ELSE.
      rv_exito = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD eliminar_reparacion.
    DELETE FROM ztaller_bicis_20
      WHERE id_reparacion = @iv_id_reparacion.
    IF sy-subrc = 0.
      rv_exito = abap_true.
    ELSE.
      rv_exito = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
