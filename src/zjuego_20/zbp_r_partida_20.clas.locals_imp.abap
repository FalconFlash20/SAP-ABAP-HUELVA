CLASS lhc_zr_partida_20 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrPartida20
        RESULT result,

      " 1. Nombre estándar obligatorio para early numbering
      earlynumbering_create FOR NUMBERING
        IMPORTING entities FOR CREATE ZrPartida20,

      Calcular_Ganador FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrPartida20~Calcular_Ganador.

ENDCLASS.

CLASS lhc_zr_partida_20 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA entity TYPE STRUCTURE FOR CREATE zr_partida_20.

    " 1. Si ya tiene ID (borradores existentes), lo conservamos
    LOOP AT entities INTO entity WHERE NumPartida IS NOT INITIAL.
      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-zrpartida20.
    ENDLOOP.

    DATA(entities_sin_id) = entities.
    DELETE entities_sin_id WHERE NumPartida IS NOT INITIAL.

    IF entities_sin_id IS INITIAL.
      RETURN.
    ENDIF.

    " 2. Obtener números del Number Range
    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr       = '01'
            object            = 'Zpartida20'
            quantity          = CONV #( lines( entities_sin_id ) )
          IMPORTING
            number            = DATA(numero_final)
            returncode        = DATA(codigo_retorno)
            returned_quantity = DATA(cantidad_devuelta)
        ).

      CATCH cx_number_ranges INTO DATA(error_number_range).
        LOOP AT entities_sin_id INTO entity.
          APPEND VALUE #(
            %cid      = entity-%cid
            %key      = entity-%key
            %is_draft = entity-%is_draft
            %msg      = error_number_range
          ) TO reported-zrpartida20.

          APPEND VALUE #(
            %cid        = entity-%cid
            %key        = entity-%key
            %is_draft   = entity-%is_draft
            %fail-cause = if_abap_behv=>cause-conflict
          ) TO failed-zrpartida20.
        ENDLOOP.
        RETURN.
    ENDTRY.

    IF cantidad_devuelta <> lines( entities_sin_id ).
      LOOP AT entities_sin_id INTO entity.
        APPEND VALUE #(
          %cid        = entity-%cid
          %key        = entity-%key
          %is_draft   = entity-%is_draft
          %fail-cause = if_abap_behv=>cause-conflict
        ) TO failed-zrpartida20.
      ENDLOOP.
      RETURN.
    ENDIF.

    DATA(numero_actual) = CONV i( numero_final ) - CONV i( cantidad_devuelta ).

    " 3. Asignación correcta de la clave en mapped
    LOOP AT entities_sin_id INTO entity.
      numero_actual += 1.
      DATA(lv_num_formatted) = CONV char3( |{ numero_actual WIDTH = 3 ALIGN = RIGHT PAD = '0' }| ).

      APPEND VALUE #(
        %cid                = entity-%cid
        %is_draft           = entity-%is_draft
        %key-NumPartida     = lv_num_formatted  " <--- ASIGNACIÓN CORRECTA DE LA CLAVE
      ) TO mapped-zrpartida20.
    ENDLOOP.

  endMETHOD.

  METHOD Calcular_Ganador.

    READ ENTITIES OF zr_partida_20 IN LOCAL MODE
      ENTITY ZrPartida20
        FIELDS ( Jugada1 Jugada2 Nombre1 Nombre2 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(partidas).

    MODIFY ENTITIES OF zr_partida_20 IN LOCAL MODE
      ENTITY ZrPartida20
        UPDATE FIELDS ( Ganador )
        WITH VALUE #(
          FOR partida IN partidas
          (
            %tky = partida-%tky

            Ganador =
              COND #(
                WHEN partida-Jugada1 = partida-Jugada2 THEN 'Empate'
                WHEN ( partida-Jugada1 = '1' AND partida-Jugada2 = '2' )
                  OR ( partida-Jugada1 = '2' AND partida-Jugada2 = '3' )
                  OR ( partida-Jugada1 = '3' AND partida-Jugada2 = '1' ) THEN partida-Nombre2
                ELSE partida-Nombre1
              )
          )
        ).

  ENDMETHOD.

ENDCLASS.

