CLASS zcl_caja_fuerte_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_codigo TYPE i,
      abrir IMPORTING i_codigo        TYPE i
            RETURNING VALUE(rv_exito) TYPE abap_bool,
      get_bloqueada RETURNING VALUE(rv_bloqueada) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: codigo            TYPE string,
          intentos_fallidos TYPE i,
          esta_bloqueada    TYPE abap_bool.
ENDCLASS.



CLASS zcl_caja_fuerte_20 IMPLEMENTATION.
  METHOD abrir.
    rv_exito = abap_false.
    IF esta_bloqueada = abap_false.
      IF codigo = i_codigo.
        rv_exito = abap_true.
      ELSE.
        intentos_fallidos = intentos_fallidos + 1.
        IF intentos_fallidos >= 3.
          esta_bloqueada = abap_true.
        ENDIF.
      ENDIF.
    ELSE.
      rv_exito = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    codigo = i_codigo.
    intentos_fallidos = 0.
    esta_bloqueada = abap_false.
  ENDMETHOD.

  METHOD get_bloqueada.
    rv_bloqueada = esta_bloqueada.
  ENDMETHOD.

ENDCLASS.
