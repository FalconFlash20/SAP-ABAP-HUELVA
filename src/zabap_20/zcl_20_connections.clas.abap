CLASS zcl_20_connections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS get_connections IMPORTING i_departure          TYPE /dmo/airport_from_id
                            RETURNING VALUE(r_connections) TYPE zcert_connections.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_20_connections IMPLEMENTATION.
  METHOD get_connections.
    SELECT FROM /dmo/connection
    FIELDS carrier_id,
    airport_from_id,
    airport_to_id,
    '-' AS airport_via_id
    WHERE airport_from_id = @i_departure
    UNION
    SELECT FROM /dmo/connection AS c1
    INNER JOIN /dmo/connection AS c2
    ON c1~carrier_id = c2~carrier_id AND c1~airport_to_id = c2~airport_from_id
    FIELDS c1~carrier_id,
           c1~airport_from_id,
           c2~airport_to_id,
           c1~airport_to_id AS airport_via_id
   WHERE c1~airport_from_id = @i_departure
   AND c2~airport_to_id <> @i_departure
    INTO TABLE @r_connections.
  ENDMETHOD.

ENDCLASS.
