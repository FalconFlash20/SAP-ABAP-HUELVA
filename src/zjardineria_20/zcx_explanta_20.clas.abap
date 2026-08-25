CLASS zcx_explanta_20 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_t100_message.

    " --- Constantes de estructura T100 para enlazar con ZMSG_JARDINERIA_20 ---
    CONSTANTS:
      BEGIN OF stock_insuficiente,
        msgid TYPE symsgid VALUE 'ZMSG_JARDINERIA_20', " Reemplaza por el nombre exacto de tu Message Class
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'MV_STOCK',
        attr2 TYPE scx_attrname VALUE 'MV_SOLICITADO',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF stock_insuficiente.

    CONSTANTS:
      BEGIN OF riego_insuficiente,
        msgid TYPE symsgid VALUE 'ZMSG_JARDINERIA_20', " Reemplaza por el nombre exacto de tu Message Class
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'MV_RIEGO',
        attr2 TYPE scx_attrname VALUE 'MV_RIEGO_MINIMO',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF riego_insuficiente.

    " --- Atributos para pasar parámetros dinámicos a los mensajes ---
    DATA mv_stock        TYPE i.
    DATA mv_solicitado   TYPE i.
    DATA mv_riego        TYPE i.
    DATA mv_riego_minimo TYPE i.

    " --- Constructor ---
    METHODS constructor
      IMPORTING
        textid           LIKE if_t100_message=>t100key OPTIONAL
        previous         LIKE previous OPTIONAL
        mv_stock         TYPE i OPTIONAL
        mv_solicitado    TYPE i OPTIONAL
        mv_riego         TYPE i OPTIONAL
        mv_riego_minimo  TYPE i OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcx_explanta_20 IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    me->mv_stock        = mv_stock.
    me->mv_solicitado   = mv_solicitado.
    me->mv_riego        = mv_riego.
    me->mv_riego_minimo = mv_riego_minimo.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

