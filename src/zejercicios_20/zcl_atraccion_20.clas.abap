CLASS zcl_atraccion_20 DEFINITION
  PUBLIC
  CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_nombre TYPE string,
      recibir_visitante,
      calcular_precio_entrada RETURNING VALUE(rv_importe) TYPE zdecimals2,
      consultar_visitantes RETURNING VALUE(rv_visi) TYPE i.
  PROTECTED SECTION.
    DATA: nombre     TYPE string,
          visitantes TYPE i.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ATRACCION_20 IMPLEMENTATION.


  METHOD calcular_precio_entrada.
    rv_importe = 0.
  ENDMETHOD.


  METHOD constructor.
    me->nombre = i_nombre.
    visitantes = 0.
  ENDMETHOD.


  METHOD consultar_visitantes.
    rv_visi = visitantes.
  ENDMETHOD.


  METHOD recibir_visitante.
    visitantes = visitantes + 1.
  ENDMETHOD.
ENDCLASS.
