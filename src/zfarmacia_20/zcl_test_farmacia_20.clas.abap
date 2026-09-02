CLASS zcl_test_farmacia_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_farmacia_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "===========================================================
    " TIPOS LOCALES
    "===========================================================

    TYPES:
      BEGIN OF ty_medicamento_datos,
        iv_id                   TYPE i,
        iv_nombre               TYPE string,
        iv_laboratorio          TYPE string,
        iv_precio               TYPE zdecimals2,
        iv_stock                TYPE i,
        tipo                    TYPE c LENGTH 1,
        iv_requiere_receta      TYPE abap_bool,
        iv_principio_activo     TYPE string,
        coste_interno           TYPE zdecimals2,
        iv_porcentaje_descuento TYPE i,
        iv_nombre_comercial     TYPE string,
        iv_recargo_marca        TYPE i,
      END OF ty_medicamento_datos.

    TYPES tt_medicamentos
      TYPE STANDARD TABLE OF ty_medicamento_datos
      WITH NON-UNIQUE KEY iv_id.


    TYPES:
      BEGIN OF ty_medicamento_publico,
        iv_id          TYPE i,
        iv_nombre      TYPE string,
        iv_laboratorio TYPE string,
        iv_precio      TYPE zdecimals2,
        iv_stock       TYPE i,
      END OF ty_medicamento_publico.

    TYPES tt_medicamentos_publicos
      TYPE STANDARD TABLE OF ty_medicamento_publico
      WITH EMPTY KEY.


    TYPES:
      BEGIN OF ty_medicamento_externo,
        codigo      TYPE i,
        descripcion TYPE string,
        fabricante  TYPE string,
        iv_precio   TYPE zdecimals2,
        univ_idades TYPE i,
      END OF ty_medicamento_externo.

    TYPES tt_medicamentos_externos
      TYPE STANDARD TABLE OF ty_medicamento_externo
      WITH EMPTY KEY.


    TYPES:
      BEGIN OF ty_medicamento_auditoria,
        iv_id         TYPE i,
        iv_nombre     TYPE string,
        iv_precio     TYPE zdecimals2,
        coste_interno TYPE zdecimals2,
      END OF ty_medicamento_auditoria.


    TYPES:
      BEGIN OF ty_resumen_medicamento,
        iv_id     TYPE i,
        iv_nombre TYPE string,
        iv_precio TYPE zdecimals2,
        iv_stock  TYPE i,
      END OF ty_resumen_medicamento.

    TYPES tt_resumen_medicamentos
      TYPE STANDARD TABLE OF ty_resumen_medicamento
      WITH EMPTY KEY.


    TYPES:
      BEGIN OF ty_valor_iv_stock,
        iv_id         TYPE i,
        iv_nombre     TYPE string,
        subtotal      TYPE zdecimals2,
        iva           TYPE zdecimals2,
        total_con_iva TYPE zdecimals2,
      END OF ty_valor_iv_stock.

    TYPES tt_valor_iv_stock
      TYPE STANDARD TABLE OF ty_valor_iv_stock
      WITH EMPTY KEY.


    TYPES tt_medicamentos_por_iv_stock
      TYPE SORTED TABLE OF ty_medicamento_datos
      WITH NON-UNIQUE KEY iv_stock.


    TYPES tt_medicamentos_lab_iv_nombre
      TYPE SORTED TABLE OF ty_medicamento_datos
      WITH NON-UNIQUE KEY iv_laboratorio iv_nombre
      WITH NON-UNIQUE SORTED KEY por_iv_nombre
        COMPONENTS iv_nombre.


    TYPES tt_obj_medicamentos
      TYPE STANDARD TABLE OF REF TO zcl_medicamento_20
      WITH EMPTY KEY.


    "===========================================================
    " FASE 1 - TABLA INICIAL CON DATA + VALUE
    "===========================================================

    DATA(lt_medicamentos) = VALUE tt_medicamentos(

      ( iv_id = 1
        iv_nombre = 'Paracetamol'
        iv_laboratorio = 'Cinfa'
        iv_precio = '2.50'
        iv_stock = 40
        tipo = 'G'
        iv_requiere_receta = abap_false
        iv_principio_activo = 'Paracetamol'
        coste_interno = '1.20'
        iv_porcentaje_descuento = 10
        iv_nombre_comercial = ''
        iv_recargo_marca = 0 )

      ( iv_id = 2
        iv_nombre = 'Ibuprofeno'
        iv_laboratorio = 'Kern Pharma'
        iv_precio = '3.80'
        iv_stock = 15
        tipo = 'G'
        iv_requiere_receta = abap_false
        iv_principio_activo = 'Ibuprofeno'
        coste_interno = '1.80'
        iv_porcentaje_descuento = 5
        iv_nombre_comercial = ''
        iv_recargo_marca = 0 )

      ( iv_id = 3
        iv_nombre = 'Omeprazol'
        iv_laboratorio = 'Cinfa'
        iv_precio = '5.10'
        iv_stock = 25
        tipo = 'G'
        iv_requiere_receta = abap_false
        iv_principio_activo = 'Omeprazol'
        coste_interno = '2.50'
        iv_porcentaje_descuento = 20
        iv_nombre_comercial = ''
        iv_recargo_marca = 0 )

      ( iv_id = 4
        iv_nombre = 'Amoxicilina'
        iv_laboratorio = 'GSK'
        iv_precio = '6.20'
        iv_stock = 8
        tipo = 'M'
        iv_requiere_receta = abap_true
        iv_principio_activo = 'Amoxicilina + clavulánico'
        coste_interno = '3.10'
        iv_porcentaje_descuento = 0
        iv_nombre_comercial = 'Augmentine'
        iv_recargo_marca = 10 )

      ( iv_id = 5
        iv_nombre = 'Acenocumarol'
        iv_laboratorio = 'Viatris'
        iv_precio = '4.90'
        iv_stock = 3
        tipo = 'M'
        iv_requiere_receta = abap_true
        iv_principio_activo = 'Acenocumarol'
        coste_interno = '2.20'
        iv_porcentaje_descuento = 0
        iv_nombre_comercial = 'Sintrom'
        iv_recargo_marca = 20 )

      ( iv_id = 6
        iv_nombre = 'Salbutamol'
        iv_laboratorio = 'GSK'
        iv_precio = '6.00'
        iv_stock = 0
        tipo = 'M'
        iv_requiere_receta = abap_true
        iv_principio_activo = 'Salbutamol'
        coste_interno = '3.50'
        iv_porcentaje_descuento = 0
        iv_nombre_comercial = 'Ventolin'
        iv_recargo_marca = 15 )
    ).

    out->write( '===== FASE 1 =====' ).
    out->write( |Medicamentos: { lines( lt_medicamentos ) }| ).


    "===========================================================
    " FASE 2 - COND / SWITCH / XSDBOOL
    "===========================================================

    out->write( '===== FASE 2 =====' ).

    LOOP AT lt_medicamentos INTO DATA(ls_medicamento).

      DATA(lv_categoria_iv_stock) = COND string(
        WHEN ls_medicamento-iv_stock >= 30 THEN 'iv_stock ALTO'
        WHEN ls_medicamento-iv_stock >= 10 THEN 'iv_stock MEDIO'
        WHEN ls_medicamento-iv_stock >= 1  THEN 'iv_stock BAJO'
        ELSE 'SIN iv_stock'
      ).

      DATA(lv_tipo) = SWITCH string(
        ls_medicamento-tipo
        WHEN 'G' THEN 'GENÉRICO'
        WHEN 'M' THEN 'MARCA'
        WHEN 'H' THEN 'HOSPITALARIO'
        ELSE 'DESCONOCiv_idO'
      ).

      DATA(lv_disponible) = xsdbool(
        ls_medicamento-iv_stock > 0
        AND ls_medicamento-iv_precio > 0
      ).

      out->write(
        |{ ls_medicamento-iv_id } - { ls_medicamento-iv_nombre } - { lv_categoria_iv_stock } - { lv_tipo } - Disponible: { lv_disponible }|
      ).

    ENDLOOP.


    "===========================================================
    " FASE 3 - CONV
    "===========================================================

    out->write( '===== FASE 3 =====' ).

    DATA(lv_cantiv_idad_texto) = '12'.
    DATA(lv_iv_precio_texto) = '3.50'.

    DATA(lv_cantiv_idad) = CONV i( lv_cantiv_idad_texto ).
    DATA(lv_iv_precio) = CONV zdecimals2( lv_iv_precio_texto ).

    DATA(lv_total_venta) =
      CONV zdecimals2( lv_cantiv_idad * lv_iv_precio ).

    out->write( |12 x 3,50 = { lv_total_venta }| ).

    DATA(lv_25_decimal) = CONV zdecimals2( 25 ).

    out->write( |25 convertiv_ido a decimal = { lv_25_decimal }| ).

    DATA(lv_25_80) = CONV decfloat34( '25.80' ).
    DATA(lv_25_80_entero) = CONV i( lv_25_80 ).

    out->write(
      |25,80 convertiv_ido a entero = { lv_25_80_entero }|
    ).


    "===========================================================
    " ROUND / TRUNC / CEIL / FLOOR
    "===========================================================

    DATA(lv_numero) = CONV decfloat34( '25.80' ).

    out->write(
      |ROUND 25,80 = { round( val = lv_numero dec = 0 ) }|
    ).

    out->write(
      |TRUNC 25,80 = { trunc( lv_numero  ) }|
    ).

    out->write(
      |CEIL 25,80 = { ceil( lv_numero ) }|
    ).

    out->write(
      |FLOOR 25,80 = { floor( lv_numero ) }|
    ).


    DATA(lv_numero_negativo) = CONV decfloat34( '-25.80' ).

    out->write(
      |ROUND -25,80 = { round( val = lv_numero_negativo dec = 0 ) }|
    ).

    out->write(
      |TRUNC -25,80 = { trunc( lv_numero_negativo ) }|
    ).

    out->write(
      |CEIL -25,80 = { ceil( lv_numero_negativo ) }|
    ).

    out->write(
      |FLOOR -25,80 = { floor( lv_numero_negativo ) }|
    ).


    "===========================================================
    " FASE 4 - EXACT
    "===========================================================

    out->write( '===== FASE 4 =====' ).

    TRY.

        DATA(lv_exact_correcto) =
          EXACT i( CONV decfloat34( '25.00' ) ).

        out->write(
          |EXACT 25,00 = { lv_exact_correcto }|
        ).

      CATCH cx_sy_conversion_error.

        out->write(
          'ERROR EN EXACT 25,00'
        ).

    ENDTRY.


    TRY.

        DATA(lv_exact_incorrecto) =
          EXACT i( CONV decfloat34( '25.75' ) ).

        out->write(
          |EXACT 25,75 = { lv_exact_incorrecto }|
        ).

      CATCH cx_sy_conversion_error.

        out->write(
          'NO SE PUEDE CONVERTIR 25,75 SIN PERDER INFORMACIÓN'
        ).

    ENDTRY.


    "===========================================================
    " FASE 5 - EXPRESIONES DE TABLA
    "===========================================================

    out->write( '===== FASE 5 =====' ).

    DATA(ls_iv_id_3) = lt_medicamentos[ iv_id = 3 ].

    out->write(
      |iv_id 3 = { ls_iv_id_3-iv_nombre }|
    ).

    DATA(lv_iv_nombre_4) =
      lt_medicamentos[ iv_id = 4 ]-iv_nombre.

    out->write(
      |iv_nombre iv_id 4 = { lv_iv_nombre_4 }|
    ).

    DATA(lv_iv_precio_2) =
      lt_medicamentos[ iv_id = 2 ]-iv_precio.

    out->write(
      |iv_precio iv_id 2 = { lv_iv_precio_2 }|
    ).

    DATA(ls_primero) = lt_medicamentos[ 1 ].

    out->write(
      |Primera fila = { ls_primero-iv_nombre }|
    ).


    TRY.

        DATA(ls_iv_id_99) =
          lt_medicamentos[ iv_id = 99 ].

      CATCH cx_sy_itab_line_not_found.

        out->write(
          'MEDICAMENTO NO ENCONTRADO'
        ).

    ENDTRY.


    "===========================================================
    " FASE 6 - line_exists / OPTIONAL / DEFAULT / line_index
    "===========================================================

    out->write( '===== FASE 6 =====' ).

    DATA(lv_existe_5) =
      xsdbool( line_exists( lt_medicamentos[ iv_id = 5 ] ) ).

    DATA(lv_existe_99) =
      xsdbool( line_exists( lt_medicamentos[ iv_id = 99 ] ) ).

    out->write(
      |iv_id 5 existe = { lv_existe_5 }|
    ).

    out->write(
      |iv_id 99 existe = { lv_existe_99 }|
    ).


    DATA(ls_optional) =
      VALUE ty_medicamento_datos(
        lt_medicamentos[ iv_id = 99 ]
        OPTIONAL
      ).

    out->write(
      |OPTIONAL -> iv_id: { ls_optional-iv_id }|
    ).

    out->write(
      |OPTIONAL -> iv_nombre: { ls_optional-iv_nombre }|
    ).

    out->write(
      |OPTIONAL -> iv_precio: { ls_optional-iv_precio }|
    ).

    out->write(
      |OPTIONAL -> iv_stock: { ls_optional-iv_stock }|
    ).


    DATA(ls_default) =
      VALUE ty_medicamento_datos(
        lt_medicamentos[ iv_id = 99 ]
        DEFAULT VALUE #(
          iv_id = 0
          iv_nombre = 'MEDICAMENTO NO ENCONTRADO'
          iv_precio = 0
          iv_stock = 0
        )
      ).

    out->write(
      |DEFAULT -> { ls_default-iv_nombre }|
    ).


    DATA(lv_indice_3) =
      line_index( lt_medicamentos[ iv_id = 3 ] ).

    DATA(lv_indice_99) =
      line_index( lt_medicamentos[ iv_id = 99 ] ).

    out->write(
      |Índice iv_id 3 = { lv_indice_3 }|
    ).

    out->write(
      |Índice iv_id 99 = { lv_indice_99 }|
    ).


    "===========================================================
    " FASE 7 - CORRESPONDING
    "===========================================================

    out->write( '===== FASE 7 =====' ).

    DATA(lt_publicos) =
      CORRESPONDING tt_medicamentos_publicos(
        lt_medicamentos
      ).

    out->write(
      |Filas públicas = { lines( lt_publicos ) }|
    ).

    out->write(
      lt_publicos[ 1 ]
    ).


    "===========================================================
    " MAPPING
    "===========================================================

    DATA(lt_externos) =
      CORRESPONDING tt_medicamentos_externos(
        lt_medicamentos
        MAPPING
          codigo      = iv_id
          descripcion = iv_nombre
          fabricante  = iv_laboratorio
          iv_precio      = iv_precio
          univ_idades    = iv_stock
      ).

    out->write(
      lt_externos[ 1 ]
    ).


    "===========================================================
    " EXCEPT
    "===========================================================

    DATA(ls_paracetamol) =
      lt_medicamentos[ iv_id = 1 ].

    DATA(ls_auditoria) =
      CORRESPONDING ty_medicamento_auditoria(
        ls_paracetamol
        EXCEPT coste_interno
      ).

    out->write(
      |Auditoría: { ls_auditoria-iv_id } - { ls_auditoria-iv_nombre } - { ls_auditoria-iv_precio } - Coste: { ls_auditoria-coste_interno }|
    ).


    "===========================================================
    " FASE 8 - BASE
    "===========================================================

    out->write( '===== FASE 8 =====' ).

    DATA(ls_ibuprofeno) =
      lt_medicamentos[ iv_id = 2 ].

    DATA(ls_ibuprofeno_nuevo) =
      VALUE ty_medicamento_datos(
        BASE ls_ibuprofeno
        iv_stock = 35
      ).

    out->write(
      |Ibuprofeno original = { ls_ibuprofeno-iv_stock }|
    ).

    out->write(
      |Ibuprofeno nuevo = { ls_ibuprofeno_nuevo-iv_stock }|
    ).


    "===========================================================
    " FASE 9 - FOR
    "===========================================================

    out->write( '===== FASE 9 =====' ).

    DATA(lt_resumen) =
      VALUE tt_resumen_medicamentos(
        FOR ls_med IN lt_medicamentos
        (
          iv_id     = ls_med-iv_id
          iv_nombre = ls_med-iv_nombre
          iv_precio = ls_med-iv_precio
          iv_stock  = ls_med-iv_stock
        )
      ).

    out->write(
      |Filas resumen = { lines( lt_resumen ) }|
    ).

    out->write(
      lt_resumen[ 1 ]
    ).

    out->write(
      lt_resumen[ 6 ]
    ).


    "===========================================================
    " FOR + CORRESPONDING
    "===========================================================

    DATA(lt_publicos_for) =
      VALUE tt_medicamentos_publicos(
        FOR ls_med IN lt_medicamentos
        (
          CORRESPONDING ty_medicamento_publico(
            ls_med
          )
        )
      ).

    out->write(
      |Filas FOR + CORRESPONDING = { lines( lt_publicos_for ) }|
    ).


    "===========================================================
    " FASE 10 - LET ... IN
    "===========================================================

    out->write( '===== FASE 10 =====' ).

    DATA(lt_valor_iv_stock) =
      VALUE tt_valor_iv_stock(
        FOR ls_med IN lt_medicamentos

        LET lv_subtotal =
              CONV zdecimals2(
                ls_med-iv_precio * ls_med-iv_stock
              )

            lv_iva =
              CONV zdecimals2(
                lv_subtotal * '0.04'
              )

        IN
        (
          iv_id            = ls_med-iv_id
          iv_nombre        = ls_med-iv_nombre
          subtotal      = lv_subtotal
          iva           = lv_iva
          total_con_iva = lv_subtotal + lv_iva
        )
      ).

    out->write(
      lt_valor_iv_stock
    ).


    "===========================================================
    " FASE 11 - SORTED TABLE POR iv_stock
    "===========================================================

    out->write( '===== FASE 11 =====' ).

    DATA(lt_por_iv_stock) =
      VALUE tt_medicamentos_por_iv_stock(
        FOR ls_med IN lt_medicamentos
        (
          ls_med
        )
      ).

    LOOP AT lt_por_iv_stock INTO DATA(ls_iv_stock).
      out->write(
        |iv_id { ls_iv_stock-iv_id } - { ls_iv_stock-iv_nombre } - iv_stock { ls_iv_stock-iv_stock }|
      ).
    ENDLOOP.


    "===========================================================
    " CLAVE COMPUESTA iv_laboratorio + iv_nombre
    "===========================================================

    DATA(lt_lab_iv_nombre) =
      VALUE tt_medicamentos_lab_iv_nombre(
        FOR ls_med IN lt_medicamentos
        (
          ls_med
        )
      ).

    LOOP AT lt_lab_iv_nombre INTO DATA(ls_lab_iv_nombre).
      out->write(
        |{ ls_lab_iv_nombre-iv_laboratorio } - { ls_lab_iv_nombre-iv_nombre }|
      ).
    ENDLOOP.


    "===========================================================
    " CLAVE SECUNDARIA POR_iv_nombre
    "===========================================================

    DATA(ls_omeprazol) =
      lt_lab_iv_nombre[
        KEY por_iv_nombre
        iv_nombre = 'Omeprazol'
      ].

    out->write(
      |Omeprazol mediante clave secundaria -> iv_id { ls_omeprazol-iv_id }|
    ).


    "===========================================================
    " FASE 12 - FILTER
    "===========================================================

    out->write( '===== FASE 12 =====' ).

    DATA(lt_iv_stock_bajo) =
      FILTER #(
        lt_por_iv_stock
        USING KEY primary_key
        WHERE iv_stock <= 10
      ).

    DATA(lt_iv_stock_mayor_10) =
      FILTER #(
        lt_por_iv_stock
        USING KEY primary_key
        WHERE iv_stock > 10
      ).

    out->write(
      |iv_stock <= 10: { lines( lt_iv_stock_bajo ) } medicamentos|
    ).

    LOOP AT lt_iv_stock_bajo INTO DATA(ls_bajo).
      out->write(
        |{ ls_bajo-iv_nombre } -> { ls_bajo-iv_stock }|
      ).
    ENDLOOP.

    out->write(
      |iv_stock > 10: { lines( lt_iv_stock_mayor_10 ) } medicamentos|
    ).

    LOOP AT lt_iv_stock_mayor_10 INTO DATA(ls_mayor).
      out->write(
        |{ ls_mayor-iv_nombre } -> { ls_mayor-iv_stock }|
      ).
    ENDLOOP.


    "===========================================================
    " FASE 13 - REDUCE
    "===========================================================

    out->write( '===== FASE 13 =====' ).

    DATA(lv_total_univ_idades) =
      REDUCE i(
        INIT lv_total = 0
        FOR ls_med IN lt_medicamentos
        NEXT lv_total = lv_total + ls_med-iv_stock
      ).

    out->write(
      |Total univ_idades = { lv_total_univ_idades }|
    ).


    DATA(lv_inventario) =
      REDUCE zdecimals2(
        INIT lv_total = CONV i( 0 )
        FOR ls_med IN lt_medicamentos
        NEXT lv_total =
          lv_total +
          CONV zdecimals2(
            ls_med-iv_precio * ls_med-iv_stock
          )
      ).

    out->write(
      |Valor inventario = { lv_inventario }|
    ).


    DATA(lv_inventario_mayor_10) =
      REDUCE zdecimals2(
        INIT lv_total = CONV i( 0 )
        FOR ls_med IN lt_medicamentos
        WHERE ( iv_stock > 10 )
        NEXT lv_total =
          lv_total +
          CONV zdecimals2(
            ls_med-iv_precio * ls_med-iv_stock
          )
      ).

    FINAL(lv_resultado_final) = lv_inventario_mayor_10.

    out->write(
      |Valor inventario iv_stock > 10 = { lv_resultado_final }|
    ).


    "===========================================================
    " FASE 14 - NEW
    "===========================================================

    out->write( '===== FASE 14 =====' ).

    DATA(lo_med_1) =
      NEW zcl_med_generico_20(
        iv_id = 1
        iv_nombre = 'Paracetamol'
        iv_laboratorio = 'Cinfa'
        iv_precio = '2.50'
        iv_stock = 40
        iv_requiere_receta = abap_false
        iv_principio_activo = 'Paracetamol'
        iv_porcentaje_descuento = 10
      ).

    DATA(lo_med_2) =
      NEW zcl_med_generico_20(
        iv_id = 2
        iv_nombre = 'Ibuprofeno'
        iv_laboratorio = 'Kern Pharma'
        iv_precio = '3.80'
        iv_stock = 15
        iv_requiere_receta = abap_false
        iv_principio_activo = 'Ibuprofeno'
        iv_porcentaje_descuento = 5
      ).

    DATA(lo_med_3) =
      NEW zcl_med_generico_20(
        iv_id = 3
        iv_nombre = 'Omeprazol'
        iv_laboratorio = 'Cinfa'
        iv_precio = '5.10'
        iv_stock = 25
        iv_requiere_receta = abap_false
        iv_principio_activo = 'Omeprazol'
        iv_porcentaje_descuento = 20
      ).

    DATA(lo_med_4) =
      NEW zcl_med_marca_20(
        iv_id = 4
        iv_nombre = 'Amoxicilina'
        iv_laboratorio = 'GSK'
        iv_precio = '6.20'
        iv_stock = 8
        iv_requiere_receta = abap_true
        iv_principio_activo = 'Amoxicilina + clavulánico'
        iv_nombre_comercial = 'Augmentine'
        iv_recargo_marca = 10
      ).

    DATA(lo_med_5) =
      NEW zcl_med_marca_20(
        iv_id = 5
        iv_nombre = 'Acenocumarol'
        iv_laboratorio = 'Viatris'
        iv_precio = '4.90'
        iv_stock = 3
        iv_requiere_receta = abap_true
        iv_principio_activo = 'Acenocumarol'
        iv_nombre_comercial = 'Sintrom'
        iv_recargo_marca = 20
      ).

    DATA(lo_med_6) =
      NEW zcl_med_marca_20(
        iv_id = 6
        iv_nombre = 'Salbutamol'
        iv_laboratorio = 'GSK'
        iv_precio = '6.00'
        iv_stock = 0
        iv_requiere_receta = abap_true
        iv_principio_activo = 'Salbutamol'
        iv_nombre_comercial = 'Ventolin'
        iv_recargo_marca = 15
      ).


    "===========================================================
    " TABLA DE REFERENCIAS
    "===========================================================

    DATA(lt_obj_medicamentos) =
      VALUE tt_obj_medicamentos(
        ( lo_med_1 )
        ( lo_med_2 )
        ( lo_med_3 )
        ( lo_med_4 )
        ( lo_med_5 )
        ( lo_med_6 )
      ).

    out->write(
      |Objetos creados = { lines( lt_obj_medicamentos ) }|
    ).


    "===========================================================
    " FASE 15 - IS INSTANCE OF + CAST
    "===========================================================

    out->write( '===== FASE 15 =====' ).

    DATA(lo_objeto_1) =
      lt_obj_medicamentos[ 1 ].

    IF lo_objeto_1 IS INSTANCE OF zcl_med_generico_20.

      DATA(lo_generico) =
        CAST zcl_med_generico_20(
          lo_objeto_1
        ).

      out->write(
        |iv_id 1 es genérico -> Descuento { lo_generico->porcentaje_descuento } %|
      ).

    ENDIF.


    DATA(lo_objeto_5) =
      lt_obj_medicamentos[ 5 ].

    IF lo_objeto_5 IS INSTANCE OF zcl_med_marca_20.

      DATA(lo_marca) =
        CAST zcl_med_marca_20(
          lo_objeto_5
        ).

      out->write(
        |iv_id 5 es marca -> { lo_marca->nombre_comercial } -> Recargo { lo_marca->recargo_marca } %|
      ).

    ENDIF.


    "===========================================================
    " CAST INCORRECTO
    "===========================================================

    TRY.

        DATA(lo_cast_incorrecto) =
          CAST zcl_med_marca_20(
            lo_objeto_1
          ).

      CATCH cx_sy_move_cast_error.

        out->write(
          'NO SE PUEDE CONVERTIR UN GENÉRICO EN UN MEDICAMENTO DE MARCA'
        ).

    ENDTRY.


    "===========================================================
    " FASE 16 - POLIMORFISMO
    "===========================================================

    out->write( '===== FASE 16 =====' ).

    LOOP AT lt_obj_medicamentos INTO DATA(lo_medicamento).

      DATA(lv_iv_precio_final) =
        lo_medicamento->calcular_precio_final( ).

      out->write(
        |{ lo_medicamento->id } - { lo_medicamento->nombre } - iv_precio final: { lv_iv_precio_final }|
      ).

    ENDLOOP.


    "===========================================================
    " FASE 17 - REF
    "===========================================================

    out->write( '===== FASE 17 =====' ).

    DATA(lt_copia) = lt_medicamentos.

    DATA(lr_ibuprofeno) =
      REF #( lt_copia[ iv_id = 2 ] ).

    lr_ibuprofeno->iv_stock = 99.

    out->write(
      |Ibuprofeno después de REF = { lt_copia[ iv_id = 2 ]-iv_stock }|
    ).


    "===========================================================
    " RESUMEN FINAL
    "===========================================================

    out->write( '========================================' ).
    out->write( '           RESUMEN FINAL' ).
    out->write( '========================================' ).

    out->write(
      |Medicamentos iniciales: { lines( lt_medicamentos ) }|
    ).

    out->write(
      |Venta 12 x 3,50: { lv_total_venta }|
    ).

    out->write(
      |Total univ_idades: { lv_total_univ_idades }|
    ).

    out->write(
      |Valor inventario: { lv_inventario }|
    ).

    out->write(
      |Valor iv_stock > 10: { lv_resultado_final }|
    ).

    out->write(
      |Objetos creados: { lines( lt_obj_medicamentos ) }|
    ).

    out->write( '========================================' ).
  ENDMETHOD.
ENDCLASS.
