CLASS zcl_test_prestamos_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_prestamos_20 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( |Total préstamos realizados: { zcl_prestamo_biblioteca_20=>consultar_total_prestamos( ) }| ).
    out->write( |Préstamos pendientes:       { zcl_prestamo_biblioteca_20=>consultar_pendientes( ) }| ).

    DATA(lo_p1) = NEW zcl_prestamo_biblioteca_20(
      i_nombre = 'Juan Pérez'
      i_titulo = 'Cien años de soledad'
    ).

    DATA(lo_p2) = NEW zcl_prestamo_biblioteca_20(
      i_nombre = 'María García'
      i_titulo = 'Don Quijote de la Mancha'
    ).

    DATA(lo_p3) = NEW zcl_prestamo_biblioteca_20(
      i_nombre = 'Carlos López'
      i_titulo = 'El principito'
    ).

    DATA: lv_socio    TYPE string,
          lv_libro    TYPE string,
          lv_devuelto TYPE abap_bool.

    lo_p2->consultar_datos(
      IMPORTING
        o_nombre   = lv_socio
        o_titulo   = lv_libro
        o_devuelto = lv_devuelto
    ).

    out->write( |Socio:    { lv_socio }| ).
    out->write( |Libro:    { lv_libro }| ).
    out->write( |Devuelto: { lv_devuelto }| ).
    out->write( |Total préstamos realizados: { zcl_prestamo_biblioteca_20=>consultar_total_prestamos( ) }| ).
    out->write( |Préstamos pendientes:       { zcl_prestamo_biblioteca_20=>consultar_pendientes( ) }| ).

    lo_p2->marcar_devuelto( ).

    out->write( |Total préstamos realizados: { zcl_prestamo_biblioteca_20=>consultar_total_prestamos( ) }| ).
    out->write( |Préstamos pendientes:       { zcl_prestamo_biblioteca_20=>consultar_pendientes( ) }| ).
  ENDMETHOD.
ENDCLASS.
