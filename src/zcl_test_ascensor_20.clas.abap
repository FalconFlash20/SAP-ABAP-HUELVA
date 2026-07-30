CLASS zcl_test_ascensor_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_ascensor_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_ascensor) = NEW zcl_ascensor_20( i_planta_max = 10 i_peso_max = 400 ).
    DATA: lv_planta    TYPE i,
          lv_peso      TYPE i,
          lv_bloqueado TYPE abap_bool.

    lo_ascensor->entrar_peso( 300 ).
    lo_ascensor->consultar_estado( IMPORTING o_planta_act = lv_planta o_peso_act = lv_peso o_bloqueado = lv_bloqueado ).
    out->write( |Planta: { lv_planta }, Peso: { lv_peso }, Bloqueado: { lv_bloqueado }| ).
    lo_ascensor->entrar_peso( 150 ).
    lo_ascensor->consultar_estado( IMPORTING o_planta_act = lv_planta o_peso_act = lv_peso o_bloqueado = lv_bloqueado ).
    out->write( |Planta: { lv_planta }, Peso: { lv_peso }, Bloqueado: { lv_bloqueado }| ).
    lo_ascensor->subir_planta( 5 ).
    lo_ascensor->consultar_estado( IMPORTING o_planta_act = lv_planta o_peso_act = lv_peso o_bloqueado = lv_bloqueado ).
    out->write( |Planta: { lv_planta }, Peso: { lv_peso }, Bloqueado: { lv_bloqueado }| ).
    lo_ascensor->vaciar( ).
    lo_ascensor->consultar_estado( IMPORTING o_planta_act = lv_planta o_peso_act = lv_peso o_bloqueado = lv_bloqueado ).
    out->write( |Planta: { lv_planta }, Peso: { lv_peso }, Bloqueado: { lv_bloqueado }| ).
    lo_ascensor->subir_planta( 5 ).
    lo_ascensor->consultar_estado( IMPORTING o_planta_act = lv_planta o_peso_act = lv_peso o_bloqueado = lv_bloqueado ).
    out->write( |Planta: { lv_planta }, Peso: { lv_peso }, Bloqueado: { lv_bloqueado }| ).
    lo_ascensor->subir_planta( 15 ).
    lo_ascensor->consultar_estado( IMPORTING o_planta_act = lv_planta o_peso_act = lv_peso o_bloqueado = lv_bloqueado ).
    out->write( |Planta: { lv_planta }, Peso: { lv_peso }, Bloqueado: { lv_bloqueado }| ).
  ENDMETHOD.
ENDCLASS.
