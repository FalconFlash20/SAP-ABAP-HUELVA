CLASS zcl_atraccion_feria_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_atraccion_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_nombre_atf TYPE string
      i_precio TYPE zdecimals2,
      calcular_precio_entrada REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA precio_fijo TYPE p DECIMALS 2.
ENDCLASS.



CLASS zcl_atraccion_feria_20 IMPLEMENTATION.
  METHOD calcular_precio_entrada.
    rv_importe = super->calcular_precio_entrada( ) + precio_fijo.
  ENDMETHOD.
  METHOD constructor.
    super->constructor( i_nombre = i_nombre_atf ).
    precio_fijo = i_precio.
  ENDMETHOD.

ENDCLASS.
