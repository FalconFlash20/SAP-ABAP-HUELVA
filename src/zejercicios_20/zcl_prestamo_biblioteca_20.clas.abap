CLASS zcl_prestamo_biblioteca_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-METHODS:
      consultar_total_prestamos RETURNING VALUE(rv_prestamos_realizados) TYPE i,
      consultar_pendientes RETURNING VALUE(rv_pendientes) TYPE i.
    METHODS:
      constructor IMPORTING i_nombre TYPE string
                            i_titulo TYPE string,
      marcar_devuelto,
      consultar_datos EXPORTING o_nombre   TYPE string
                                o_titulo   TYPE string
                                o_devuelto TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: total_prestamos_realizados TYPE i,
                prestamos_pendientes       TYPE i.
    DATA: nombre   TYPE string,
          titulo   TYPE string,
          devuelto TYPE abap_bool.

ENDCLASS.



CLASS ZCL_PRESTAMO_BIBLIOTECA_20 IMPLEMENTATION.


  METHOD constructor.
    me->nombre = i_nombre.
    me->titulo = i_titulo.
    me->devuelto = abap_false.
    total_prestamos_realizados = total_prestamos_realizados + 1.
    prestamos_pendientes       = prestamos_pendientes + 1.
  ENDMETHOD.


  METHOD consultar_datos.
    o_nombre = me->nombre.
    o_titulo = me->titulo.
    o_devuelto = me->devuelto.
  ENDMETHOD.


  METHOD consultar_pendientes.
    rv_pendientes = prestamos_pendientes.
  ENDMETHOD.


  METHOD consultar_total_prestamos.
    rv_prestamos_realizados = total_prestamos_realizados.
  ENDMETHOD.


  METHOD marcar_devuelto.
    IF NOT devuelto.
      devuelto = abap_true.
      Prestamos_pendientes = Prestamos_pendientes - 1.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
