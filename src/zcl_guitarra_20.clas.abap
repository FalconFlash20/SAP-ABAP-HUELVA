CLASS zcl_guitarra_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_instrumento_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_marca       TYPE string
                            i_num_cuerdas TYPE i,
      afinar_cuerda IMPORTING i_cuerdas       TYPE i
                    RETURNING VALUE(rv_exito) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA num_cuerdas TYPE i.
ENDCLASS.



CLASS ZCL_GUITARRA_20 IMPLEMENTATION.


  METHOD afinar_cuerda.
    IF i_cuerdas > 0 AND i_cuerdas <= num_cuerdas.
      rv_exito = abap_true.
    ELSE.
      rv_exito = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( i_marca = i_marca ).
    num_cuerdas = i_num_cuerdas.

  ENDMETHOD.
ENDCLASS.
