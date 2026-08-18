CLASS zcl_dron_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    methods:
        constructor importing i_carga_max type i,
        recoger_paquete importing i_paquete type i
                        RETURNING VALUE(rv_exito) TYPE abap_bool,
        volar_a_cliente RETURNING VALUE(rv_exito) TYPE abap_bool,
        recargar,
        consultar_estado exporting o_bateria TYPE i
                                   o_carga_act type i
                                   o_reserva type abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
  data:
      bateria TYPE i,
      carga_max TYPE i,
      carga_act TYPE i,
      reserva TYPE abap_bool.
ENDCLASS.



CLASS ZCL_DRON_20 IMPLEMENTATION.


  METHOD constructor.
    bateria = 100.
    carga_max = i_carga_max.
    carga_act = 0.
    reserva = abap_false.
  ENDMETHOD.


  METHOD consultar_estado.
    o_bateria = bateria.
    o_carga_act = carga_act.
    o_reserva = reserva.
  ENDMETHOD.


  METHOD recargar.
    bateria = 100.
    reserva = abap_false.
  ENDMETHOD.


  METHOD recoger_paquete.
    if i_paquete + carga_act < carga_max and bateria > 20.
        carga_act += i_paquete.
        rv_exito = abap_true.
    else.
        rv_exito = abap_false.
    endif.
  ENDMETHOD.


  METHOD volar_a_cliente.
    if bateria > 15 or reserva.
        if carga_act = 0.
            bateria -= 5.
            reserva = abap_true.
        else.
            bateria -= 15.
            carga_act = 0.
            rv_exito = abap_true.
            if bateria <= 10.
                reserva = abap_true.
        endif.
    endif.
    endif.
  ENDMETHOD.
ENDCLASS.
