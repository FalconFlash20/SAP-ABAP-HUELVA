CLASS zcl_test_productos_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_productos_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
   DATA: lv_nombre TYPE string VALUE '',
        lv_precio TYPE p DECIMALS 2 VALUE '-10.00',
        lv_stock  TYPE i VALUE 0.

  " Caso 1: nombre vacío
  IF lv_nombre IS INITIAL.
    MESSAGE ID 'ZMSG_PRODUCTO_20' TYPE 'I' NUMBER '001' INTO DATA(lv_msg1).
    out->write( lv_msg1 ).
  ENDIF.

  " Caso 2: precio negativo
  IF lv_precio < 0.
    MESSAGE ID 'ZMSG_PRODUCTO_20' TYPE 'I' NUMBER '002' INTO DATA(lv_msg2).
    out->write( lv_msg2 ).
  ENDIF.

  " Caso 3: sin stock
  IF lv_stock = 0.
    MESSAGE ID 'ZMSG_PRODUCTO_20' TYPE 'I' NUMBER '003' INTO DATA(lv_msg3).
    out->write( lv_msg3 ).
  ENDIF.

  " Caso 4: todo correcto (forzad valores válidos para ver este también)
  MESSAGE ID 'ZMSG_PRODUCTO_20' TYPE 'I' NUMBER '004' INTO DATA(lv_msg4).
  out->write( lv_msg4 ).
  ENDMETHOD.
ENDCLASS.
