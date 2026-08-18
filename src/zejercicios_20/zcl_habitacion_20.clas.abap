CLASS zcl_habitacion_20 DEFINITION
  PUBLIC
  CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-DATA total_habitaciones_creadas TYPE i.
    CLASS-METHODS consultar_total_habitaciones RETURNING VALUE(rv_total) TYPE i.
    METHODS:
      constructor IMPORTING i_numero_habitacion TYPE string
                            i_precio_noche      TYPE zdecimals2,
      calcular_precio_total IMPORTING i_numero_noches   TYPE i
                            RETURNING VALUE(rv_importe) TYPE zdecimals2,
      registrar_reserva,
      consultar_veces_reservada RETURNING VALUE(rv_veces) TYPE i.
PROTECTED SECTION.
    DATA: numero_habitacion TYPE string,
          precio_noche      TYPE zdecimals2.
PRIVATE SECTION.
    data veces_reservada type i.

ENDCLASS.



CLASS zcl_habitacion_20 IMPLEMENTATION.
  METHOD consultar_total_habitaciones.
    rv_total = total_habitaciones_creadas.
  ENDMETHOD.

  METHOD calcular_precio_total.
    rv_importe = i_numero_noches * precio_noche.
  ENDMETHOD.

  METHOD constructor.
    me->numero_habitacion = i_numero_habitacion.
    me->precio_noche = i_precio_noche.
    veces_reservada = 0.
    total_habitaciones_creadas += 1.
  ENDMETHOD.

  METHOD consultar_veces_reservada.
    rv_veces = veces_reservada.
  ENDMETHOD.

  METHOD registrar_reserva.
    veces_reservada += 1.
  ENDMETHOD.

ENDCLASS.
