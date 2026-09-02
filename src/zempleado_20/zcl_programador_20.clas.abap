CLASS zcl_programador_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_empleado_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_nombre   TYPE string
        iv_lenguaje TYPE string .
    METHODS obtener_lenguaje
      RETURNING
        VALUE(rv_lenguaje) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mv_lenguaje TYPE string .
ENDCLASS.

CLASS zcl_programador_20 IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_nombre ).
    me->mv_lenguaje = iv_lenguaje.
  ENDMETHOD.
  METHOD obtener_lenguaje.
    rv_lenguaje = me->mv_lenguaje.
  ENDMETHOD.
ENDCLASS.
