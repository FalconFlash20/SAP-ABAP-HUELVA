CLASS zcl_med_marca_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_medicamento_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    DATA nombre_comercial TYPE string.
    DATA recargo_marca    TYPE i.

    METHODS constructor
      IMPORTING
        iv_id               TYPE i
        iv_nombre           TYPE string
        iv_laboratorio      TYPE string
        iv_precio           TYPE zdecimals2
        iv_stock            TYPE i
        iv_requiere_receta  TYPE abap_bool
        iv_principio_activo TYPE string
        iv_nombre_comercial TYPE string
        iv_recargo_marca    TYPE i.

    METHODS calcular_precio_final REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_med_marca_20 IMPLEMENTATION.
  METHOD calcular_precio_final.
    rv_precio_final =
      precio + ( precio * recargo_marca / 100 ).
  ENDMETHOD.

  METHOD constructor.

    super->constructor( iv_id = iv_id iv_nombre = iv_nombre iv_laboratorio = iv_laboratorio iv_precio = iv_precio iv_stock = iv_stock iv_requiere_receta = iv_requiere_receta iv_principio_activo = iv_principio_activo ).
    me->nombre_comercial = iv_nombre_comercial.
    me->recargo_marca = iv_recargo_marca.
  ENDMETHOD.

ENDCLASS.
