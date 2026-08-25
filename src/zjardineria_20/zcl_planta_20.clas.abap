CLASS zcl_planta_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    CONSTANTS c_riego_minimo TYPE i VALUE 20.

    " Constructor para inicializar los datos de la planta
    METHODS constructor
      IMPORTING
        i_nombre TYPE string
        i_stock  TYPE i
        i_riego  TYPE i.

    " Método para realizar la venta de unidades
    METHODS vender
      IMPORTING
        i_cantidad TYPE i
      RAISING
        zcx_explanta_20.

    " Método para regar la planta
    METHODS regar
      IMPORTING
        i_cantidad TYPE i.

    " Métodos GETTER opcionales para consultar estado
    METHODS get_stock RETURNING VALUE(rv_stock) TYPE i.
    METHODS get_riego RETURNING VALUE(rv_riego) TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA nombre TYPE string.
    DATA stock  TYPE i.
    DATA riego  TYPE i.

ENDCLASS.

CLASS zcl_planta_20 IMPLEMENTATION.

  METHOD constructor.
    me->nombre = i_nombre.
    me->stock  = i_stock.
    me->riego  = i_riego.
  ENDMETHOD.

  METHOD vender.
    " 1. Validar nivel de riego mínimo
    IF me->riego < c_riego_minimo.
      RAISE EXCEPTION TYPE zcx_explanta_20
        EXPORTING
          textid          = zcx_explanta_20=>riego_insuficiente
          mv_riego        = me->riego
          mv_riego_minimo = c_riego_minimo.
    ENDIF.

    " 2. Validar disponibilidad de stock
    IF me->stock < i_cantidad.
      RAISE EXCEPTION TYPE zcx_explanta_20
        EXPORTING
          textid        = zcx_explanta_20=>stock_insuficiente
          mv_stock      = me->stock
          mv_solicitado = i_cantidad.
    ENDIF.

    " 3. Si las validaciones pasan, se descuenta el stock
    me->stock -= i_cantidad.
  ENDMETHOD.

  METHOD regar.
    me->riego += i_cantidad.
    IF me->riego > 100.
      me->riego = 100.
    ENDIF.
  ENDMETHOD.

  METHOD get_stock.
    rv_stock = me->stock.
  ENDMETHOD.

  METHOD get_riego.
    rv_riego = me->riego.
  ENDMETHOD.

ENDCLASS.
