CLASS zcl_deposito_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_capacidad TYPE i,
      repostar_deposito IMPORTING i_litros TYPE i,
      despachar_deposito IMPORTING i_litros_desp   TYPE i
                         RETURNING VALUE(rv_exito) TYPE abap_bool,
      consultar_nivel RETURNING VALUE(rv_litros) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: litros    TYPE i,
          capacidad TYPE i.
ENDCLASS.



CLASS ZCL_DEPOSITO_20 IMPLEMENTATION.


  METHOD constructor.
    capacidad = i_capacidad.
    litros = 0.
  ENDMETHOD.


  METHOD repostar_deposito.
    IF ( i_litros + litros ) > capacidad.
      litros = capacidad.
    ELSE.
      litros = litros + i_litros.
    ENDIF.
  ENDMETHOD.


  METHOD despachar_deposito.
    IF litros - i_litros_desp < 0.
      rv_exito = abap_false.
    ELSE.
      litros = litros - i_litros_desp.
      rv_exito = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD consultar_nivel.
    rv_litros = litros.
  ENDMETHOD.
ENDCLASS.
