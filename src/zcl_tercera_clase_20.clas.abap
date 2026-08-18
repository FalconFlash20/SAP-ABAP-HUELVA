CLASS zcl_tercera_clase_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TERCERA_CLASE_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    ""Define con TYPES una estructura ty_producto con los campos nombre (texto) y precio (decimal), y una tabla tt_productos de ese tipo.
*    "Declara las variables correspondientes con DATA. Añade 3 productos a la tabla con APPEND.
*    "Usando LOOP AT, recorre la tabla y muestra con out->write( ) el nombre de cada producto.
*    TYPES: BEGIN OF ty_producto,
*             nombre TYPE string,
*             precio TYPE p LENGTH 10 DECIMALS 2,
*           END OF ty_producto.
*    DATA ls_producto TYPE ty_producto.
*    DATA: lt_productos TYPE TABLE OF ty_producto.
*    ls_producto-nombre = 'Silla'.
*    ls_producto-precio = '100.00'.
*    APPEND ls_producto TO lt_productos.
*    ls_producto-nombre = 'Mesa'.
*    ls_producto-precio = '200.00'.
*    APPEND ls_producto TO lt_productos.
*    ls_producto-nombre =  'Sofa'.
*    ls_producto-precio = '400.00'.
*    APPEND ls_producto TO lt_productos.
*    LOOP AT lt_productos INTO ls_producto.
*      out->write( ls_producto-nombre ).
*    ENDLOOP.
*    out->write( '--------' ).
*
*
*
*    "Define con TYPES una estructura ty_empleado con los campos nombre (texto) y salario (decimal), y una tabla tt_empleados de ese tipo.
*    "Añade 4 empleados a la tabla con salarios distintos.
*    "Usando LOOP AT, recorre la tabla y, con un IF dentro del bucle, muestra con out->write( ) únicamente el nombre de los empleados cuyo salario sea mayor que 2000.
*    TYPES: BEGIN OF ty_empleado,
*             nombre  TYPE string,
*             salario TYPE p LENGTH 10 DECIMALS 2,
*           END OF ty_empleado.
*    DATA ls_empleado TYPE ty_empleado.
*    DATA lt_empleados TYPE TABLE OF ty_empleado.
*    ls_empleado-nombre = 'Juan'.
*    ls_empleado-salario = '1000.00'.
*    APPEND ls_empleado TO lt_empleados.
*    ls_empleado-nombre = 'Maria'.
*    ls_empleado-salario = '2500.00'.
*    APPEND ls_empleado TO lt_empleados.
*    ls_empleado-nombre = 'Jose'.
*    ls_empleado-salario = '3000.00'.
*    APPEND ls_empleado TO lt_empleados.
*
*    LOOP AT lt_empleados INTO ls_empleado.
*      IF ls_empleado-salario > 2000.
*        out->write( ls_empleado-nombre ).
*      ENDIF.
*    ENDLOOP.
*    out->write( '--------' ).
*
*
*    "Define con TYPES una estructura ty_pedido con los campos id_pedido (entero), importe (decimal) y estado (texto), y una tabla tt_pedidos de ese tipo.
*    "Usando un DO 6 TIMES, genera pedidos donde id_pedido sea el número de vuelta, importe sea el resultado de multiplicar el número de vuelta por 45.30,
*    "y estado se calcule con CASE sobre el resto de dividir el número de vuelta entre 3: si el resto es 0, 'ENVIADO'; si es 1, 'PENDIENTE'; si es 2, 'CANCELADO'.
*    "Añade cada pedido a la tabla con APPEND.
*    "Después, usando LOOP AT, recorre toda la tabla y muestra con out->write( ) solo los pedidos cuyo estado sea 'PENDIENTE', junto con su importe.
*    "Al terminar el bucle, muestra también con out->write( ) cuántos pedidos en total quedaron 'PENDIENTE' (usa un contador que incrementes dentro del IF).
*    TYPES: BEGIN OF ty_pedido,
*             id_pedido TYPE i,
*             importe   TYPE p LENGTH 10 DECIMALS 2,
*             estado    TYPE string,
*           END OF ty_pedido.
*    DATA ls_pedido TYPE ty_pedido.
*    DATA lt_pedidos TYPE TABLE OF ty_pedido.
*    DATA lv_resto TYPE i.
*    DATA contador TYPE i.
*    DO 6 TIMES.
*      ls_pedido-id_pedido = sy-index.
*      ls_pedido-importe = sy-index * '45.30'.
*      lv_resto = sy-index MOD 3.
*      CASE lv_resto.
*        WHEN 0.
*          ls_pedido-estado = 'ENVIADO'.
*        WHEN 1.
*          ls_pedido-estado = `PENDIENTE`.
*        WHEN 2.
*          ls_pedido-estado = 'CANCELADO'.
*      ENDCASE.
*      APPEND ls_pedido TO lt_pedidos.
*    ENDDO.
*    LOOP AT lt_pedidos INTO ls_pedido.
*      IF ls_pedido-estado = 'PENDIENTE'.
*        out->write( |El ID es { ls_pedido-id_pedido } y el importe es { ls_pedido-importe }| ).
*        contador += 1.
*      ENDIF.
*    ENDLOOP.
*    out->write( contador ).



*    "Declara con TYPES/DATA una estructura ty_producto con los campos nombre (texto) y precio (decimal), y su correspondiente tabla lt_producto.
*    "Añade 4 productos con APPEND. Usando READ TABLE, busca el producto que ocupa la *posición 2* de la tabla (INDEX).
*    "Comprueba sy-subrc y, si lo encuentra, muestra con out->write( ) y pipes su nombre y precio; si no lo encuentra, muestra un mensaje indicándolo.
*    TYPES: BEGIN OF ty_producto,
*             nombre TYPE string,
*             precio TYPE p LENGTH 10 DECIMALS 2,
*           END OF ty_producto.
*    DATA: ls_producto  TYPE ty_producto,
*          lt_productos TYPE TABLE OF ty_producto.
*    ls_producto-nombre = 'Coche'.
*    ls_producto-precio = 20000.
*    APPEND ls_producto TO lt_productos.
*    ls_producto-nombre = 'Sarten'.
*    ls_producto-precio = 50.
*    APPEND ls_producto TO lt_productos.
*    ls_producto-nombre = 'Boligrafo'.
*    ls_producto-precio = 1.
*    APPEND ls_producto TO lt_productos.
*    ls_producto-nombre = 'Pan'.
*    ls_producto-precio = '2.50'.
*    APPEND ls_producto TO lt_productos.
*    READ table lt_productos into ls_producto index 2.
*    if sy-subrc = 0.
*        out->write( |El nombre es { ls_producto-nombre } y el precio es { ls_producto-precio }| ).
*    else.
*        out->write( 'No se encuentra el producto' ).
*    endif.
*
*
*    "Declara con TYPES/DATA una estructura ty_empleado con los campos id_empleado (entero), nombre (texto) y departamento (texto), y su tabla lt_empleado.
*    "Añade 5 empleados con distintos id_empleado y departamento (por ejemplo 'VENTAS', 'IT', etc.).
*    "Usando READ TABLE con WITH KEY, busca el empleado cuyo id_empleado sea 3.
*    "Comprueba sy-subrc: si lo encuentra, muestra su nombre y departamento con out->write( ); si no lo encuentra, muestra un aviso de que no existe ese empleado.
*    types: begin OF ty_empleado,
*           id_empleado TYPE i,
*           nombre type string,
*           departamento type string,
*           END OF ty_empleado.
*    data: ls_empleado TYPE ty_empleado,
*          lt_empleados TYPE table of ty_empleado.
*    ls_empleado-id_empleado += 1.
*    ls_empleado-nombre = 'Pepe'.
*    ls_empleado-departamento = 'Marketing'.
*    APPEND ls_empleado to lt_empleados.
*    ls_empleado-id_empleado += 1.
*    ls_empleado-nombre = 'Lola'.
*    ls_empleado-departamento = 'Finanzas'.
*    APPEND ls_empleado to lt_empleados.
*    ls_empleado-id_empleado += 1.
*    ls_empleado-nombre = 'Manu'.
*    ls_empleado-departamento = 'IT'.
*    APPEND ls_empleado to lt_empleados.
*    ls_empleado-id_empleado += 1.
*    ls_empleado-nombre = 'Rodri'.
*    ls_empleado-departamento = 'I+D'.
*    APPEND ls_empleado to lt_empleados.
*    ls_empleado-id_empleado += 1.
*    ls_empleado-nombre = 'Fran'.
*    ls_empleado-departamento = 'CEO'.
*    APPEND ls_empleado to lt_empleados.
*    READ TABLE lt_empleados into ls_empleado WITH KEY id_empleado = 3.
*    if sy-subrc = 0.
*        out->write( |El nombre del empleado es { ls_empleado-nombre } y pertenence al departamento de { ls_empleado-departamento }| ).
*    else.
*        out->write( 'No se ha encontrado al empleado' ).
*   endif.


*    "Declara con TYPES/DATA una estructura ty_pedido con los campos id_pedido (entero), importe (decimal) y estado (texto), y su tabla lt_pedido.
*    "Usando un DO 6 TIMES, genera pedidos donde id_pedido sea el número de vuelta,
*    "importe sea el número de vuelta multiplicado por 50.25,
*    "y estado se calcule con CASE sobre el resto de dividir el número de vuelta entre 2: 'ENVIADO' si es par, 'PENDIENTE' si es impar.
*    "Añade cada uno con APPEND. Después, declara una variable entera lv_id_buscado con el valor 4,
*    "y usando READ TABLE con WITH KEY, busca el pedido cuyo id_pedido coincida con lv_id_buscado *y además* cuyo estado sea 'PENDIENTE' (combina ambas condiciones en la misma cláusula WITH KEY).
*    "Comprueba sy-subrc: si lo encuentra, muestra su importe con out->write( ); si no lo encuentra, muestra un mensaje indicando que no hay ningún pedido pendiente con ese ID.
*    TYPES: BEGIN OF ty_pedido,
*             id_pedido TYPE i,
*             importe   TYPE p LENGTH 10 DECIMALS 2,
*             estado    TYPE string,
*           END OF ty_pedido.
*    DATA: ls_pedido  TYPE ty_pedido,
*          lt_pedidos TYPE TABLE OF ty_pedido.
*    DATA lv_resto TYPE i.
*    DATA lv_id_buscado TYPE i VALUE 4.
*    DO 6 TIMES.
*      ls_pedido-id_pedido = sy-index.
*      ls_pedido-importe = sy-index * '50.25'.
*      lv_resto = sy-index MOD 2.
*      CASE lv_resto.
*        WHEN 0.
*          ls_pedido-estado = 'ENVIADO'.
*        WHEN 1.
*          ls_pedido-estado = 'PENDIENTE'.
*      ENDCASE.
*      APPEND ls_pedido TO lt_pedidos.
*    ENDDO.
*   clear ls_pedido.
*    READ TABLE lt_pedidos INTO ls_pedido WITH KEY id_pedido = lv_id_buscado estado = 'PENDIENTE'.
*    IF sy-subrc = 0.
*      out->write( |El importe es { ls_pedido-importe }| ).
*    ELSE.
*      out->write( 'No se ha encontrado el producto' ).
*    ENDIF.


    "Declara con TYPES/DATA una estructura ty_videojuego con los campos titulo (texto) y precio (decimal), y su tabla lt_videojuego.
    "Añade 4 videojuegos con APPEND. Usando LOOP AT ... ASSIGNING, recorre la tabla y aplica una rebaja del 20% al precio de cada videojuego directamente sobre la fila original
    "(sin usar INTO).
    "Al terminar, usando un segundo LOOP AT (esta vez con INTO o declaración inline),
    "muestra con out->write( ) y pipes el título y el nuevo precio de cada uno.
    TYPES:BEGIN OF ty_videojuego,
            titulo TYPE string,
            precio TYPE p LENGTH 10 DECIMALS 2,
          END OF ty_videojuego.

    DATA: ls_videojuego  TYPE ty_videojuego,
          lt_videojuegos TYPE TABLE OF ty_videojuego.

    ls_videojuego-titulo = 'Spyro'.
    ls_videojuego-precio = '40.00'.
    APPEND ls_videojuego TO lt_videojuegos.
    ls_videojuego-titulo = 'Spyro 2'.
    ls_videojuego-precio = '40.00'.
    APPEND ls_videojuego TO lt_videojuegos.
    ls_videojuego-titulo = 'Spyro 3'.
    ls_videojuego-precio = '40.00'.
    APPEND ls_videojuego TO lt_videojuegos.
    ls_videojuego-titulo = 'Spyro 4'.
    ls_videojuego-precio = '40.00'.
    APPEND ls_videojuego TO lt_videojuegos.

    LOOP AT lt_videojuegos ASSIGNING FIELD-SYMBOL(<fs_videojuego>).
      <fs_videojuego>-precio = <fs_videojuego>-precio * '0.8'.
      out->write( |El juego { <fs_videojuego>-titulo } cuesta { <fs_videojuego>-precio } €| ).
    ENDLOOP.


    "Declara con TYPES/DATA una estructura ty_expedicionario con los campos
    "nombre (texto), oxigeno_restante (entero) y estado (texto), y su tabla lt_expedicion.
    "Añade 5 miembros del equipo con distintos niveles de oxigeno_restante (algunos altos, otros bajos), dejando estado vacío de momento.
    "Usando LOOP AT ... ASSIGNING, recorre la tabla y, con un IF, actualiza el campo estado directamente sobre la fila original:
    "si oxigeno_restante es menor que 20, asigna 'RETIRADA INMEDIATA'; en caso contrario, asigna 'CONTINUA'.
    "Después, usando READ TABLE con declaración inline,
    "busca si existe algún expedicionario concreto por nombre y muestra su estado actualizado con pipes.
*TYPES: BEGIN OF ty_expedicionario,
*        nombre              TYPE string,
*        oxigeno_restante    TYPE i,
*        estado              TYPE string,
*       END OF ty_expedicionario.
*
*DATA: lt_expedicionario TYPE TABLE OF ty_expedicionario,
*      ls_expedicionario TYPE ty_expedicionario.
*
*ls_expedicionario-nombre            = 'LuisCA'.
*ls_expedicionario-oxigeno_restante  = 16.
*ls_expedicionario-estado            = ''.
*APPEND ls_expedicionario TO lt_expedicionario.
*
*ls_expedicionario-nombre            = 'Juan'.
*ls_expedicionario-oxigeno_restante  = 47.
*ls_expedicionario-estado            = ''.
*APPEND ls_expedicionario TO lt_expedicionario.
*
*ls_expedicionario-nombre            = 'Alicia'.
*ls_expedicionario-oxigeno_restante  = 61.
*ls_expedicionario-estado            = ''.
*APPEND ls_expedicionario TO lt_expedicionario.
*
*ls_expedicionario-nombre            = 'Maria'.
*ls_expedicionario-oxigeno_restante  = 32.
*ls_expedicionario-estado            = ''.
*APPEND ls_expedicionario TO lt_expedicionario.
*
*ls_expedicionario-nombre            = 'Pedro'.
*ls_expedicionario-oxigeno_restante  = 28.
*ls_expedicionario-estado            = ''.
*APPEND ls_expedicionario TO lt_expedicionario.
*
*FIELD-SYMBOLS: <fs_expedicionario> TYPE ty_expedicionario.
*
*
*LOOP AT lt_expedicionario ASSIGNING <fs_expedicionario>.
* IF  <fs_expedicionario>-oxigeno_restante < 20.
*     <fs_expedicionario>-estado = 'RETIRADA INMEDIATA'.
*     ELSE.
*     <fs_expedicionario>-estado = 'CONTINUA'.
*     ENDIF.
*ENDLOOP.
*
*READ TABLE lt_expedicionario ASSIGNING FIELD-SYMBOL(<fs_expedicionario_buscado>)
*     WITH KEY nombre = 'LuisCA'.
*        IF sy-subrc = 0.
*            out->write( |El estado de { <fs_expedicionario_buscado>-nombre } es: { <fs_expedicionario_buscado>-estado }| ).
*        ELSE.
*            out->write( |No se encontró ningún expedicionario con ese nombre| ).
*        ENDIF.

    "Declara con TYPES/DATA una estructura ty_reparacion con los campos id_reparacion (entero), coste (decimal) y prioridad (texto), y su tabla lt_reparaciones.
    "Usando DO 8 TIMES, genera reparaciones donde id_reparacion sea el número de vuelta, coste sea el número de vuelta multiplicado por 35.80,
    "y prioridad se calcule con CASE sobre el resto de dividir el número de vuelta entre 3:
    "'URGENTE' si el resto es 0, 'NORMAL' si es 1, 'BAJA' si es 2.
    "Añade cada una con APPEND.
    "Después, usando LOOP AT ... ASSIGNING con WHERE prioridad = 'URGENTE', aplica un recargo del 15% al coste de cada reparación urgente directamente sobre la fila original.
    "Finalmente, recorre toda la tabla con un LOOP AT normal y muestra con pipes un resumen de cada reparación (id, coste final, prioridad), y al terminar, muestra cuántas reparaciones en total quedaron con prioridad 'URGENTE'
    TYPES: BEGIN OF ty_reparacion,
             id_reparacion TYPE i,
             coste         TYPE p LENGTH 10 DECIMALS 2,
             prioridad     TYPE string,
           END OF ty_reparacion.

    DATA: lt_reparacion TYPE TABLE OF ty_reparacion,
          ls_reparacion TYPE ty_reparacion.
    DO 8 TIMES.
      ls_reparacion-id_reparacion = sy-index.
      ls_reparacion-coste = sy-index * '35.80'.
      CASE ls_reparacion-id_reparacion MOD 3.
        WHEN 0.
          ls_reparacion-prioridad = 'URGENTE'.
        WHEN 1.
          ls_reparacion-prioridad = 'NORMAL'.
        WHEN 2.
          ls_reparacion-prioridad = 'BAJA'.
      ENDCASE.
      APPEND ls_reparacion TO lt_reparacion.
    ENDDO.

    LOOP AT lt_reparacion ASSIGNING FIELD-SYMBOL(<fs_reparacion>) WHERE prioridad = 'URGENTE'.
      <fs_reparacion>-coste = <fs_reparacion>-coste + ( <fs_reparacion>-coste * '0.15' ).
    ENDLOOP.

    DATA: lv_contador_urgentes TYPE i.

    LOOP AT lt_reparacion INTO ls_reparacion.
      out->write( |El ID { ls_reparacion-id_reparacion } tiene un coste final de { ls_reparacion-coste } y la prioridad es: { ls_reparacion-prioridad }| ).
      IF ls_reparacion-prioridad = 'URGENTE'.
        lv_contador_urgentes = lv_contador_urgentes + 1.
      ENDIF.
    ENDLOOP.
    out->write( |Las reparaciones en estado 'URGENTE' son un total de: { lv_contador_urgentes }| ).


"Declara con TYPES/DATA una estructura ty_corredor con los campos dorsal (entero), tiempo_vuelta (decimal), equipo (texto) y estado (texto),
"y su tabla lt_corredores.
"Usando DO 10 TIMES, genera corredores
"donde dorsal sea el número de vuelta,
"tiempo_vuelta sea el resultado de 50 menos el número de vuelta multiplicado por 1.25 (para que varíen los tiempos),
"equipo se calcule con CASE sobre el resto de dividir el dorsal entre 2 ('ROJO' si es par, 'AZUL' si es impar),
"y estado se deje inicialmente vacío.
"Añade cada corredor con APPEND. Después, usando LOOP AT ... ASSIGNING sin filtro, recorre toda la tabla y, con un IF anidado combinando condiciones lógicas, actualiza estado directamente sobre la fila original:
"si tiempo_vuelta es menor que 40 Y el equipo es 'ROJO', asigna 'CLASIFICADO';
"si tiempo_vuelta es menor que 40 Y el equipo es 'AZUL', asigna 'CLASIFICADO' también, pero antes de asignarlo comprueba con un READ TABLE (por dorsal,
"usando declaración inline) si ya existe un corredor del equipo 'ROJO' con un tiempo_vuelta mejor (menor);
"si es así, asigna en su lugar 'DESCALIFICADO POR EQUIPO'. Para cualquier otro caso, asigna 'ELIMINADO'.
"Al terminar, recorre la tabla de nuevo con LOOP AT ... WHERE estado = 'CLASIFICADO' y muestra con pipes el resumen de los clasificados, junto con un contador final de cuántos corredores de cada equipo ('ROJO' y 'AZUL') lograron clasificarse.

    TYPES: BEGIN OF ty_corredor,
             dorsal        TYPE i,
             tiempo_vuelta TYPE p LENGTH 10 DECIMALS 2,
             equipo        TYPE string,
             estado        TYPE string,
           END OF ty_corredor.

    DATA: lt_corredores TYPE TABLE OF ty_corredor,
          ls_corredor   TYPE ty_corredor.

    DO 10 TIMES.
      ls_corredor-dorsal = sy-index.
      ls_corredor-tiempo_vuelta = 50 - ( sy-index * '1.25' ).
      CASE ls_corredor-dorsal MOD 2.
        WHEN 0.
          ls_corredor-equipo = 'ROJO'.
        WHEN 1.
          ls_corredor-equipo = 'AZUL'.
          ENDCASE.
          APPEND ls_corredor to lt_corredores.
      ENDDO.
      LOOP AT lt_corredores ASSIGNING FIELD-SYMBOL(<fs_corredor>).
        IF <fs_corredor>-tiempo_vuelta < 40 AND <fs_corredor>-equipo = 'ROJO'.
          <fs_corredor>-estado = 'CLASIFICADO'.
        ELSEIF <fs_corredor>-tiempo_vuelta < 40 AND <fs_corredor>-equipo = 'AZUL'.
          READ TABLE lt_corredores ASSIGNING FIELD-SYMBOL(<fs_clasificado>) WITH KEY equipo = <fs_corredor>-equipo.
          IF sy-subrc = 0 AND <fs_clasificado>-tiempo_vuelta < <fs_corredor>-tiempo_vuelta.
            <fs_corredor>-estado = 'DESCALIFICADO POR EQUIPO'.
          ELSE.
            <fs_corredor>-estado = 'CLASIFICADO'.

            ENDIF.
          ELSE.
            <fs_corredor>-estado = 'ELIMINADO'.
          ENDIF.
        ENDLOOP.

        DATA: lv_contador_rojos TYPE i,
              lv_contador_azules TYPE i.

        LOOP AT lt_corredores INTO ls_corredor WHERE estado = 'CLASIFICADO'.
          IF ls_corredor-equipo = 'ROJO'.
            lv_contador_rojos += 1.
          ELSEIF ls_corredor-equipo = 'AZUL'.
            lv_contador_azules += 1.
          ENDIF.
        ENDLOOP.

        out->write( |El equipo ROJO ha clasificado { lv_contador_rojos } corredores| ).
        out->write( |El equipo AZUL ha clasificado { lv_contador_azules } corredores| ).
  ENDMETHOD.
ENDCLASS.
