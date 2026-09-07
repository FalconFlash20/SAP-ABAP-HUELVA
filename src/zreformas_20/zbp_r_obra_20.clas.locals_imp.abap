CLASS lhc_zr_obra_20 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations
      FOR GLOBAL AUTHORIZATION
      IMPORTING
      REQUEST requested_authorizations FOR Zr_Obra_20
      RESULT result.

ENDCLASS.

CLASS lhc_zr_obra_20 IMPLEMENTATION.

  METHOD get_global_authorizations.
    " Permitimos la creación si se solicita
    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
