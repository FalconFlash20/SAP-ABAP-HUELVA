CLASS zcl_flight_manager_fjlf_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_flight_manager_20.

    METHODS constructor
      IMPORTING
        it_flights TYPE zif_flight_manager_20=>tt_vuelos OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mt_flights TYPE zif_flight_manager_20=>tt_vuelos.

ENDCLASS.

CLASS zcl_flight_manager_fjlf_20 IMPLEMENTATION.

  METHOD constructor.
    IF it_flights IS SUPPLIED.
      mt_flights = it_flights.
    ENDIF.
  ENDMETHOD.

  METHOD zif_flight_manager_20~add_flight.
    " 1. Validación de precio positivo
    IF is_flight-precio <= 0.
      RAISE EXCEPTION TYPE zcx_flight_error_20
        EXPORTING
          mv_error_text = |El precio debe ser un valor positivo ({ is_flight-precio } € no válido)|.
    ENDIF.

    " 2. Validación de vuelo duplicado (misma aerolínea y número)
    IF line_exists( mt_flights[ aerolinea = is_flight-aerolinea n_vuelo = is_flight-n_vuelo ] ).
      RAISE EXCEPTION TYPE zcx_flight_error_20
        EXPORTING
          mv_error_text = |El vuelo { is_flight-aerolinea }-{ is_flight-n_vuelo } ya existe en la colección|.
    ENDIF.

    " Si supera las validaciones, se añade
    INSERT is_flight INTO TABLE mt_flights.
  ENDMETHOD.

  METHOD zif_flight_manager_20~get_flights_by_airline.
    " Filtrado mediante expresión VALUE con FOR WHERE
    rt_flights = VALUE #( FOR ls_v IN mt_flights WHERE ( aerolinea = iv_airline ) ( ls_v ) ).
  ENDMETHOD.

  METHOD zif_flight_manager_20~get_cheapest_flight.
    IF mt_flights IS INITIAL.
      RETURN.
    ENDIF.

    " Encontrar el mínimo con la expresión REDUCE
    rs_flight = REDUCE #(
      INIT cheap = mt_flights[ 1 ]
      FOR ls_f IN mt_flights
      NEXT cheap = COND #( WHEN ls_f-precio < cheap-precio THEN ls_f ELSE cheap )
    ).
  ENDMETHOD.

  METHOD zif_flight_manager_20~get_total_revenue.
    " Sumatorio del total con la expresión REDUCE
    rv_total = REDUCE #(
      INIT total = CONV zvuelos_20-precio( 0 )
      FOR ls_f IN mt_flights
      NEXT total = total + ls_f-precio
    ).
  ENDMETHOD.

ENDCLASS.
