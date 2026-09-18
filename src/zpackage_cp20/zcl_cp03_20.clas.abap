CLASS zcl_cp03_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_cp03_20 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. Crear una instancia de ZCL_FLIGHT_MANAGER_20
    DATA(lo_manager) = NEW zcl_flight_manager_FJLF_20( ).

    out->write( '=== 1. Añadiendo 5 Vuelos Válidos ===' ).

    " 2. Añadir al menos 5 vuelos válidos
    TRY.
        lo_manager->zif_flight_manager_20~add_flight( VALUE #( aerolinea = 'LH' n_vuelo = '0400' origen = 'FRA' destino = 'JFK' precio = '899.00'  moneda = 'EUR' plazas_libres = 15 ) ).
        lo_manager->zif_flight_manager_20~add_flight( VALUE #( aerolinea = 'AA' n_vuelo = '0017' origen = 'JFK' destino = 'SFO' precio = '450.50'  moneda = 'EUR' plazas_libres = 5  ) ).
        lo_manager->zif_flight_manager_20~add_flight( VALUE #( aerolinea = 'IB' n_vuelo = '3740' origen = 'MAD' destino = 'BCN' precio = '120.00'  moneda = 'EUR' plazas_libres = 40 ) ).
        lo_manager->zif_flight_manager_20~add_flight( VALUE #( aerolinea = 'LH' n_vuelo = '0455' origen = 'FRA' destino = 'MAD' precio = '310.75'  moneda = 'EUR' plazas_libres = 8  ) ).
        lo_manager->zif_flight_manager_20~add_flight( VALUE #( aerolinea = 'SQ' n_vuelo = '0026' origen = 'SIN' destino = 'FRA' precio = '1250.00' moneda = 'EUR' plazas_libres = 3  ) ).
        out->write( '5 vuelos añadidos correctamente.' ).
      CATCH zcx_flight_error_20 INTO DATA(lx_err_init).
        out->write( |Error inicial: { lx_err_init->mv_error_text }| ).
    ENDTRY.

    " 3. Intenta añadir un vuelo con precio negativo → Captura la excepción
    out->write( |\n=== 2. Prueba Excepción: Precio Negativo ===| ).
    TRY.
        lo_manager->zif_flight_manager_20~add_flight( VALUE #( aerolinea = 'UX' n_vuelo = '1010' origen = 'MAD' destino = 'PMI' precio = '-50.00' moneda = 'EUR' ) ).
      CATCH zcx_flight_error_20 INTO DATA(lx_err_precio).
        out->write( |Excepción capturada con éxito: { lx_err_precio->mv_error_text }| ).
    ENDTRY.

    " 4. Intenta añadir un vuelo duplicado → Captura la excepción
    out->write( |\n=== 3. Prueba Excepción: Vuelo Duplicado ===| ).
    TRY.
        lo_manager->zif_flight_manager_20~add_flight( VALUE #( aerolinea = 'LH' n_vuelo = '0400' origen = 'FRA' destino = 'JFK' precio = '899.00' moneda = 'EUR' ) ).
      CATCH zcx_flight_error_20 INTO DATA(lx_err_duplicado).
        out->write( |Excepción capturada con éxito: { lx_err_duplicado->mv_error_text }| ).
    ENDTRY.

    " 5. Muestra los vuelos de una aerolínea concreta ('LH')
    out->write( |\n=== 4. Vuelos de la Aerolínea LH ===| ).
    DATA(lt_lh_flights) = lo_manager->zif_flight_manager_20~get_flights_by_airline( 'LH' ).
    out->write( lt_lh_flights ).

    " 6. Muestra el vuelo más barato
    out->write( |\n=== 5. Vuelo más Barato ===| ).
    DATA(ls_cheapest) = lo_manager->zif_flight_manager_20~get_cheapest_flight( ).
    out->write( |Vuelo: { ls_cheapest-aerolinea }-{ ls_cheapest-n_vuelo } | &&
                |Ruta: [{ ls_cheapest-origen } -> { ls_cheapest-destino }] | &&
                |Precio: { ls_cheapest-precio } { ls_cheapest-moneda }| ).

    " 7. Muestra la facturación total
    out->write( |\n=== 6. Facturación Total ===| ).
    DATA(lv_total_revenue) = lo_manager->zif_flight_manager_20~get_total_revenue( ).
    out->write( |Facturación Total de la Colección: { lv_total_revenue } EUR| ).

  ENDMETHOD.

ENDCLASS.
