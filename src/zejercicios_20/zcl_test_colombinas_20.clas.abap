CLASS zcl_test_colombinas_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_COLOMBINAS_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lo_caseta    TYPE REF TO zcl_caseta_20,
          lo_atf       TYPE REF TO zcl_atraccion_feria_20,
          lo_concierto TYPE REF TO zcl_concierto_20.
    DATA: lt_atracciones TYPE TABLE OF REF TO zcl_atraccion_20.
    lo_caseta = NEW zcl_caseta_20(
      i_nombre_cas = 'Caseta El Pintao'
      i_rebujitos  = 50
    ).
    lo_atf = NEW zcl_atraccion_feria_20(
      i_nombre_atf = 'Noria Gigante'
      i_precio     = '3.00'
    ).
    lo_concierto = NEW zcl_concierto_20(
      i_nombre_c = 'Concierto Manuel Carrasco'
    ).
    lt_atracciones = VALUE #(
      ( lo_caseta )
      ( lo_atf )
      ( lo_concierto )
    ).
    out->write( '--- RECORRIENDO ATRACCIONES EN EL RECINTO (LOOP) ---' ).
    LOOP AT lt_atracciones INTO DATA(lo_atraccion).
      lo_atraccion->recibir_visitante( ).
      DATA(lv_precio) = lo_atraccion->calcular_precio_entrada( ).
      out->write(
                  |-> Precio Entrada: { lv_precio } €| ).
    ENDLOOP.
    out->write( '--- SIMULANDO LLEGADA DE 500 VISITANTES AL CONCIERTO ---' ).
    DO 500 TIMES.
      lo_concierto->recibir_visitante( ).
    ENDDO.
    DATA(lv_visitantes_totales) = lo_concierto->consultar_visitantes( ).
    DATA(lv_precio_rebajado)    = lo_concierto->calcular_precio_entrada( ).
    out->write( |Visitantes actuales en el concierto: { lv_visitantes_totales }| ).
    out->write( |Nuevo precio entrada tras superar los 500 asistentes: { lv_precio_rebajado } EUR| ).

  ENDMETHOD.
ENDCLASS.
