CLASS zcl_test_20_connections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_20_connections IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  " 1. Instanciamos la clase de conexiones mediante NEW #( )
    DATA(lo_connections) = NEW zcl_20_connections( ).

    " 2. Prueba 1: Buscar conexiones directas e indirectas desde 'FRA' (Frankfurt)
    DATA(lv_origen) = CONV /dmo/airport_from_id( 'FRA' ).
    DATA(lt_resultado_fra) = lo_connections->get_connections( i_departure = lv_origen ).

    out->write( '=== 1. CONEXIONES ENCONTRADAS DESDE FRA ===' ).
    out->write( lt_resultado_fra ).

    " 3. Prueba 2: Buscar para un aeropuerto inexistente 'XXXX'
    DATA(lt_resultado_vacio) = lo_connections->get_connections( i_departure = 'XXX' ).

    out->write( |\n=== 2. PRUEBA CON ORIGEN INEXISTENTE (XXXX) ===| ).
    IF lt_resultado_vacio IS INITIAL.
      out->write( 'Resultado correcto: La tabla devuelta está vacía.' ).
    ELSE.
      out->write( lt_resultado_vacio ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
