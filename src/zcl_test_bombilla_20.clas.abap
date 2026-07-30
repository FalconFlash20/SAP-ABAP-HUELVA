CLASS zcl_test_bombilla_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_bombilla_20 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_bombilla) = NEW zcl_bombilla_20( ).
    lo_bombilla->encender( ).
    out->write( lo_bombilla->esta_encendida ).
  ENDMETHOD.
ENDCLASS.
