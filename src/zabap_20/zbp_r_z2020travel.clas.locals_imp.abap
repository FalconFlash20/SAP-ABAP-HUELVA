CLASS lhc_zrz2020travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS setInitialStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZrZ2020travel~setInitialStatus.

ENDCLASS.

CLASS lhc_zrz2020travel IMPLEMENTATION.

  METHOD setInitialStatus.

    " 1. Leer las instancias que se están creando usando el alias ZrZ2020travel
    READ ENTITIES OF ZR_Z2020TRAVEL IN LOCAL MODE
      ENTITY ZrZ2020travel
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travels).

    " 2. Construir la tabla de actualización usando el tipo fuertemente tipado
    DATA lt_travels_to_update TYPE TABLE FOR UPDATE ZR_Z2020TRAVEL.

    lt_travels_to_update = VALUE #(
      FOR ls_travel IN lt_travels WHERE ( Status IS INITIAL )
      ( %tky   = ls_travel-%tky
        Status = 'N' )
    ).

    " 3. Asignar el estado 'N' si hay registros pendientes
    IF lt_travels_to_update IS NOT INITIAL.
      MODIFY ENTITIES OF ZR_Z2020TRAVEL IN LOCAL MODE
        ENTITY ZrZ2020travel
          UPDATE FIELDS ( Status )
          WITH lt_travels_to_update.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

