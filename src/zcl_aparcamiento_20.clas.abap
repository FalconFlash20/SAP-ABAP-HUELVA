CLASS zcl_aparcamiento_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: calcular_tarifa
      IMPORTING iv_horas_estacionado TYPE i
      EXPORTING ev_minutos_totales   TYPE i
      RETURNING VALUE(rv_precio)     TYPE zdecimals2.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_APARCAMIENTO_20 IMPLEMENTATION.


  METHOD calcular_tarifa.
    ev_minutos_totales = iv_horas_estacionado * 60.
    rv_precio = ev_minutos_totales * '1.25'.
  ENDMETHOD.
ENDCLASS.
