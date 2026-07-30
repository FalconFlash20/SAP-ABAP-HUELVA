CLASS zcl_instrumento_20 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_marca TYPE string,
      registrar_practica IMPORTING i_horas TYPE i,
      consultar_horas_uso RETURNING VALUE(rv_horas) TYPE i.
  PROTECTED SECTION.
    DATA: marca TYPE string,
          horas TYPE i.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_instrumento_20 IMPLEMENTATION.
  METHOD constructor.
    marca = i_marca.
    horas = 0.
  ENDMETHOD.

  METHOD consultar_horas_uso.
    rv_horas = horas.
  ENDMETHOD.

  METHOD registrar_practica.
    horas = horas + i_horas.
  ENDMETHOD.

ENDCLASS.
