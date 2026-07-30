CLASS zcl_ejercicios_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejercicios_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*      DATA lt_clientes TYPE TABLE OF zcliente_20.
*
*    lt_clientes = VALUE #(
*      ( client = sy-mandt cliente_id = '0001' nombre = 'Ana Garcia'      ciudad = 'Sevilla' )
*      ( client = sy-mandt cliente_id = '0002' nombre = 'Luis Perez'      ciudad = 'Huelva' )
*      ( client = sy-mandt cliente_id = '0003' nombre = 'Marta Ruiz'      ciudad = 'Cadiz' )
*      ( client = sy-mandt cliente_id = '0004' nombre = 'Pedro Sanchez'   ciudad = 'Sevilla' )
*      ( client = sy-mandt cliente_id = '0005' nombre = 'Lucia Fernandez' ciudad = 'Granada' )
*      ( client = sy-mandt cliente_id = '0006' nombre = 'Javier Torres'   ciudad = 'Huelva' )
*      ( client = sy-mandt cliente_id = '0007' nombre = 'Sara Jimenez'    ciudad = 'Malaga' )
*      ( client = sy-mandt cliente_id = '0008' nombre = 'Diego Morales'   ciudad = 'Sevilla' )
*    ).
*
*    INSERT zcliente_20 FROM TABLE @lt_clientes.
*
*    " ---------- PEDIDOS ----------
*    DATA lt_pedidos TYPE TABLE OF zpedido_20.
*
*    lt_pedidos = VALUE #(
*      ( client = sy-mandt pedido_id = '0001' cliente_id = '0001' producto = 'Portatil'     importe = '899.00'  fecha = '20260115' )
*      ( client = sy-mandt pedido_id = '0002' cliente_id = '0001' producto = 'Raton'         importe = '25.50'   fecha = '20260118' )
*      ( client = sy-mandt pedido_id = '0003' cliente_id = '0002' producto = 'Monitor'       importe = '210.00'  fecha = '20260120' )
*      ( client = sy-mandt pedido_id = '0004' cliente_id = '0002' producto = 'Teclado'       importe = '45.00'   fecha = '20260122' )
*      ( client = sy-mandt pedido_id = '0005' cliente_id = '0003' producto = 'Auriculares'   importe = '60.00'   fecha = '20260125' )
*      ( client = sy-mandt pedido_id = '0006' cliente_id = '0004' producto = 'Tablet'        importe = '320.00'  fecha = '20260128' )
*      ( client = sy-mandt pedido_id = '0007' cliente_id = '0004' producto = 'Funda tablet'  importe = '18.00'   fecha = '20260130' )
*      ( client = sy-mandt pedido_id = '0008' cliente_id = '0005' producto = 'Impresora'     importe = '150.00'  fecha = '20260201' )
*      ( client = sy-mandt pedido_id = '0009' cliente_id = '0006' producto = 'Silla oficina' importe = '210.00'  fecha = '20260203' )
*      ( client = sy-mandt pedido_id = '0010' cliente_id = '0007' producto = 'Portatil'      importe = '750.00'  fecha = '20260205' )
*      ( client = sy-mandt pedido_id = '0011' cliente_id = '0007' producto = 'Mochila'       importe = '35.00'   fecha = '20260207' )
*      ( client = sy-mandt pedido_id = '0012' cliente_id = '0008' producto = 'Monitor'       importe = '195.00'  fecha = '20260210' )
*      ( client = sy-mandt pedido_id = '0013' cliente_id = '0001' producto = 'Webcam'        importe = '40.00'   fecha = '20260212' )
*      ( client = sy-mandt pedido_id = '0014' cliente_id = '0003' producto = 'Portatil'      importe = '910.00'  fecha = '20260215' )
*      ( client = sy-mandt pedido_id = '0015' cliente_id = '0005' producto = 'Raton'         importe = '22.00'   fecha = '20260218' )
*    ).
*
*    INSERT zpedido_20 FROM TABLE @lt_pedidos.
*
*    out->write( |Insertados { lines( lt_clientes ) } clientes y { lines( lt_pedidos ) } pedidos.| ).
*    "-----Ejercicio 1-----
*    SELECT SINGLE *
*    FROM zcliente_20
*    WHERE cliente_id = '0005'
*    INTO  @DATA(lt_salida1).
*    IF sy-subrc = 0.
*      out->write( lt_salida1 ).
*    ELSE.
*      out->write( 'No existen clientes' ).
*    ENDIF.
*    UPDATE zcliente_20
*      SET ciudad = 'Sevilla'
*    WHERE cliente_id = '0005'.
*    IF sy-subrc = 0.
*      out->write( 'Ciudad actualizada' ).
*    ELSE.
*      out->write( 'No se ha actualizado la ciudad' ).
*    ENDIF.
*    "-----Ejercicio 2-----"
*    insert zpedido_20 from @( value #(
*    pedido_id = '0016'
*    cliente_id = '0005'
*    producto = 'Procesador'
*    importe = '500.00'
*    fecha = '20260220'
*    ) ).
*    IF sy-subrc = 0.
*      out->write( 'Producto Insertado' ).
*    ELSE.
*      out->write( 'No se ha insertado' ).
*    endif.
*    select *
*    from zcliente_20 as c
*    inner join zpedido_20 as p
*    on c~cliente_id = p~cliente_id
*    into table @DATA(lt_salida2).
*    if sy-subrc = 0.
*      out->write( lt_salida2 ).
*    else.
*      out->write( 'No existen pedidos' ).
*    endif.
*    "-----Ejercicio 3-----
*    DELETE FROM zpedido_20
*    WHERE pedido_id = '0015'.
*    IF sy-subrc = 0.
*      out->write( 'Producto eliminado' ).
*    ELSE.
*      out->write( 'No se ha eliminado' ).
*    ENDIF.
*    SELECT *
*        FROM zcliente_20 AS c
*        INNER JOIN zpedido_20 AS p
*        ON c~cliente_id = p~cliente_id
*        INTO TABLE @DATA(lt_salida2).
*    IF sy-subrc = 0.
*      out->write( lt_salida2 ).
*    ELSE.
*      out->write( 'No existen pedidos' ).
*    ENDIF.
*    "-----Ejercicio 4-----
*    SELECT *
*    FROM zpedido_20
*    WHERE cliente_id = '0001'
*    INTO TABLE @DATA(ls_salida3antes).
*    IF sy-subrc = 0.
*      out->write( ls_salida3antes ).
*    ELSE.
*      out->write( 'No existen pedidos' ).
*    ENDIF.
*    SELECT SINGLE SUM( importe )
*    FROM zpedido_20
*    WHERE cliente_id = '0001'
*    INTO @DATA(lv_sumai).
*    IF sy-subrc = 0.
*      out->write( lv_sumai ).
*    ELSE.
*      out->write( 'No existen pedidos' ).
*    ENDIF.
*    SELECT *
*    FROM zpedido_20
*    WHERE cliente_id = '0001'
*    INTO TABLE @DATA(lt_pedidos).
*    LOOP AT lt_pedidos ASSIGNING  FIELD-SYMBOL(<fs_pedido>).
*      <fs_pedido>-importe = <fs_pedido>-importe * '1.10'.
*    ENDLOOP.
*    UPDATE zpedido_20 FROM TABLE @lt_pedidos.
*    IF sy-subrc = 0.
*      out->write( 'Importes actualizados correctamente' ).
*    ELSE.
*      out->write( 'No existen pedidos' ).
*    ENDIF.
*    SELECT SINGLE SUM( importe )
*FROM zpedido_20
*WHERE cliente_id = '0001'
*INTO @DATA(lv_sumad).
*    IF sy-subrc = 0.
*      out->write( lv_sumad ).
*    ELSE.
*      out->write( 'No existen pedidos' ).
*    ENDIF.
    "-----Ejercicio 5-----"
*    select *
*    from zcliente_20
*    where cliente_id = '9999'
*    into table @data(lt_salida4_antes).
*    if sy-subrc <> 0.
*        out->write( 'El cliente no existe' ).
*    else.
*        out->write( 'Error...Código existente' ).
*    endif.
*    DATA(ls_pedido_huerfano) = VALUE zpedido_20(
*      cliente_id = '9999'
*      pedido_id  = '9001'
*      producto   = 'Producto Prueba Inconsistente'
*      importe    = '150.00'
*      fecha      = '20260220'
*    ).
*
*    INSERT zpedido_20 FROM @ls_pedido_huerfano.
*    if sy-subrc <> 0.
*        out->write( 'Error al insertar' ).
*    else.
*        out->write( 'Insertado correctamente' ).
*    endif.
    "-----Ejercicio 6-----"
*    SELECT SINGLE
*           c~cliente_id,
*           c~nombre,
*           SUM( p~importe ) AS total_gastado
*      FROM zpedido_20 AS p
*      INNER JOIN zcliente_20 AS c
*        ON p~cliente_id = c~cliente_id
*      GROUP BY c~cliente_id, c~nombre
*      INTO @DATA(ls_salida6).
*
*    IF sy-subrc = 0.
*      out->write( |=== CLIENTE QUE MÁS HA GASTADO ===| ).
*      out->write( |Cliente ID : { ls_salida6-cliente_id }| ).
*      out->write( |Nombre     : { ls_salida6-nombre }| ).
*      out->write( |Total      : { ls_salida6-total_gastado } EUR| ).
*    ELSE.
*      out->write( 'No hay pedidos o clientes registrados para realizar el cálculo.' ).
*    ENDIF.
    "-----Ejercicio 7-----"
*    UPDATE zcliente_20
*    SET ciudad = 'Sevilla'
*    WHERE ciudad = 'Huelva'.
*    IF sy-subrc = 0.
*      out->write( 'Ciudades actualizadas' ).
*    ELSE.
*      out->write( 'No se han actualizado ciudades' ).
*    ENDIF.
*    SELECT *
*      FROM zcliente_20 AS c
*      INNER JOIN zpedido_20 AS p
*        ON c~cliente_id = p~cliente_id
*      WHERE c~ciudad = 'Sevilla'
*      ORDER BY c~cliente_id, p~pedido_id
*      INTO TABLE @DATA(lt_salida7).
*    IF sy-subrc = 0.
*      out->write( lt_salida7 ).
*    ELSE.
*      out->write( 'No existen pedidos' ).
*    ENDIF.
    "-----Ejercicio 8-----
*    SELECT SINGLE
*           producto,
*           COUNT( * ) AS total_pedidos
*      FROM zpedido_20
*      GROUP BY producto
*      INTO @DATA(ls_producto_estrella).
*
*    IF sy-subrc = 0 AND ls_producto_estrella-total_pedidos > 0.
*      out->write( |=== PRODUCTO MÁS PEDIDO ===| ).
*      out->write( |Producto         : { ls_producto_estrella-producto }| ).
*      out->write( |Veces solicitado : { ls_producto_estrella-total_pedidos }| ).
*    ELSE.
*      out->write( 'No hay pedidos registrados' ).
*    ENDIF.
    "----Ejercicio 9-----
*    SELECT SINGLE *
*    FROM zpedido_20
*    INTO @DATA(ls_pedido).
*    IF sy-subrc = 0.
*      out->write( ls_pedido ).
*    ELSE.
*      out->write( 'No existen pedidos' ).
*    ENDIF.
*    DELETE FROM zpedido_20 WHERE pedido_id = @ls_pedido-pedido_id.
*    IF sy-subrc = 0.
*      out->write( 'Producto eliminado' ).
*    ELSE.
*      out->write( 'No se ha eliminado correctamente' ).
*    ENDIF.
*    SELECT SINGLE *
*    FROM zcliente_20
*    WHERE cliente_id = @ls_pedido-cliente_id
*    INTO @DATA(ls_cliente).
*    IF sy-subrc = 0.
*      out->write( ls_cliente ).
*    ELSE.
*      out->write( 'No existen clientes' ).
*    ENDIF.
*    SELECT *
*      FROM zcliente_20 AS c
*      LEFT JOIN zpedido_20 AS p
*        ON c~cliente_id = p~cliente_id
*      WHERE c~cliente_id = @ls_pedido-cliente_id
*      INTO TABLE @DATA(lt_cliente).
*    IF sy-subrc = 0.
*      out->write( lt_cliente ).
*    ELSE.
*      out->write( 'No existen pedidos' ).
*    ENDIF.
    "-----Ejercicio 10-----
    SELECT SINGLE cliente_id,nombre,ciudad
    FROM zcliente_20
    INTO @DATA(ls_cliente).
    IF sy-subrc = 0.
      out->write( ls_cliente ).
    ELSE.
      out->write( 'No existen clientes' ).
    ENDIF.
    SELECT SINGLE SUM( importe ) AS total_gastado
      FROM zpedido_20
      WHERE cliente_id = @ls_cliente-cliente_id
      INTO @DATA(lv_total_gastado).
    SELECT *
    FROM zcliente_20 AS c
    LEFT JOIN zpedido_20 AS p
    ON c~cliente_id = p~cliente_id
    WHERE c~cliente_id = @ls_cliente-cliente_id
    INTO TABLE @DATA(lt_salida10).
    IF sy-subrc = 0.
      out->write( |=== INFORME DE CLIENTE: { ls_cliente-nombre } (ID: { ls_cliente-cliente_id }) ===| ).
      out->write( |Ciudad        : { ls_cliente-ciudad }| ).
      out->write( |Total Gastado : { lv_total_gastado } EUR| ).
      out->write( '----------------------------------------------------------------------' ).
      out->write( 'Detalle de sus pedidos:' ).
      out->write( lt_salida10 ).
    ELSE.
    out->write( 'No existen pedidos' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
