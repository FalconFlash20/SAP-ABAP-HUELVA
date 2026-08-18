CLASS zcl_test_chiringuito_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_CHIRINGUITO_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  data(lo_ch_b) = new zcl_chiringuito_bebidas_20( 50 ).
  data(lv_exito) = lo_ch_b->vender( '1.00' ).
  if lv_exito.
    out->write( 'Vendido' ).
  else.
    out->write( 'No vendido' ).
  endif.
  lv_exito = lo_ch_b->vender( '3.50' ).
  if lv_exito.
    out->write( 'Vendido' ).
  else.
    out->write( 'No vendido' ).
  endif.
  out->write( |Comision: { lo_ch_b->calcular_comision_ayuntamiento( ) }, Reacudacion: { lo_ch_b->consulta_recaudacion(  ) }| ).
  data(lo_al_h) = new zcl_alquiler_hamacas_20( 50 ).
  lv_exito = lo_al_h->vender( '8.50' ).
  if lv_exito.
    out->write( 'Vendido' ).
  else.
    out->write( 'No vendido' ).
  endif.
  out->write( |Comision: { lo_al_h->calcular_comision_ayuntamiento( ) }, Reacudacion: { lo_al_h->consulta_recaudacion(  ) }| ).
  ENDMETHOD.
ENDCLASS.
