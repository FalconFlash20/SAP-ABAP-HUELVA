CLASS zcl_test_deposito_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_DEPOSITO_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lv_exito TYPE abap_bool.
    DATA(lo_deposito) = NEW zcl_deposito_20( 1000 ).
    lo_deposito->repostar_deposito( 700 ).
    out->write( |El nivel actual de gasolina es: { lo_deposito->consultar_nivel(  ) }| ).
    lo_deposito->repostar_deposito( 500 ).
    out->write( |El nivel actual de gasolina es: { lo_deposito->consultar_nivel(  ) }| ).
    lv_exito = lo_deposito->despachar_deposito( 200 ).
    IF lv_exito = abap_true.
      out->write( |Se pudo echar la gasolina| ).
    ELSE.
      out->write( |No se pudo despachar la gasolina| ).
    ENDIF.
    out->write( |El nivel actual de gasolina es: { lo_deposito->consultar_nivel(  ) }| ).
    lv_exito = lo_deposito->despachar_deposito( 5000 ).
    IF lv_exito = abap_true.
      out->write( |Se pudo echar la gasolina| ).
    ELSE.
      out->write( |No se pudo despachar la gasolina| ).
    ENDIF.
    out->write( |El nivel actual de gasolina es: { lo_deposito->consultar_nivel(  ) }| ).
  ENDMETHOD.
ENDCLASS.
