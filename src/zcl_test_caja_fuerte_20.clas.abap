CLASS zcl_test_caja_fuerte_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_caja_fuerte_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_caja_fuerte) = NEW zcl_caja_fuerte_20( '1234' ).
    IF lo_caja_fuerte->abrir( '0000' ).
      out->write( 'La caja fuerte ha sido abierta' ).
    ELSE.
      out->write( 'No se ha podido abrir la caja' ).
    ENDIF.
    IF lo_caja_fuerte->abrir( '1111' ).
      out->write( 'La caja fuerte ha sido abierta' ).
    ELSE.
      out->write( 'No se ha podido abrir la caja' ).
    ENDIF.
    IF lo_caja_fuerte->abrir( '2222' ).
      out->write( 'La caja fuerte ha sido abierta' ).
    ELSE.
      out->write( 'No se ha podido abrir la caja' ).
    ENDIF.
    IF lo_caja_fuerte->abrir( '1234' ).
      out->write( 'La caja fuerte ha sido abierta' ).
    ELSE.
      out->write( 'No se ha podido abrir la caja' ).
    ENDIF.
    out->write( |Estado de la caja fuerte: { lo_caja_fuerte->get_bloqueada(  ) }| ).
  ENDMETHOD.
ENDCLASS.
