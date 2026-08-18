CLASS zcl_maquina_chicles_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_chicles TYPE i,
      vender_chicle IMPORTING i_importe        TYPE i
                    RETURNING VALUE(rv_cambio) TYPE i,
      consultar_stock RETURNING VALUE(rv_chicles_r) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: chicles_r TYPE i,
          precio    TYPE i.
ENDCLASS.



CLASS ZCL_MAQUINA_CHICLES_20 IMPLEMENTATION.


  METHOD constructor.
    chicles_r = i_chicles.
    precio = 25.
  ENDMETHOD.


  METHOD consultar_stock.
    rv_chicles_r = chicles_r.
  ENDMETHOD.


  METHOD vender_chicle.
    IF chicles_r = 0 OR i_importe < precio.
      rv_cambio = i_importe.
    ELSE.
      chicles_r = chicles_r - 1.
      rv_cambio = i_importe - precio.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
