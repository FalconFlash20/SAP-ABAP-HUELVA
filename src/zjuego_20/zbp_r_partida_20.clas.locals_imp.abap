CLASS lhc_Partida DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Partida.
METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
  IMPORTING REQUEST requested_authorizations FOR Partida RESULT result.
*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR Partida RESULT result.

    METHODS jugar FOR MODIFY
      IMPORTING keys FOR ACTION Partida~jugar RESULT result.

    METHODS validarJugadas FOR VALIDATE ON SAVE
      IMPORTING keys FOR Partida~validarJugadas.

ENDCLASS.

CLASS lhc_Partida IMPLEMENTATION.

  METHOD earlynumbering_create.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entity>).
      DATA(lv_game_id) = <ls_entity>-GameId.

      IF lv_game_id IS INITIAL.
        TRY.
            lv_game_id = cl_system_uuid=>create_uuid_c32_static( ).
          CATCH cx_uuid_error.
        ENDTRY.
      ENDIF.

      INSERT VALUE #(
        %cid    = <ls_entity>-%cid
        GameId  = lv_game_id
      ) INTO TABLE mapped-partida.
    ENDLOOP.
  ENDMETHOD.
METHOD get_global_authorizations.
  " Concede permiso total para operaciones globales (create, etc.)
  IF requested_authorizations-%create = if_abap_behv=>mk-on.
    result-%create = if_abap_behv=>auth-allowed.
  ENDIF.
ENDMETHOD.
*  METHOD get_instance_features.
*READ ENTITIES OF zr_partida_20 IN LOCAL MODE
*      ENTITY Partida
*        FIELDS ( Resultado Jugador1 Jugador2 )
*        WITH CORRESPONDING #( keys )
*      RESULT DATA(lt_partidas).
*
*    result = VALUE #(
*      FOR ls_p IN lt_partidas
*        ( %tky = ls_p-%tky
*          %action-jugar = COND #( WHEN ls_p-Resultado IS INITIAL
*                                       AND ls_p-Jugador1 IS NOT INITIAL
*                                       AND ls_p-Jugador2 IS NOT INITIAL
*                                  THEN if_abap_behv=>fc-o-enabled
*                                  ELSE if_abap_behv=>fc-o-disabled ) ) ).
*  ENDMETHOD.

  METHOD jugar.
    READ ENTITIES OF zr_partida_20 IN LOCAL MODE
      ENTITY Partida
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_partidas).

    LOOP AT lt_partidas ASSIGNING FIELD-SYMBOL(<ls_partida>).

      IF <ls_partida>-Jugador1 IS INITIAL OR <ls_partida>-Jugador2 IS INITIAL.
        CONTINUE.
      ENDIF.

      " Reglas del juego (1 = Piedra, 2 = Papel, 3 = Tijera)
      DATA(lv_res) = COND string(
        WHEN <ls_partida>-Jugador1 = <ls_partida>-Jugador2
          THEN 'Empate. Ambos jugadores han elegido la misma jugada.'
        WHEN ( <ls_partida>-Jugador1 = '1' AND <ls_partida>-Jugador2 = '3' ) OR
             ( <ls_partida>-Jugador1 = '2' AND <ls_partida>-Jugador2 = '1' ) OR
             ( <ls_partida>-Jugador1 = '3' AND <ls_partida>-Jugador2 = '2' )
          THEN 'Gana el jugador 1.'
        ELSE 'Gana el jugador 2.'
      ).

      " Actualizar el campo Resultado
      MODIFY ENTITIES OF zr_partida_20 IN LOCAL MODE
        ENTITY Partida
          UPDATE FIELDS ( Resultado )
          WITH VALUE #( ( %tky = <ls_partida>-%tky Resultado = lv_res ) ).

      " Leer y devolver resultado a la UI
      READ ENTITIES OF zr_partida_20 IN LOCAL MODE
        ENTITY Partida
          ALL FIELDS WITH VALUE #( ( %tky = <ls_partida>-%tky ) )
        RESULT DATA(lt_updated).

      IF lt_updated IS NOT INITIAL.
        APPEND VALUE #( %tky = <ls_partida>-%tky %param = lt_updated[ 1 ] ) TO result.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validarJugadas.
    READ ENTITIES OF zr_partida_20 IN LOCAL MODE
      ENTITY Partida
        FIELDS ( Jugador1 Jugador2 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_partidas).

    LOOP AT lt_partidas INTO DATA(ls_p).
      IF ls_p-Jugador1 IS INITIAL OR ls_p-Jugador2 IS INITIAL.
        APPEND VALUE #( %tky = ls_p-%tky ) TO failed-partida.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
