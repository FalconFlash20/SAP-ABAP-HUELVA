CLASS zcl_habitacion_estandar_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_habitacion_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES zif_describible_20.
    METHODS:
      constructor IMPORTING i_numero_habitacion TYPE string
                            i_precio_noche      TYPE zdecimals2
                            i_tiene_vistas_mar  TYPE abap_bool,
      calcular_precio_total REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA  tiene_vistas_mar TYPE abap_bool.
ENDCLASS.



CLASS zcl_habitacion_estandar_20 IMPLEMENTATION.
  METHOD calcular_precio_total.
    rv_importe = super->calcular_precio_total( i_numero_noches = i_numero_noches ).
    IF tiene_vistas_mar = abap_true.
      rv_importe = rv_importe + 15.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.

    super->constructor( i_numero_habitacion = i_numero_habitacion i_precio_noche = i_precio_noche ).
    tiene_vistas_mar = i_tiene_vistas_mar.
  ENDMETHOD.

  METHOD zif_describible_20~describir.
    IF me->tiene_vistas_mar = abap_true.
      rv_descripcion = |Habitacion Estandar { me->numero_habitacion } con vistas al mar.|.
    ELSE.
      rv_descripcion = |Habitacion Estandar { me->numero_habitacion } sin vistas al mar.|.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
