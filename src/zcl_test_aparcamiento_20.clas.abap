CLASS zcl_test_aparcamiento_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_APARCAMIENTO_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lv_min    TYPE i,
          lv_precio TYPE zdecimals2.
    DATA(lo_aparcamiento) = NEW zcl_aparcamiento_20( ).
    lv_precio = lo_aparcamiento->calcular_tarifa( EXPORTING iv_horas_estacionado = 3
    IMPORTING ev_minutos_totales = lv_min ).
    out->write( |El precio es { lv_precio } y los minutos totales son { lv_min }| ).
  ENDMETHOD.
ENDCLASS.
