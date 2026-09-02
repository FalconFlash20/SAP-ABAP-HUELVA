CLASS zcl_candidato_interno_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_candidato_20
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA puntuacion_base_interna TYPE i VALUE 5.

    METHODS calcular_idoneidad REDEFINITION.
ENDCLASS.

CLASS zcl_candidato_interno_20 IMPLEMENTATION.

  METHOD calcular_idoneidad.
    DATA(lv_calculado) = CONV decfloat34( ( me->anios_experiencia * '0.6' ) + ( me->puntuacion_base_interna * '0.4' ) ).
    rv_idoneidad = COND decfloat34( WHEN lv_calculado > 10 THEN 10 ELSE lv_calculado ).
  ENDMETHOD.

ENDCLASS.
