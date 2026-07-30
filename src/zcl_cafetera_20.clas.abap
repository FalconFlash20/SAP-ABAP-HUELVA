CLASS zcl_cafetera_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_agua TYPE i,
      preparar_cafe,
      consultar_agua RETURNING VALUE(rv_agua_d) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA agua_rest TYPE i.
ENDCLASS.



CLASS zcl_cafetera_20 IMPLEMENTATION.
  METHOD constructor.
    agua_rest = i_agua.
  ENDMETHOD.
  METHOD preparar_cafe.
    IF agua_rest > 250.
      agua_rest = agua_rest - 250.
    ENDIF.
  ENDMETHOD.
  METHOD consultar_agua.
    rv_agua_d = agua_rest.
  ENDMETHOD.
ENDCLASS.
