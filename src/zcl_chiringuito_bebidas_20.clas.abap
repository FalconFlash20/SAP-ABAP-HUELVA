CLASS zcl_chiringuito_bebidas_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_chiringuito_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_hielo TYPE i,
      vender REDEFINITION,
      anadir_hielo RETURNING VALUE(rv_exito) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA hielo TYPE i.
ENDCLASS.



CLASS ZCL_CHIRINGUITO_BEBIDAS_20 IMPLEMENTATION.


  METHOD anadir_hielo.
    rv_exito = abap_false.
    IF hielo > 0.
      rv_exito = abap_true.
      hielo = hielo - 1.
    ENDIF.
  ENDMETHOD.


  METHOD vender.
    IF i_importe < '1.50'.
      rv_exito = abap_false.
    ELSE.
      super->vender( i_importe ).
      rv_exito = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.

    super->constructor( i_nombre = nombre i_recaudacion = recaudacion ).
    hielo = i_hielo.
  ENDMETHOD.
ENDCLASS.
