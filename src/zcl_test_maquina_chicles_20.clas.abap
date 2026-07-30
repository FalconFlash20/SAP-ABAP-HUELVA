CLASS zcl_test_maquina_chicles_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_maquina_chicles_20 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA(lo_maquina_chicles) = NEW zcl_maquina_chicles_20( 2 ).
    DATA lv_cambio TYPE i.
    lv_cambio = lo_maquina_chicles->vender_chicle( 25 ).
    out->write( |El cambio ha sido de { lv_cambio }| ).
    out->write( |Quedan disponibles { lo_maquina_chicles->consultar_stock(  ) } chicles| ).
    lv_cambio = lo_maquina_chicles->vender_chicle( 50 ).
    out->write( |El cambio ha sido de { lv_cambio }| ).
    out->write( |Quedan disponibles { lo_maquina_chicles->consultar_stock(  ) } chicles| ).
    lv_cambio = lo_maquina_chicles->vender_chicle( 25 ).
    out->write( |El cambio ha sido de { lv_cambio }| ).
    out->write( |Quedan disponibles { lo_maquina_chicles->consultar_stock(  ) } chicles| ).
    lv_cambio = lo_maquina_chicles->vender_chicle( 10 ).
    out->write( |El cambio ha sido de { lv_cambio }| ).
    out->write( |Quedan disponibles { lo_maquina_chicles->consultar_stock(  ) } chicles| ).
  ENDMETHOD.
ENDCLASS.
