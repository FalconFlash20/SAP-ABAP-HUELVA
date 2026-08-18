CLASS zcl_bombilla_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA esta_encendida TYPE abap_bool.
    DATA potencia TYPE i.
    METHODS:
      constructor IMPORTING i_potencia TYPE i,
      encender,
      get_encendida RETURNING VALUE(rv_encendiad) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BOMBILLA_20 IMPLEMENTATION.


  METHOD encender.
    esta_encendida = abap_true.
  ENDMETHOD.


  METHOD get_encendida.
    rv_encendiad = esta_encendida.
  ENDMETHOD.


  METHOD constructor.
    potencia = i_potencia.
  ENDMETHOD.
ENDCLASS.
