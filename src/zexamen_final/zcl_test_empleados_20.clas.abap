CLASS zcl_test_empleados_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
    CONSTANTS:
      c_alta         TYPE i VALUE 1,
      c_modificacion TYPE i VALUE 2,
      c_consulta_1   TYPE i VALUE 3,
      c_consulta_2   TYPE i VALUE 4.

ENDCLASS.


CLASS zcl_test_empleados_20 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(lv_opcion) = c_consulta_2.
    CASE lv_opcion.
      WHEN c_alta.
        DATA(lo_empleado) = NEW zcl_empleados_20(
                              iv_nombre          = 'Francisco'
                              iv_apellido        = 'Lopez Fiestas'
                              iv_telefono        = '600123456'
                              iv_experiencia     = 3
                              iv_certificaciones = 2 ).
       out->write( lo_empleado->alta_empleado( ) ).
        out->write( lo_empleado->consultar_empleados( 0 ) ).
      WHEN c_modificacion.
        DATA(lo_mod) = NEW zcl_empleados_20(
                         iv_nombre          = 'Francisco'
                         iv_apellido        = 'Lopez'
                         iv_telefono        = '600000000'
                         iv_experiencia     = 0
                         iv_certificaciones = 0 ).
        out->write( lo_mod->modificar_empleado(
                      iv_id              = 1
                      iv_nombre          = 'Jossue'
                      iv_apellido        = 'Lopez Fiestas'
                      iv_telefono        = '611222333'
                      iv_experiencia     = 5
                      iv_certificaciones = 4 ) ).
        out->write( lo_mod->consultar_empleados( 0 ) ).
      WHEN c_consulta_1.
        DATA(lo_cons1) = NEW zcl_empleados_20(
                           iv_nombre          = 'Consulta'
                           iv_apellido        = 'Consulta'
                           iv_telefono        = ''
                           iv_experiencia     = 0
                           iv_certificaciones = 0 ).
        out->write( name = 'Empleado con ID 1'
                    data = lo_cons1->consultar_empleados( 1 ) ).
        out->write( name = 'Todos los empleados'
                    data = lo_cons1->consultar_empleados( 0 ) ).
      WHEN c_consulta_2.
        DATA(lo_cons2) = NEW zcl_empleados_20(
                           iv_nombre          = 'Consulta'
                           iv_apellido        = 'Consulta'
                           iv_telefono        = ''
                           iv_experiencia     = 0
                           iv_certificaciones = 0 ).
        out->write( name = 'Primeros 3 empleados'
                    data = lo_cons2->consultar_n_registros( 3 ) ).
      WHEN OTHERS.
        out->write( 'Opcion no valida.' ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
