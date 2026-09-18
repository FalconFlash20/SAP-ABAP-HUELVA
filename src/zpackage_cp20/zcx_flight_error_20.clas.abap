CLASS zcx_flight_error_20 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA mv_error_text TYPE string.

    METHODS constructor
      IMPORTING
        textid        LIKE textid OPTIONAL
        previous      LIKE previous OPTIONAL
        mv_error_text TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcx_flight_error_20 IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
  CALL METHOD SUPER->constructor.
    CLEAR me->textid.
    IF textid IS INITIAL.
      me->textid = cx_static_check=>cx_root.
    ELSE.
      me->textid = textid.
    ENDIF.
    me->mv_error_text = mv_error_text.
  ENDMETHOD.

ENDCLASS.
