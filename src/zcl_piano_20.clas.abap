CLASS zcl_piano_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_instrumento_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_marca        TYPE string
                            i_es_electrico TYPE abap_bool,
      pedalear RETURNING VALUE(rv_exito) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA es_electrico TYPE abap_bool.
ENDCLASS.



CLASS ZCL_PIANO_20 IMPLEMENTATION.


  METHOD constructor.
    super->constructor( i_marca = i_marca ).
    me->es_electrico = i_es_electrico.
  ENDMETHOD.


  METHOD pedalear.
    IF horas >= 1.
      rv_exito = abap_true.
    ELSE.
      rv_exito = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
