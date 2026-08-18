CLASS zcl_test_cafetera_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_CAFETERA_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_cafetera) = NEW zcl_cafetera_20( 600 ).
    DO 3 TIMES.
      lo_cafetera->preparar_cafe( ).
      out->write( lo_cafetera->consultar_agua(  ) ).
    ENDDO.
  ENDMETHOD.
ENDCLASS.
