CLASS zcl_empleado_20 DEFINITION
  PUBLIC
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_nombre TYPE string .
    METHODS obtener_nombre
      RETURNING
        VALUE(rv_nombre) TYPE string .
  PROTECTED SECTION.
    DATA mv_nombre TYPE string .
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_empleado_20 IMPLEMENTATION.

  METHOD constructor.
    me->mv_nombre = iv_nombre.
  ENDMETHOD.
  METHOD obtener_nombre.
    rv_nombre = me->mv_nombre.
  ENDMETHOD.

ENDCLASS.
