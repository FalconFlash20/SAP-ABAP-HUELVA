CLASS zcl_caseta_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_atraccion_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_nombre_cas TYPE string
                            i_rebujitos  TYPE i,
      pedir_rebujito RETURNING VALUE(rv_exito) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA rebujitos TYPE i.
ENDCLASS.



CLASS ZCL_CASETA_20 IMPLEMENTATION.


  METHOD constructor.
    super->constructor( i_nombre = i_nombre_cas ).
    rebujitos = i_rebujitos.
  ENDMETHOD.


  METHOD pedir_rebujito.
    rv_exito = abap_false.
    IF rebujitos - 1 >= 0.
      rebujitos = rebujitos - 1.
      rv_exito = abap_true.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
