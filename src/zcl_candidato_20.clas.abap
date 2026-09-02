CLASS zcl_candidato_20 DEFINITION
  PUBLIC
  CREATE PUBLIC .
  PUBLIC SECTION.
    DATA id                   TYPE i.
    DATA nombre_completo      TYPE string.
    DATA anios_experiencia    TYPE i.
    DATA dni                 TYPE string.
    DATA telefono_personal   TYPE string.
    DATA salario_actual      TYPE p LENGTH 8 DECIMALS 2.
    DATA salario_pretendido  TYPE p LENGTH 8 DECIMALS 2.
    DATA puntuacion_entrevista TYPE i VALUE 0.

    METHODS constructor
      IMPORTING
        i_id                 TYPE i
        i_nombre             TYPE string
        i_experiencia        TYPE i
        iv_dni               TYPE string
        i_telefono           TYPE string
        i_salario_actual     TYPE p
        i_salario_pretendido TYPE p.



    METHODS anadir_puntos_entrevista
      IMPORTING
        i_puntos TYPE i.

    METHODS obtener_idoneidad_final
      RETURNING
        VALUE(rv_idoneidad_final) TYPE i.

    METHODS comparar_con
      IMPORTING
        i_otro              TYPE REF TO zcl_candidato_20
      RETURNING
        VALUE(rv_resultado) TYPE string.

    METHODS calcular_banda_salarial
      RETURNING
        VALUE(rv_banda) TYPE string.
    METHODS calcular_idoneidad
      RETURNING
        VALUE(rv_idoneidad) TYPE decfloat34.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_candidato_20 IMPLEMENTATION.

  METHOD constructor.
    me->id                  = i_id.
    me->nombre_completo     = i_nombre.
    me->anios_experiencia   = i_experiencia.
    me->dni                = iv_dni.
    me->telefono_personal  = i_telefono.
    me->salario_actual     = i_salario_actual.
    me->salario_pretendido = i_salario_pretendido.
  ENDMETHOD.

  METHOD calcular_idoneidad.
    DATA(lv_calculado) = CONV decfloat34( me->anios_experiencia * '0.5' ).
    rv_idoneidad = COND decfloat34( WHEN lv_calculado > 10 THEN 10 ELSE lv_calculado ).
  ENDMETHOD.

  METHOD anadir_puntos_entrevista.
    me->puntuacion_entrevista += i_puntos.
  ENDMETHOD.

  METHOD obtener_idoneidad_final.
    DATA(lv_base) = me->calcular_idoneidad( ) + ( CONV decfloat34( me->puntuacion_entrevista ) / 10 ).
    rv_idoneidad_final = CONV i( round( val = lv_base dec = 0 ) ).
  ENDMETHOD.

  METHOD comparar_con.
    DATA(lv_mi_idoneidad) = me->obtener_idoneidad_final( ).
    DATA(lv_otra_idoneidad) = i_otro->obtener_idoneidad_final( ).

    rv_resultado = COND string(
      WHEN lv_mi_idoneidad > lv_otra_idoneidad THEN me->nombre_completo
      WHEN lv_otra_idoneidad > lv_mi_idoneidad THEN i_otro->nombre_completo
      ELSE 'EMPATE'
    ).
  ENDMETHOD.

  METHOD calcular_banda_salarial.
    DATA(lv_inferior) = CONV i( floor( me->salario_pretendido / 5000 ) * 5000 ).
    DATA(lv_superior) = CONV i( ceil( me->salario_pretendido / 5000 ) * 5000 ).

    IF lv_inferior = lv_superior.
      lv_superior += 5000.
    ENDIF.

    rv_banda = |{ lv_inferior } - { lv_superior }|.
  ENDMETHOD.

ENDCLASS.
