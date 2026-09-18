INTERFACE zif_flight_manager_20
  PUBLIC .

  TYPES: tt_vuelos TYPE STANDARD TABLE OF zvuelos_20 WITH DEFAULT KEY.

  METHODS add_flight
    IMPORTING
      is_flight TYPE zvuelos_20
    RAISING
      zcx_flight_error_20.

  METHODS get_flights_by_airline
    IMPORTING
      iv_airline        TYPE zvuelos_20-aerolinea
    RETURNING
      VALUE(rt_flights) TYPE tt_vuelos.

  METHODS get_cheapest_flight
    RETURNING
      VALUE(rs_flight) TYPE zvuelos_20.

  METHODS get_total_revenue
    RETURNING
      VALUE(rv_total) TYPE zvuelos_20-precio.

ENDINTERFACE.

