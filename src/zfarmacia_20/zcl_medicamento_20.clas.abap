CLASS zcl_medicamento_20 DEFINITION
  PUBLIC
  CREATE PUBLIC .
  PUBLIC SECTION.
    DATA id               TYPE i.
    DATA nombre           TYPE string.
    DATA laboratorio      TYPE string.
    DATA precio           TYPE zdecimals2.
    DATA stock            TYPE i.
    DATA requiere_receta  TYPE abap_bool.
    DATA principio_activo TYPE string.

    METHODS constructor
      IMPORTING
        iv_id               TYPE i
        iv_nombre           TYPE string
        iv_laboratorio      TYPE string
        iv_precio           TYPE zdecimals2
        iv_stock            TYPE i
        iv_requiere_receta  TYPE abap_bool
        iv_principio_activo TYPE string.

    METHODS calcular_precio_final
      RETURNING
        VALUE(rv_precio_final) TYPE zdecimals2.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_medicamento_20 IMPLEMENTATION.
  METHOD calcular_precio_final.
    rv_precio_final = precio.
  ENDMETHOD.

  METHOD constructor.
    id               = iv_id.
    nombre           = iv_nombre.
    laboratorio      = iv_laboratorio.
    precio           = iv_precio.
    stock            = iv_stock.
    requiere_receta  = iv_requiere_receta.
    principio_activo = iv_principio_activo.
  ENDMETHOD.

ENDCLASS.
