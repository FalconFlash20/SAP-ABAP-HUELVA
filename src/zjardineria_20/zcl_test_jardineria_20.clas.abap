CLASS zcl_test_jardineria_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_test_jardineria_20 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( '=== CASO 1: Venta correcta ===' ).
    TRY.
        " Planta con stock = 10 y riego = 50 (suficiente)
        DATA(lo_orquidea) = NEW zcl_planta_20(
          i_nombre = 'Orquídea'
          i_stock  = 10
          i_riego  = 50
        ).

        lo_orquidea->vender( 3 ).
        out->write( |Venta realizada con éxito. Stock restante: { lo_orquidea->get_stock( ) }| ).

      CATCH zcx_explanta_20 INTO DATA(lx_ex1).
        out->write( lx_ex1->get_text( ) ).
    ENDTRY.

    out->write( ' ' ).
    out->write( '=== CASO 2: Error por Stock Insuficiente ===' ).
    TRY.
        " Planta con stock = 2 e intentamos vender 5
        DATA(lo_cactus) = NEW zcl_planta_20(
          i_nombre = 'Cactus'
          i_stock  = 2
          i_riego  = 80
        ).

        lo_cactus->vender( 5 ).
        out->write( 'Venta realizada con éxito.' ).

      CATCH zcx_explanta_20 INTO DATA(lx_ex2).
        out->write( lx_ex2->get_text( ) ).
    ENDTRY.

    out->write( ' ' ).
    out->write( '=== CASO 3: Error por Riego Insuficiente ===' ).
    TRY.
        " Planta con riego = 10 (por debajo del mínimo de 20)
        DATA(lo_helecho) = NEW zcl_planta_20(
          i_nombre = 'Helecho'
          i_stock  = 15
          i_riego  = 10
        ).

        lo_helecho->vender( 1 ).
        out->write( 'Venta realizada con éxito.' ).

      CATCH zcx_explanta_20 INTO DATA(lx_ex3).
        out->write( lx_ex3->get_text( ) ).
    ENDTRY.

    out->write( ' ' ).
    out->write( '=== CASO 4: Recuperación tras regar la planta ===' ).
    TRY.
        " Regamos el helecho del caso anterior y volvemos a intentar la venta
        lo_helecho->regar( 30 ). " Sube a 40%
        out->write( |Planta regada. Nivel actual: { lo_helecho->get_riego( ) }%| ).

        lo_helecho->vender( 1 ).
        out->write( |Venta posterior realizada con éxito. Stock restante: { lo_helecho->get_stock( ) }| ).

      CATCH zcx_explanta_20 INTO DATA(lx_ex4).
        out->write( lx_ex4->get_text( ) ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
