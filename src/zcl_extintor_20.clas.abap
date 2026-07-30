CLASS zcl_extintor_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_carga TYPE i,
      usar,
      consultar_carga RETURNING VALUE(rv_carga) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA carga TYPE i.
ENDCLASS.



CLASS zcl_extintor_20 IMPLEMENTATION.
  METHOD constructor.
    carga = i_carga.
  ENDMETHOD.
  METHOD usar.
    IF carga > 35.
      carga -= 35.
    ENDIF.
  ENDMETHOD.
  METHOD consultar_carga.
    rv_carga = carga.
  ENDMETHOD.
ENDCLASS.
