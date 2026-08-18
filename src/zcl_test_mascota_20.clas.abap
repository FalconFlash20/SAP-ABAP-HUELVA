CLASS zcl_test_mascota_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_MASCOTA_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_mascota) = NEW zcl_mascota_20( ).
    DATA: lv_lleno   TYPE i,
          lv_energia TYPE i.
    DO 7 TIMES.
      lo_mascota->jugar( ).
      lo_mascota->consultar_estado( IMPORTING o_lleno = lv_lleno o_energia = lv_energia ).
      out->write( |EL estado de la mascota es: Lleno--> { lv_lleno }, Energia--> { lv_energia }| ).
    ENDDO.
    lo_mascota->comer( ).
    lo_mascota->consultar_estado( IMPORTING o_lleno = lv_lleno o_energia = lv_energia ).
    out->write( |EL estado de la mascota es: Lleno--> { lv_lleno }, Energia--> { lv_energia }| ).
  ENDMETHOD.
ENDCLASS.
