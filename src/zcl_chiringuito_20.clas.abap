CLASS zcl_chiringuito_20 DEFINITION
  PUBLIC
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_nombre      TYPE string
                            i_recaudacion TYPE zdecimals2,
      vender IMPORTING i_importe       TYPE zdecimals2
             RETURNING VALUE(rv_exito) TYPE abap_bool,
      calcular_comision_ayuntamiento RETURNING VALUE(rv_importe) TYPE zdecimals2,
      consulta_recaudacion RETURNING VALUE(rv_recaudacion) TYPE zdecimals2.
  PROTECTED SECTION.
    DATA: nombre      TYPE string,
          recaudacion TYPE zdecimals2.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_chiringuito_20 IMPLEMENTATION.
  METHOD calcular_comision_ayuntamiento.
    rv_importe = recaudacion * '0.1'.
  ENDMETHOD.

  METHOD consulta_recaudacion.
    rv_recaudacion = recaudacion.
  ENDMETHOD.

  METHOD vender.
    recaudacion = recaudacion + i_importe.
    rv_exito = abap_true.
  ENDMETHOD.

  METHOD constructor.
    nombre = i_nombre.
    recaudacion = i_recaudacion.
  ENDMETHOD.

ENDCLASS.
