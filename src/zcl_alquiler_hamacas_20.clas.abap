CLASS zcl_alquiler_hamacas_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_chiringuito_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_sombrillas TYPE i,
      calcular_comision_ayuntamiento REDEFINITION,
      reservar_sombrilla IMPORTING i_num_s TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA sombrillas TYPE i.
ENDCLASS.



CLASS ZCL_ALQUILER_HAMACAS_20 IMPLEMENTATION.


  METHOD calcular_comision_ayuntamiento.
    rv_importe = super->calcular_comision_ayuntamiento(  ) * 2.
  ENDMETHOD.


  METHOD constructor.

    super->constructor( i_nombre = nombre i_recaudacion = recaudacion ).
    sombrillas = i_sombrillas.
  ENDMETHOD.


  METHOD reservar_sombrilla.
    sombrillas -= i_num_s.
  ENDMETHOD.
ENDCLASS.
