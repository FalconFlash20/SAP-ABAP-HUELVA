CLASS zcl_test_empleado_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_empleado_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lo_empleado TYPE REF TO zcl_empleado_20.

    lo_empleado = NEW zcl_programador_20(
      iv_nombre   = 'Adrián'
      iv_lenguaje = 'ABAP Cloud'
    ).

    out->write( '=== 1. DATOS VÍA REFERENCIA===' ).
    out->write( |Nombre: { lo_empleado->obtener_nombre( ) }| ).

    out->write( |\n=== 2. COMPROBACIÓN DE TIPO (IS INSTANCE OF) ===| ).
    IF lo_empleado IS INSTANCE OF zcl_programador_20.
      out->write( 'Confirmado: El objeto apuntado es una instancia de ZCL_PROGRAMADOR_20' ).

      DATA(lo_programador) = CAST zcl_programador_20( lo_empleado ).

      DATA(lv_lenguaje) = lo_programador->obtener_lenguaje( ).

      out->write( |\n=== 3. DATOS VÍA REFERENCIA ESPECÍFICA (CASTING) ===| ).
      out->write( |Lenguaje de programación: { lv_lenguaje }| ).

    ELSE.
      out->write( 'El objeto NO es un programador.' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
