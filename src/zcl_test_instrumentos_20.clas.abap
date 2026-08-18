CLASS zcl_test_instrumentos_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_INSTRUMENTOS_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_guitarra) = NEW zcl_guitarra_20( i_marca = 'Yamaha' i_num_cuerdas = 6 ).
    DATA(lo_piano) = NEW zcl_piano_20( i_marca = 'Roland' i_es_electrico = abap_false ).
    out->write( |Exito: { lo_guitarra->afinar_cuerda( 8 ) }| ).
    out->write( |Exito: { lo_guitarra->afinar_cuerda( 3 ) }| ).
    out->write( |Exito: { lo_piano->pedalear( ) }| ).
    lo_piano->registrar_practica( 2 ).
    out->write( |Exito: { lo_piano->pedalear( ) }| ).
    lo_guitarra->registrar_practica( 1 ).
    out->write( |Guitarra: { lo_guitarra->consultar_horas_uso(  ) }, Piano: { lo_piano->consultar_horas_uso(  ) }| ).
  ENDMETHOD.
ENDCLASS.
