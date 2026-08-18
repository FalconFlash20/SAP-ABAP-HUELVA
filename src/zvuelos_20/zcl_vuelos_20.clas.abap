CLASS zcl_vuelos_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_VUELOS_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    SELECT *
*    FROM /dmo/flight
*    INTO TABLE @DATA(lt_vuelos_1).
*    IF sy-subrc = 0.
*      out->write( lt_vuelos_1 ).
*    ELSE.
*      out->write( 'No se han encontrado vuelos' ).
*    ENDIF.
*    out->write( space ).
*
*    SELECT carrier_id,connection_id,price
*    FROM /dmo/flight
*    INTO TABLE @DATA(lt_vuelos_2).
*    IF sy-subrc = 0.
*      out->write( lt_vuelos_2 ).
*    ELSE.
*      out->write( 'No se han encontrado vuelos' ).
*    ENDIF.
*    out->write( space ).
*
*    SELECT carrier_id,connection_id,flight_date,price
*    FROM /dmo/flight
*    WHERE carrier_id = 'LH'
*    INTO TABLE @DATA(lt_vuelos_3).
*    IF sy-subrc = 0.
*      out->write( lt_vuelos_3 ).
*    ELSE.
*      out->write( 'No se han encontrado vuelos de la compañia' ).
*    ENDIF.
*    out->write( space ).
*
*    select carrier_id,connection_id,price
*    from /dmo/flight
*    where price > '5000.00'
*    into table @data(lt_vuelos_4).
*    if sy-subrc = 0.
*      out->write( lt_vuelos_4 ).
*    else.
*      out->write( 'No se han encontrado vuelos' ).
*    endif.
*    out->write( space ).
*
*    select carrier_id,connection_id,plane_type_id,seats_max
*    from /dmo/flight
*    where plane_type_id = 'A380-800'
*    into table @data(lt_vuelos_5).
*    if sy-subrc = 0.
*      out->write( lt_vuelos_5 ).
*    else.
*      out->write( 'No se han encontrado vuelos' ).
*    endif.
*    out->write( space ).
*
*    select *
*    from /dmo/flight
*    where carrier_id = 'AA' and price < '1000.00'
*    into table @DATA(lt_vuelos_6).
*    if sy-subrc = 0.
*      out->write( lt_vuelos_6 ).
*    else.
*      out->write( 'No se han encontrado vuelos' ).
*    endif.
*    out->write( space ).
*
*    select carrier_id,connection_id,seats_max,seats_occupied
*    from /dmo/flight
*    where seats_occupied * 10 > seats_max * 9.
*    into table @data(lt_vuelos_7).
*    if sy-subrc = 0.
*      out->write( lt_vuelos_7 ).
*    else.
*      out->write( 'No se han encontrado vuelos' ).
*    endif.
*    out->write( space ).
*
*    select *
*    from /dmo/flight
*    where currency_code = 'EUR' or currency_code = 'USD' ORDER by price DESCENDING
*    into table @DATA(lt_vuelos_8).
*    if sy-subrc = 0.
*      out->write( lt_vuelos_8 ).
*    else.
*      out->write( 'No se han encontrado vuelos' ).
*    endif.
*    out->write( space ).
*
*    select *
*    FROM /dmo/flight
*    where ( carrier_id = 'SQ' or carrier_id = 'UA' or carrier_id = 'LH' ) and plane_type_id = '767-200'
*     ORDER by carrier_id ASCENDING , price DESCENDING
*     into table @data(lt_vuelos_9).
*     if sy-subrc = 0.
*      out->write( lt_vuelos_9 ).
*    else.
*      out->write( 'No se han encontrado vuelos' ).
*    endif.
*    out->write( space ).
*
*    select carrier_id,connection_id,flight_date,price,seats_max
*    from /dmo/flight
*    WHERE price BETWEEN '2000.00' AND '6000.00'
*    and carrier_id <> 'AA'
*    and seats_max > 200
*    ORDER by price ASCENDING
*    into table @DATA(lt_vuelos_10).
*    if sy-subrc = 0.
*      out->write( lt_vuelos_10 ).
*    else.
*      out->write( 'No se han encontrado vuelos' ).
*    endif.
*    out->write( space ).

    select single agency_id
    from /dmo/travel_m
    where travel_id = '00000011'
    into @DATA(lv_viaje).
    if sy-subrc = 0.
        select single name
        from /dmo/agency
        where agency_id = @lv_viaje
        into @DATA(lv_agencia).
        if sy-subrc = 0.
            out->write( |El nombre de la agencia es { lv_agencia }| ).
        else.
            out->write( 'La agencia no ha sido encontrada' ).
        endif.
    else.
        out->write( 'El viaje no ha sido encontrado' ).
    endif.
    out->write( space ).

    types: BEGIN OF ty_salida,
           first_name TYPE /dmo/customer-first_name,
           last_name type /dmo/customer-last_name,
           travel_id type /dmo/travel_m-travel_id,
           begin_date TYPE /dmo/travel_m-begin_date,
           total_price TYPE /dmo/travel_m-total_price,
           currency_code TYPE /dmo/travel_m-currency_code,
           end of ty_salida.

           data: ls_salida TYPE ty_salida,
                 lt_salida TYPE table of ty_salida.

           select customer_id,travel_id,begin_date,total_price,currency_code
           from /dmo/travel_m
           into table @DATA(lt_travel).

           select customer_id,FIRST_name,last_name
           from /dmo/customer
           into table @DATA(lt_customer).
           loop at lt_travel into data(ls_travel).
             read table lt_customer into data(ls_customer) with key customer_id = ls_travel-customer_id.
             if sy-subrc = 0.
               ls_salida-first_name = ls_customer-first_name.
               ls_salida-last_name = ls_customer-last_name.
               ls_salida-travel_id = ls_travel-travel_id.
               ls_salida-begin_date = ls_travel-begin_date.
               ls_salida-total_price = ls_travel-total_price.
               ls_salida-currency_code = ls_travel-currency_code.
               append ls_salida to lt_salida.
             endif.
           endloop.
           if sy-subrc = 0.
             out->write( lt_salida ).
           else.
             out->write( 'Error... No se pudo concatenar las tablas' ).
               endif.

  ENDMETHOD.
ENDCLASS.
