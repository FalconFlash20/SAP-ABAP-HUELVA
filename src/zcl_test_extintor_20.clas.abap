CLASS zcl_test_extintor_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_EXTINTOR_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_extintor) = NEW zcl_extintor_20( 100 ).
    DO 3 TIMES.
      lo_extintor->usar( ).
      out->write( lo_extintor->consultar_carga( ) ).
    ENDDO.
  ENDMETHOD.
ENDCLASS.
