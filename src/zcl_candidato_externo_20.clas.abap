CLASS zcl_candidato_externo_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_candidato_20
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA num_certificaciones TYPE i.

    METHODS constructor
      IMPORTING
        i_id                 TYPE i
        i_nombre             TYPE string
        i_experiencia        TYPE i
        iv_dni               TYPE string
        i_telefono           TYPE string
        i_salario_actual     TYPE p
        i_salario_pretendido TYPE p
        i_certificaciones    TYPE i.

    METHODS calcular_idoneidad REDEFINITION.
ENDCLASS.

CLASS zcl_candidato_externo_20 IMPLEMENTATION.

  METHOD constructor.
    super->constructor(
      i_id                 = i_id
      i_nombre             = i_nombre
      i_experiencia        = i_experiencia
      iv_dni               = iv_dni
      i_telefono           = i_telefono
      i_salario_actual     = i_salario_actual
      i_salario_pretendido = i_salario_pretendido
    ).
    me->num_certificaciones = i_certificaciones.
  ENDMETHOD.

  METHOD calcular_idoneidad.
    DATA(lv_calculado) = CONV decfloat34( ( me->anios_experiencia * '0.3' ) + ( me->num_certificaciones * '1.5' ) ).
    rv_idoneidad = COND decfloat34( WHEN lv_calculado > 10 THEN 10 ELSE lv_calculado ).
  ENDMETHOD.

ENDCLASS.
