CLASS zcl_nr_pen_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_nr_pen_20 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_interval TYPE STANDARD TABLE OF cl_numberrange_intervals=>nr_nriv_line,
          ls_interval LIKE LINE OF lt_interval.

    ls_interval-nrrangenr  = '01'.
    ls_interval-fromnumber = '001'.
    ls_interval-tonumber   = '999'.
    ls_interval-procind    = 'I'.
    APPEND ls_interval TO lt_interval.

    TRY.
        cl_numberrange_intervals=>create(
          EXPORTING
            interval  = lt_interval
            object    = 'ZNR_PEN_20'
        ).
        out->write( 'Intervalo 01 del Number Range ZNR_PEN_20 creado correctamente.' ).
      CATCH cx_nr_object_not_found INTO DATA(lx_not_found).
        out->write( |Error: Objeto no encontrado - { lx_not_found->get_text( ) }| ).
      CATCH cx_number_ranges INTO DATA(lx_ranges).
        out->write( |Error en Number Range: { lx_ranges->get_text( ) }| ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
