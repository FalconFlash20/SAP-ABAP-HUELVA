CLASS zcl_inner_join_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_INNER_JOIN_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*"Vuelos con su avión y su aerolínea"*
*    SELECT c~name,
*           f~connection_id,
*           f~flight_date,
*           f~price,
*           f~currency_code,
*           f~plane_type_id
*    FROM /dmo/flight AS f
*    INNER JOIN /dmo/carrier AS c
*    ON f~carrier_id = c~carrier_id
*    WHERE f~price > 5000
*    ORDER BY f~price DESCENDING
*    INTO TABLE @DATA(lt_vuelos).
*    IF sy-subrc = 0.
*      out->write( lt_vuelos ).
*    ELSE.
*      out->write( 'No se han encontrado vuelos' ).
*    ENDIF.
*"¿Quién reservó cada vuelo?"*
*
*    SELECT
*     c~first_name,
*     c~last_name,
*     b~travel_id,
*     b~booking_id,
*     b~booking_date
*     FROM /dmo/booking AS b
*     INNER JOIN /dmo/customer AS c
*     ON b~customer_id = c~customer_id
*     INTO TABLE @DATA(lt_reservas).
*    IF sy-subrc = 0.
*      out->write( lt_reservas ).
*    ELSE.
*      out->write( 'No se han encontrado reservas' ).
*    ENDIF.
    "El itirenario completo de una reserva
*    SELECT
*    c~name,
*    b~connection_id,
*    b~flight_date,
*    f~plane_type_id,
*    b~booking_id
*    FROM /dmo/booking AS b
*    INNER JOIN /dmo/flight AS f
*    ON b~carrier_id    = f~carrier_id
*    AND b~connection_id = f~connection_id
*    AND b~flight_date   = f~flight_date
*    INNER JOIN /dmo/carrier AS c
*    ON b~carrier_id = c~carrier_id
*    INTO TABLE @DATA(lt_itinerario).
*    IF sy-subrc = 0.
*      out->write( lt_itinerario ).
*    ELSE.
*      out->write( 'No se han encontrado itinerarios' ).
*    ENDIF.
*    DATA(lv_customer_id) = '000555'.
*    DATA(lv_connection_id) = '0322'.
*    SELECT
*    a~name,
*    a~agency_id,
*    t~customer_id,
*    t~travel_id
*    FROM /dmo/booking AS b
*    INNER JOIN /dmo/travel AS t
*    ON b~travel_id = t~travel_id
*    INNER JOIN /dmo/agency AS a
*    ON t~agency_id = a~agency_id
*    WHERE b~customer_id = @lv_customer_id
*    AND b~connection_id = @lv_connection_id
*    INTO TABLE @DATA(lt_salida).
*    IF sy-subrc = 0.
*      out->write( lt_salida ).
*    ELSE.
*      out->write( 'No se han encontrado vuelos' ).
*    ENDIF.
*    out->write( space ).
*
*
*    "Ejercicio 1
*    SELECT
*    t~travel_id,
*    a~name,
*    t~begin_date,
*    t~status
*    FROM /dmo/travel AS t
*    INNER JOIN /dmo/agency AS a
*    ON t~agency_id = a~agency_id
*    INTO TABLE @DATA(lt_salida_1).
*    IF sy-subrc = 0.
*      out->write( lt_salida_1 ).
*    ELSE.
*      out->write( 'No se han encontrado vuelos' ).
*    ENDIF.
*    out->write( space ).
*    "Ejercicio 2
*    select
*    f~connection_id,
*    f~flight_date,
*    f~price,
*    f~currency_code,
*    orig~name as norig,
*    orig~city as corig,
*    dest~name,
*    dest~city
*    from /dmo/flight as f
*    inner join /dmo/connection as c
*    on f~carrier_id = c~carrier_id
*    and f~connection_id = c~connection_id
*    inner join /dmo/airport as orig
*    on c~airport_from_id = orig~airport_id
*    inner join /dmo/airport as dest
*    on c~airport_to_id = dest~airport_id
*    into table @data(lt_salida_2).
*    if sy-subrc = 0.
*      out->write( lt_salida_2 ).
*    else.
*      out->write( 'No se han encontrado vuelos' ).
*    endif.
*    out->write( space ).
    "Ejercicio 3
    select
    bsup~travel_id,
    bsup~booking_id,
    cust~customer_id,
    cust~first_name,
    cust~last_name,
    sup~supplement_category,
    bsup~price,
    bsup~currency_code
    from /dmo/book_suppl as bsup
    inner join /dmo/booking as b
    on bsup~travel_id = b~travel_id
    and bsup~booking_id = b~booking_id
    inner join /dmo/customer as cust
    on b~customer_id = cust~customer_id
    inner join /dmo/supplement as sup
    on bsup~supplement_id = sup~supplement_id
    into table @data(lt_salida_3).
    if sy-subrc = 0.
      out->write( lt_salida_3 ).
    else.
      out->write( 'No se han encontrado vuelos' ).
    endif.
    out->write( space ).
  ENDMETHOD.
ENDCLASS.
