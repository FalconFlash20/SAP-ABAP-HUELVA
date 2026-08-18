CLASS zcl_gestor_reservas_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-METHODS crear_reserva
      IMPORTING
                i_numero_habitacion  TYPE zreserva_20-numero_habitacion
                i_cliente            TYPE zreserva_20-cliente
      RETURNING VALUE(rv_id_reserva) TYPE zreserva_20-id_reserva.
    CLASS-METHODS consultar_reserva
      IMPORTING
                i_id_reserva         TYPE zreserva_20-id_reserva
      EXPORTING
                o_numero_habitacion  TYPE zreserva_20-numero_habitacion
                o_cliente            TYPE zreserva_20-cliente
                o_estado             TYPE zreserva_20-estado
      RETURNING VALUE(rv_encontrado) TYPE abap_bool.
    CLASS-METHODS liberar_reserva
      IMPORTING
                i_id_reserva    TYPE zreserva_20-id_reserva
      RETURNING VALUE(rv_exito) TYPE abap_bool.

    CLASS-METHODS eliminar_reserva
      IMPORTING
                i_id_reserva    TYPE zreserva_20-id_reserva
      RETURNING VALUE(rv_exito) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gestor_reservas_20 IMPLEMENTATION.

  METHOD crear_reserva.
    DATA: lv_max_id TYPE zreserva_20-id_reserva.
    SELECT MAX( id_reserva )
      FROM zreserva_20
      INTO @lv_max_id.
    rv_id_reserva = lv_max_id + 1.
    DATA(ls_reserva) = VALUE zreserva_20(
      id_reserva        = rv_id_reserva
      numero_habitacion = i_numero_habitacion
      cliente           = i_cliente
      estado            = 'OCUPADA'
    ).
    INSERT zreserva_20 FROM @ls_reserva.
  ENDMETHOD.

  METHOD consultar_reserva.
    SELECT SINGLE numero_habitacion, cliente, estado
      FROM zreserva_20
      WHERE id_reserva = @i_id_reserva
      INTO (@o_numero_habitacion, @o_cliente, @o_estado).
    IF sy-subrc = 0.
      rv_encontrado = abap_true.
    ELSE.
      rv_encontrado = abap_false.
      CLEAR: o_numero_habitacion, o_cliente, o_estado.
    ENDIF.
  ENDMETHOD.

  METHOD liberar_reserva.
    UPDATE zreserva_20
       SET estado = 'LIBERADA'
     WHERE id_reserva = @i_id_reserva.
    IF sy-subrc = 0.
      rv_exito = abap_true.
    ELSE.
      rv_exito = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD eliminar_reserva.
    DELETE FROM zreserva_20
      WHERE id_reserva = @i_id_reserva.
    IF sy-subrc = 0.
      rv_exito = abap_true.
    ELSE.
      rv_exito = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
