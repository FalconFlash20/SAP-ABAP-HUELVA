CLASS zcl_concierto_20 DEFINITION
  PUBLIC
  INHERITING FROM zcl_atraccion_20
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_nombre_c TYPE string,
      calcular_precio_entrada REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_concierto_20 IMPLEMENTATION.
  METHOD calcular_precio_entrada.
    IF consultar_visitantes( ) <= 500.
      rv_importe = '10.00'.
    ELSE.
      rv_importe = '5.00'.
    ENDIF.
  ENDMETHOD.
  METHOD constructor.
    super->constructor( i_nombre = i_nombre_c ).
  ENDMETHOD.
ENDCLASS.
