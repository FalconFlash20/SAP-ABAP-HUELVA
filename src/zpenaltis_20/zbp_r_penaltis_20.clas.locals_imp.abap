CLASS lhc_Penalti DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Penalti.

    METHODS calcularResultado FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Penalti~calcularResultado.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Penalti RESULT result.

ENDCLASS.

CLASS lhc_Penalti IMPLEMENTATION.

METHOD earlynumbering_create.

    DATA entity TYPE STRUCTURE FOR CREATE zr_penaltis_20.

    " 1. Mover los registros que ya tienen número asignado (escenario Draft existente)
    LOOP AT entities INTO entity WHERE NumLanzamiento IS NOT INITIAL.
      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-penalti.
    ENDLOOP.

    DATA(entities_sin_id) = entities.
    DELETE entities_sin_id WHERE NumLanzamiento IS NOT INITIAL.

    IF entities_sin_id IS INITIAL.
      RETURN.
    ENDIF.

    " 2. Consultar el máximo actual considerando los registros activos Y los borradores (CDS View)
    SELECT MAX( NumLanzamiento ) FROM zr_penaltis_20 INTO @DATA(lv_max_num).

    DATA(lv_next_num) = CONV i( lv_max_num ) + 1.

    " 3. Asignación de claves únicas para cada nueva entidad
    LOOP AT entities_sin_id INTO entity.

      DATA(lv_num_formatted) = CONV char3( |{ lv_next_num WIDTH = 3 ALIGN = RIGHT PAD = '0' }| ).

      APPEND VALUE #(
        %cid                = entity-%cid
        %is_draft           = entity-%is_draft
        %key-NumLanzamiento = lv_num_formatted
      ) TO mapped-penalti.

      lv_next_num += 1.

    ENDLOOP.

  ENDMETHOD.

  METHOD calcularResultado.
    " 1. Leer las direcciones mediante EML desde ZR_PENALTIS_20
    READ ENTITIES OF zr_penaltis_20 IN LOCAL MODE
      ENTITY Penalti
        FIELDS ( DirDisparo DirPortero )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_penaltis).

    IF lt_penaltis IS INITIAL.
      RETURN.
    ENDIF.

    DATA: lt_update TYPE TABLE FOR UPDATE zr_penaltis_20.

    " 2. Lógica de negocio: Comparar elecciones del disparador y del portero
    LOOP AT lt_penaltis ASSIGNING FIELD-SYMBOL(<ls_penalti>).
      DATA(lv_resultado) = COND string(
        WHEN <ls_penalti>-DirDisparo IS INITIAL OR <ls_penalti>-DirPortero IS INITIAL
          THEN ''
        WHEN <ls_penalti>-DirDisparo = <ls_penalti>-DirPortero
          THEN 'PARADA'
        ELSE 'GOL'
      ).

      APPEND VALUE #(
        %tky      = <ls_penalti>-%tky
        Resultado = lv_resultado
      ) TO lt_update.
    ENDLOOP.

    " 3. Actualizar el campo Resultado mediante EML
    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_penaltis_20 IN LOCAL MODE
        ENTITY Penalti
          UPDATE FIELDS ( Resultado )
          WITH lt_update.
    ENDIF.
  ENDMETHOD.


  METHOD get_global_authorizations.
    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
