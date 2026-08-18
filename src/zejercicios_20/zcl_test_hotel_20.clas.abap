CLASS zcl_test_hotel_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_hotel_20 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( |1. Total habitaciones creadas inicialmente: { zcl_habitacion_20=>consultar_total_habitaciones( ) }| ).
    DATA(lo_hab101) = NEW zcl_habitacion_estandar_20(
      i_numero_habitacion = '101'
      i_precio_noche      = '60.00'
      i_tiene_vistas_mar  = abap_true
    ).

    DATA(lo_hab102) = NEW zcl_habitacion_estandar_20(
      i_numero_habitacion = '102'
      i_precio_noche      = '60.00'
      i_tiene_vistas_mar  = abap_false
    ).

    DATA(lo_hab201) = NEW zcl_habitacion_suite_20(
      i_numero_habitacion = '201'
      i_precio_noche      = '100.00'
      i_incluye_jacuzzi   = abap_true
    ).

    out->write( |3. Total habitaciones tras instanciacion: { zcl_habitacion_20=>consultar_total_habitaciones( ) }| ).

    out->write( '4. Precios calculados por noches:' ).
    out->write( |   - Hab 101 (3 noches): { lo_hab101->calcular_precio_total( 3 ) } EUR (Esperado: 195,00 EUR)| ).
    out->write( |   - Hab 102 (3 noches): { lo_hab102->calcular_precio_total( 3 ) } EUR (Esperado: 180,00 EUR)| ).
    out->write( |   - Hab 201 (2 noches): { lo_hab201->calcular_precio_total( 2 ) } EUR (Esperado: 385,00 EUR)| ).

    DATA: lt_habitaciones TYPE TABLE OF REF TO zcl_habitacion_20.
    lt_habitaciones = VALUE #( ( lo_hab101 ) ( lo_hab102 ) ( lo_hab201 ) ).

    out->write( '5. Precios recorriendo tabla polimorfica (1 noche):' ).
    LOOP AT lt_habitaciones INTO DATA(lo_hab).
      out->write( |   - Precio a 1 noche: { lo_hab->calcular_precio_total( 1 ) } EUR| ).
    ENDLOOP.

    DATA: lt_describibles TYPE TABLE OF REF TO zif_describible_20.
    lt_describibles = VALUE #( ( lo_hab101 ) ( lo_hab102 ) ( lo_hab201 ) ).

    out->write( '6. Descripciones desde la interfaz ZIF_DESCRIBIBLE_20:' ).
    LOOP AT lt_describibles INTO DATA(lo_desc).
      out->write( |   - { lo_desc->describir( ) }| ).
    ENDLOOP.

    lo_hab101->registrar_reserva( ).
    lo_hab101->registrar_reserva( ).
    lo_hab201->registrar_reserva( ).

    out->write( '7. Veces reservada cada habitacion:' ).
    out->write( |   - Hab 101: { lo_hab101->consultar_veces_reservada( ) } (Esperado: 2)| ).
    out->write( |   - Hab 201: { lo_hab201->consultar_veces_reservada( ) } (Esperado: 1)| ).

    out->write( '' ).
    out->write( '=== PARTE B: OPERACIONES CRUD BASE DE DATOS ===' ).

    DATA(lv_id_res1) = zcl_gestor_reservas_20=>crear_reserva(
      i_numero_habitacion = '101'
      i_cliente           = 'Fran'
    ).

    DATA(lv_id_res2) = zcl_gestor_reservas_20=>crear_reserva(
      i_numero_habitacion = '201'
      i_cliente           = 'Jesus'
    ).

    out->write( |8. Reservas creadas en BD:| ).
    out->write( |   - ID Reserva 1 (Fran): { lv_id_res1 }| ).
    out->write( |   - ID Reserva 2 (Jesus): { lv_id_res2 }| ).

    DATA: lv_num_hab TYPE zreserva_20-numero_habitacion,
          lv_cliente TYPE zreserva_20-cliente,
          lv_estado  TYPE zreserva_20-estado,
          lv_hallado TYPE abap_bool.

    lv_hallado = zcl_gestor_reservas_20=>consultar_reserva(
      EXPORTING
        i_id_reserva        = lv_id_res1
      IMPORTING
        o_numero_habitacion = lv_num_hab
        o_cliente           = lv_cliente
        o_estado            = lv_estado
    ).

    out->write( |9. Consulta Reserva { lv_id_res1 }: Hab { lv_num_hab } | &&
                |/ Cliente { lv_cliente } / Estado { lv_estado }| ).

    zcl_gestor_reservas_20=>liberar_reserva( lv_id_res1 ).

    zcl_gestor_reservas_20=>consultar_reserva(
      EXPORTING
        i_id_reserva = lv_id_res1
      IMPORTING
        o_estado     = lv_estado
    ).

    out->write( |10. Estado Reserva { lv_id_res1 } tras liberar: { lv_estado }| ).

    zcl_gestor_reservas_20=>eliminar_reserva( lv_id_res2 ).

    lv_hallado = zcl_gestor_reservas_20=>consultar_reserva(
      EXPORTING
        i_id_reserva = lv_id_res2
    ).

    IF lv_hallado = abap_false.
      out->write( |11. Comprobacion: La Reserva { lv_id_res2 } ya no existe en la BD.| ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
