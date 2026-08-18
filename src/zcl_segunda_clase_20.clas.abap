CLASS zcl_segunda_clase_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SEGUNDA_CLASE_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "Declara una estructura ls_pedido con los campos id_pedido (entero), importe (decimal) y tipo_cliente (texto),
    "calculado a partir de un CASE.

    TYPES: BEGIN OF ty_pedido,
    id_pedido TYPE i,
    importe TYPE p LENGTH 10 DECIMALS 2,
    tipo_cliente TYPE string,
    END OF ty_pedido.
    DATA ls_pedido TYPE ty_pedido.

    "Declara una tabla interna lt_pedidos de ese tipo.

    DATA lt_pedido TYPE TABLE OF ty_pedido.
    DATA lv_cont TYPE i.
    DATA lv_resto TYPE i.
    "Usando un DO 5 TIMES,
    "para cada vuelta: asigna a id_pedido el número de vuelta (puedes usar una variable contador que incrementes tú mismo),

    DO 5 TIMES.
      lv_cont += 1.
      ls_pedido-id_pedido = lv_cont.
      ls_pedido-importe = lv_cont * '120.75'.

      lv_resto = lv_cont MOD 2.
          "asigna a importe el resultado de multiplicar el número de vuelta por 120.75,
    "y usando CASE sobre el resto de dividir el número de vuelta entre 2 (par o impar), asigna a tipo_cliente el valor 'PREMIUM' si es par, o 'ESTANDAR' si es impar.
    "Añade cada estructura resultante a la tabla con APPEND antes de pasar a la siguiente vuelta.
      CASE lv_resto.
        WHEN 0. "Caso par
          ls_pedido-tipo_cliente = 'PREMIUM'.
        WHEN 1. "Caso impar
          ls_pedido-tipo_cliente = 'ESTANDAR'.
      ENDCASE.
      APPEND ls_pedido TO lt_pedido.
    ENDDO.
    out->write( lt_pedido ).
    ENDMETHOD.
ENDCLASS.
