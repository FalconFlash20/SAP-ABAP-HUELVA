CLASS zcl_test_dron_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_DRON_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  data(lo_dron) = NEW zcl_dron_20( i_carga_max = 5 ).
    DATA: lv_bateria   TYPE i,
          lv_carga_act TYPE i,
          lv_reserva   TYPE abap_bool,
          lv_exito     TYPE abap_bool.
    lv_exito = lo_dron->recoger_paquete( 3 ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria o_carga_act = lv_carga_act o_reserva = lv_reserva ).
    out->write( |Bateria: { lv_bateria }, Carga actual: { lv_carga_act }, Modo reserva: { lv_reserva } | ).
    lv_exito = lo_dron->volar_a_cliente(  ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria o_carga_act = lv_carga_act o_reserva = lv_reserva ).
    out->write( |Bateria: { lv_bateria }, Carga actual: { lv_carga_act }, Modo reserva: { lv_reserva } | ).
    DO 6 TIMES.
      lv_exito = lo_dron->recoger_paquete( 2 ).
      lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria o_carga_act = lv_carga_act o_reserva = lv_reserva ).
      out->write( |Bateria: { lv_bateria }, Carga actual: { lv_carga_act }, Modo reserva: { lv_reserva } | ).
      lv_exito = lo_dron->volar_a_cliente(  ).
      lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria o_carga_act = lv_carga_act o_reserva = lv_reserva ).
      out->write( |Bateria: { lv_bateria }, Carga actual: { lv_carga_act }, Modo reserva: { lv_reserva } | ).
    ENDDO.
    lo_dron->recargar(  ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria o_carga_act = lv_carga_act o_reserva = lv_reserva ).
    out->write( |Bateria: { lv_bateria }, Carga actual: { lv_carga_act }, Modo reserva: { lv_reserva } | ).
    lv_exito = lo_dron->recoger_paquete( 2 ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria o_carga_act = lv_carga_act o_reserva = lv_reserva ).
    out->write( |Bateria: { lv_bateria }, Carga actual: { lv_carga_act }, Modo reserva: { lv_reserva } | ).
    lv_exito = lo_dron->volar_a_cliente(  ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria o_carga_act = lv_carga_act o_reserva = lv_reserva ).
    out->write( |Bateria: { lv_bateria }, Carga actual: { lv_carga_act }, Modo reserva: { lv_reserva } | ).
  ENDMETHOD.
ENDCLASS.
