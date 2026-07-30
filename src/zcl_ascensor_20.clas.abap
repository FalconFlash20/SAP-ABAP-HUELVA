CLASS zcl_ascensor_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_planta_max TYPE i
                            i_peso_max   TYPE i,
      entrar_peso IMPORTING i_peso TYPE i,
      vaciar,
      subir_planta IMPORTING i_planta        TYPE i
                   RETURNING VALUE(rv_exito) TYPE abap_bool,
      consultar_estado EXPORTING o_planta_act TYPE i
                                 o_peso_act   TYPE i
                                 o_bloqueado  TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: planta_act TYPE i,
          planta_max TYPE i,
          peso_max   TYPE i,
          peso_act   TYPE i,
          bloqueado  TYPE abap_bool.
ENDCLASS.



CLASS zcl_ascensor_20 IMPLEMENTATION.
  METHOD constructor.
    planta_max = i_planta_max.
    peso_max   = i_peso_max.
    planta_act = 0.
    peso_act   = 0.
    bloqueado  = abap_false.
  ENDMETHOD.

  METHOD consultar_estado.
    o_planta_act = planta_act.
    o_peso_act   = peso_act.
    o_bloqueado  = bloqueado.
  ENDMETHOD.

  METHOD entrar_peso.
    IF peso_act + i_peso > peso_max.
      bloqueado = abap_true.
    ELSE.
      peso_act = peso_act + i_peso.
    ENDIF.
  ENDMETHOD.

  METHOD subir_planta.
    IF bloqueado = abap_false.
      IF i_planta > 0 AND i_planta <= planta_max.
        planta_act = i_planta.
        rv_exito = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD vaciar.
    peso_act = 0.
    bloqueado = abap_false.
  ENDMETHOD.

ENDCLASS.
