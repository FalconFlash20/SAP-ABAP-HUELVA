CLASS zcl_mascota_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor,
      comer,
      jugar,
      consultar_estado EXPORTING o_lleno   TYPE i
                                 o_energia TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: lleno   TYPE i,
          energia TYPE i.
ENDCLASS.



CLASS zcl_mascota_20 IMPLEMENTATION.
  METHOD comer.
    IF lleno + 20 < 100.
      lleno += 20.
    ELSE.
      lleno = 100.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    lleno   = 100.
    energia = 100.
  ENDMETHOD.

  METHOD consultar_estado.
    o_lleno   = lleno.
    o_energia = energia.
  ENDMETHOD.

  METHOD jugar.
    IF energia >= 20.
      IF energia - 15 < 0.
        energia = 0.
      ELSE.
        energia -= 15.
      ENDIF.
      IF lleno - 10 < 0.
        lleno = 0.
      ELSE.
        lleno -= 10.
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
