CLASS zcl_compra_entradas_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_compra_entradas_20 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lv_precio_entrada) = 35.
    DATA(lv_num_entradas)   = 4.

    FINAL(lv_total) = lv_precio_entrada * lv_num_entradas.

    out->write( |Precio de una entrada: { lv_precio_entrada } €| ).
    out->write( |Número de entradas:   { lv_num_entradas }| ).
    out->write( |Importe total:        { lv_total } €| ).

    " lv_total = 200.

    TYPES: BEGIN OF ty_videojuego,
             titulo     TYPE string,
             plataforma TYPE string,
             precio     TYPE i,
           END OF ty_videojuego,
           tt_videojuegos TYPE STANDARD TABLE OF ty_videojuego WITH DEFAULT KEY.

    DATA(lt_videojuegos) = VALUE tt_videojuegos(
      ( titulo = 'Minecraft' plataforma = 'PC'     precio = 30 )
      ( titulo = 'Zelda'     plataforma = 'Switch' precio = 60 )
      ( titulo = 'FIFA'      plataforma = 'PS5'    precio = 70 )
    ).

    out->write( lt_videojuegos ).

    TYPES: BEGIN OF ty_posicion,
             producto        TYPE string,
             cantidad        TYPE i,
             precio_unitario TYPE p LENGTH 8 DECIMALS 2,
           END OF ty_posicion,
           tt_posiciones TYPE STANDARD TABLE OF ty_posicion WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_pedido,
             id_pedido  TYPE i,
             cliente    TYPE string,
             ciudad     TYPE string,
             urgente    TYPE abap_bool,
             posiciones TYPE tt_posiciones,
           END OF ty_pedido,
           tt_pedidos TYPE STANDARD TABLE OF ty_pedido WITH DEFAULT KEY.

    DATA(lt_pedidos) = VALUE tt_pedidos(
      ( id_pedido = 1001
        cliente   = 'Empresa Norte'
        ciudad    = 'Sevilla'
        urgente   = abap_true
        posiciones = VALUE #(
          ( producto = 'Portátil' cantidad = 2  precio_unitario = '850.00' )
          ( producto = 'Ratón'    cantidad = 5  precio_unitario = '25.00' )
          ( producto = 'Monitor'  cantidad = 2  precio_unitario = '220.00' )
        )
      )
      ( id_pedido = 1002
        cliente   = 'Tecnología Sur'
        ciudad    = 'Cádiz'
        urgente   = abap_false
        posiciones = VALUE #(
          ( producto = 'Teclado' cantidad = 10 precio_unitario = '45.00' )
          ( producto = 'Webcam'  cantidad = 4  precio_unitario = '75.00' )
        )
      )
      ( id_pedido = 1003
        cliente   = 'Formación Digital'
        ciudad    = 'Huelva'
        urgente   = abap_true
        posiciones = VALUE #(
          ( producto = 'Tablet'         cantidad = 6  precio_unitario = '320.00' )
          ( producto = 'Auriculares'    cantidad = 8  precio_unitario = '60.00' )
          ( producto = 'Adaptador USB-C' cantidad = 15 precio_unitario = '20.00' )
        )
      )
    ).

    out->write( '--- TABLA DE PEDIDOS ANIDADOS ---' ).
    out->write( lt_pedidos ).

    DATA(ls_pedido_prueba) = VALUE ty_pedido(
      id_pedido  = 2000
      cliente    = 'Cliente Prueba'
      ciudad     = 'Sevilla'
      urgente    = abap_false
      posiciones = VALUE #(
        ( producto = 'Impresora' cantidad = 1 precio_unitario = '180.00' )
        ( producto = 'Toner'     cantidad = 3 precio_unitario = '45.00' )
      )
    ).

    out->write( '--- ESTRUCTURA DE PRUEBA UNIFILAR ---' ).
    out->write( ls_pedido_prueba ).


    DATA(lv_importe)     = 750.
    DATA(lv_cliente_vip) = abap_true.

    DATA(lv_porcentaje_desc) = COND i(
      WHEN lv_cliente_vip = abap_true AND lv_importe >= 1000 THEN 30
      WHEN lv_importe >= 1000                                THEN 20
      WHEN lv_importe >= 500                                 THEN 10
      WHEN lv_importe >= 200                                 THEN 5
      ELSE 0
    ).

    DATA(lv_cantidad_descontada) = lv_importe * lv_porcentaje_desc / 100.
    DATA(lv_importe_final)       = lv_importe - lv_cantidad_descontada.

    out->write( |--- RESUMEN DE COMPRA ---| ).
    out->write( |Importe original:       { lv_importe } €| ).
    out->write( |Cliente VIP:            { lv_cliente_vip }| ).
    out->write( |Porcentaje descuento:   { lv_porcentaje_desc } %| ).
    out->write( |Cantidad descontada:    { lv_cantidad_descontada } €| ).
    out->write( |Importe final a pagar:  { lv_importe_final } €| ).


    DATA(lv_estado) = 'E'.

    DATA(lv_descripcion) = SWITCH string( lv_estado
      WHEN 'P' THEN 'Pendiente'
      WHEN 'E' THEN 'Enviado'
      WHEN 'R' THEN 'Recibido'
      WHEN 'C' THEN 'Cancelado'
      ELSE 'Estado desconocido'
    ).

    out->write( |Código del estado: { lv_estado }| ).
    out->write( |Descripción:       { lv_descripcion }| ).

    DATA(lv_prioridad) = SWITCH i( lv_estado
      WHEN 'P' THEN 1
      WHEN 'E' THEN 2
      WHEN 'R' THEN 3
      WHEN 'C' THEN 4
      ELSE 0
    ).

    out->write( |Prioridad:         { lv_prioridad }| ).
  ENDMETHOD.

ENDCLASS.
