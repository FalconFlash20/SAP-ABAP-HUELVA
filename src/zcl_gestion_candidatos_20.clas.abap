CLASS zcl_gestion_candidatos_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_candidato_completo,
             id                 TYPE i,
             nombre_completo    TYPE string,
             anios_experiencia  TYPE i,
             dni                TYPE string,
             telefono_personal  TYPE string,
             salario_actual     TYPE p LENGTH 8 DECIMALS 2,
             salario_pretendido TYPE p LENGTH 8 DECIMALS 2,
             idoneidad          TYPE i,
             banda_salarial     TYPE string,
           END OF ty_candidato_completo,
           tt_candidatos_completos TYPE STANDARD TABLE OF ty_candidato_completo WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_ficha_candidato,
             id             TYPE i,
             nombre         TYPE string,
             experiencia    TYPE i,
             idoneidad      TYPE i,
             banda_salarial TYPE string,
           END OF ty_ficha_candidato,
           tt_fichas_candidatos TYPE STANDARD TABLE OF ty_ficha_candidato WITH DEFAULT KEY.

ENDCLASS.

CLASS zcl_gestion_candidatos_20 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    TYPES: BEGIN OF ty_init_data,
*             es_interno          TYPE abap_bool,
*             id                  TYPE i,
*             nombre              TYPE string,
*             experiencia         TYPE i,
*             dni                 TYPE string,
*             telefono            TYPE string,
*             salario_actual      TYPE p LENGTH 8 DECIMALS 2,
*             salario_pretendido  TYPE p LENGTH 8 DECIMALS 2,
*             num_certificaciones TYPE i,
*           END OF ty_init_data,
*           tt_init_data TYPE STANDARD TABLE OF ty_init_data WITH DEFAULT KEY.
*
*    DATA(lt_init_data) = VALUE tt_init_data(
*      ( es_interno = abap_true  id = 1 nombre = 'Carlos Ruiz'    experiencia = 8  dni = '11111111A' telefono = '600111111' salario_actual = '32000.00' salario_pretendido = '38000.00' num_certificaciones = 0 )
*      ( es_interno = abap_true  id = 2 nombre = 'Lucía Méndez'   experiencia = 20 dni = '22222222B' telefono = '600222222' salario_actual = '45000.00' salario_pretendido = '52000.00' num_certificaciones = 0 )
*      ( es_interno = abap_false id = 3 nombre = 'Adrián Pastor'  experiencia = 3  dni = '33333333C' telefono = '600333333' salario_actual = '24000.00' salario_pretendido = '27500.00' num_certificaciones = 4 )
*      ( es_interno = abap_false id = 4 nombre = 'Elena Salgado'  experiencia = 10 dni = '44444444D' telefono = '600444444' salario_actual = '40000.00' salario_pretendido = '45000.00' num_certificaciones = 2 )
*    ).
*
*    DATA lt_candidatos TYPE STANDARD TABLE OF REF TO zcl_candidato_20 WITH DEFAULT KEY.
*
*    LOOP AT lt_init_data INTO DATA(ls_init).
*      IF ls_init-es_interno = abap_true.
*        lt_candidatos = VALUE #( BASE lt_candidatos
*          ( NEW zcl_candidato_interno_20(
*              i_id                 = ls_init-id
*              i_nombre             = ls_init-nombre
*              i_experiencia        = ls_init-experiencia
*              iv_dni               = ls_init-dni
*              i_telefono           = ls_init-telefono
*              i_salario_actual     = ls_init-salario_actual
*              i_salario_pretendido = ls_init-salario_pretendido ) ) ).
*      ELSE.
*        lt_candidatos = VALUE #( BASE lt_candidatos
*          ( NEW zcl_candidato_externo_20(
*              i_id                 = ls_init-id
*              i_nombre             = ls_init-nombre
*              i_experiencia        = ls_init-experiencia
*              iv_dni               = ls_init-dni
*              i_telefono           = ls_init-telefono
*              i_salario_actual     = ls_init-salario_actual
*              i_salario_pretendido = ls_init-salario_pretendido
*              i_certificaciones    = ls_init-num_certificaciones ) ) ).
*      ENDIF.
*    ENDLOOP.
*
*    out->write( '=== 1. EVALUACIÓN INICIAL POLIMÓRFICA ===' ).
*    LOOP AT lt_candidatos INTO DATA(lo_candidato).
*      out->write( |Candidato: { lo_candidato->nombre_completo } | &&
*                  |Idoneidad Base: { lo_candidato->calcular_idoneidad( ) }| ).
*    ENDLOOP.
*
*    lt_candidatos[ 1 ]->anadir_puntos_entrevista( 15 ).
*    lt_candidatos[ 3 ]->anadir_puntos_entrevista( 10 ).
*
*    out->write( |\n=== 2. COMPARACIÓN DIRECTA ===| ).
*    DATA(lv_ganador) = lt_candidatos[ 1 ]->comparar_con( lt_candidatos[ 3 ] ).
*    out->write( |Ganador entre { lt_candidatos[ 1 ]->nombre_completo } y { lt_candidatos[ 3 ]->nombre_completo }: { lv_ganador }| ).
*
*    DATA lt_completos TYPE tt_candidatos_completos.
*
*    LOOP AT lt_candidatos INTO lo_candidato.
*      lt_completos = VALUE #( BASE lt_completos
*        ( id                 = lo_candidato->id
*          nombre_completo    = lo_candidato->nombre_completo
*          anios_experiencia  = lo_candidato->anios_experiencia
*          dni                = lo_candidato->dni
*          telefono_personal = lo_candidato->telefono_personal
*          salario_actual     = lo_candidato->salario_actual
*          salario_pretendido = lo_candidato->salario_pretendido
*          idoneidad          = lo_candidato->obtener_idoneidad_final( )
*          banda_salarial     = lo_candidato->calcular_banda_salarial( ) ) ).
*    ENDLOOP.
*
*    DATA(lt_ranking_rrhh) = CORRESPONDING tt_fichas_candidatos( lt_completos
*      MAPPING nombre      = nombre_completo
*              experiencia = anios_experiencia
*       ).
*
*    SORT lt_ranking_rrhh BY idoneidad DESCENDING.
*
*    out->write( |\n=== 3. RANKING FINAL RRHH (DATOS SEGUROS) ===| ).
*    out->write( lt_ranking_rrhh ).
*
*    " ----------------------------------------------------------------------
*    " BLOQUE DE VERIFICACIONES DE PRUEBA
*    " ----------------------------------------------------------------------
*    out->write( |\n=== 4. VERIFICACIONES DE PRUEBA ===| ).
*
*    DATA(lo_cand_t1) = NEW zcl_candidato_interno_20( i_id = 99 i_nombre = 'T1' i_experiencia = 8 iv_dni = '' i_telefono = '' i_salario_actual = 0 i_salario_pretendido = 0 ).
*    DATA(lv_res_t1) = lo_cand_t1->calcular_idoneidad( ).
*    DATA(lv_esp_t1) = CONV decfloat34( '6.8' ).
*    out->write( |Idoneidad candidato interno -> Esperado: { lv_esp_t1 } | &&
*                |Obtenido: { lv_res_t1 } | &&
*                |Status: { COND string( WHEN lv_res_t1 = lv_esp_t1 THEN 'OK' ELSE 'ERROR' ) }| ).
*
*    DATA(lo_cand_t2) = NEW zcl_candidato_externo_20( i_id = 98 i_nombre = 'T2' i_experiencia = 3 iv_dni = '' i_telefono = '' i_salario_actual = 0 i_salario_pretendido = 0 i_certificaciones = 4 ).
*    DATA(lv_res_t2) = lo_cand_t2->calcular_idoneidad( ).
*    DATA(lv_esp_t2) = CONV decfloat34( '6.9' ).
*    out->write( |Idoneidad candidato externo -> Esperado: { lv_esp_t2 } | &&
*                |Obtenido: { lv_res_t2 } | &&
*                |Status: { COND string( WHEN lv_res_t2 = lv_esp_t2 THEN 'OK' ELSE 'ERROR' ) }| ).
*
*    DATA(lo_cand_t3) = NEW zcl_candidato_interno_20( i_id = 97 i_nombre = 'T3' i_experiencia = 20 iv_dni = '' i_telefono = '' i_salario_actual = 0 i_salario_pretendido = 0 ).
*    DATA(lv_res_t3) = lo_cand_t3->calcular_idoneidad( ).
*    DATA(lv_esp_t3) = CONV decfloat34( 10 ).
*    out->write( |Tope máximo (interno) -> Esperado: { lv_esp_t3 } | &&
*                |Obtenido: { lv_res_t3 } | &&
*                |Status: { COND string( WHEN lv_res_t3 = lv_esp_t3 THEN 'OK' ELSE 'ERROR' ) }| ).
*
*    DATA(lo_cand_t4) = NEW zcl_candidato_externo_20( i_id = 96 i_nombre = 'T4' i_experiencia = 1 iv_dni = '' i_telefono = '' i_salario_actual = 0 i_salario_pretendido = 0 i_certificaciones = 0 ).
*    lo_cand_t4->anadir_puntos_entrevista( 73 ).
*    lo_cand_t4->anadir_puntos_entrevista( 15 ).
*    DATA(lv_res_t4) = lo_cand_t4->obtener_idoneidad_final( ).
*    DATA(lv_esp_t4) = 9.
*    out->write( |Idoneidad final con entrevista -> Esperado: { lv_esp_t4 } | &&
*                |Obtenido: { lv_res_t4 } | &&
*                |Status: { COND string( WHEN lv_res_t4 = lv_esp_t4 THEN 'OK' ELSE 'ERROR' ) }| ).
*
*    DATA(lo_cand_t5) = NEW zcl_candidato_20( i_id = 95 i_nombre = 'T5' i_experiencia = 0 iv_dni = '' i_telefono = '' i_salario_actual = 0 i_salario_pretendido = 27500 ).
*    DATA(lv_res_t5) = lo_cand_t5->calcular_banda_salarial( ).
*    DATA(lv_esp_t5) = '25000 - 30000'.
*    out->write( |Banda salarial -> Esperado: { lv_esp_t5 } | &&
*                |Obtenido: '{ lv_res_t5 }' | &&
*                |Status: { COND string( WHEN lv_res_t5 = lv_esp_t5 THEN 'OK' ELSE 'ERROR' ) }| ).
*
*    DATA(lo_cand_t6) = NEW zcl_candidato_20( i_id = 94 i_nombre = 'T6' i_experiencia = 0 iv_dni = '' i_telefono = '' i_salario_actual = 0 i_salario_pretendido = 30000 ).
*    DATA(lv_res_t6) = lo_cand_t6->calcular_banda_salarial( ).
*    DATA(lv_esp_t6) = '30000 - 35000'.
*    out->write( |Banda salarial (múltiplo exacto) -> Esperado: { lv_esp_t6 } | &&
*                |Obtenido: '{ lv_res_t6 }' | &&
*                |Status: { COND string( WHEN lv_res_t6 = lv_esp_t6 THEN 'OK' ELSE 'ERROR' ) }| ).
*
*    DATA(lo_cand_comp1) = NEW zcl_candidato_interno_20( i_id = 91 i_nombre = 'Candidato A' i_experiencia = 10 iv_dni = '' i_telefono = '' i_salario_actual = 0 i_salario_pretendido = 0 ).
*    DATA(lo_cand_comp2) = NEW zcl_candidato_interno_20( i_id = 92 i_nombre = 'Candidato B' i_experiencia = 2 iv_dni = '' i_telefono = '' i_salario_actual = 0 i_salario_pretendido = 0 ).
*    DATA(lv_res_t7) = lo_cand_comp1->comparar_con( lo_cand_comp2 ).
*    DATA(lv_esp_t7) = 'Candidato A'.
*    out->write( |Comparación de candidatos -> Esperado: { lv_esp_t7 } | &&
*                |Obtenido: '{ lv_res_t7 }' | &&
*                |Status: { COND string( WHEN lv_res_t7 = lv_esp_t7 THEN 'OK' ELSE 'ERROR' ) }| ).
*    TYPES: BEGIN OF ty_candidato,
*             id          TYPE i,
*             nombre      TYPE string,
*             experiencia TYPE i,
*             salario     TYPE i,
*             ciudad      TYPE string,
*           END OF ty_candidato,
*           tt_candidatos TYPE STANDARD TABLE OF ty_candidato WITH DEFAULT KEY.
*    DATA(ls_candidato) = VALUE ty_candidato(
*      id          = 1
*      nombre      = 'Ana'
*      experiencia = 4
*      salario     = 28000
*      ciudad      = 'Sevilla'
*    ).
*
*    DATA(ls_candidato_actualizado) = VALUE ty_candidato(
*      BASE ls_candidato
*      experiencia = 5
*      salario     = 30000
*    ).
*
*    out->write( '=== ESTRUCTURA ORIGINAL ===' ).
*    out->write( ls_candidato ).
*
*    out->write( '=== ESTRUCTURA ACTUALIZADA (CON BASE) ===' ).
*    out->write( ls_candidato_actualizado ).
*
*    DATA(lt_candidatos) = VALUE tt_candidatos(
*      ( id = 1 nombre = 'Ana'  experiencia = 4 salario = 28000 ciudad = 'Sevilla' )
*      ( id = 2 nombre = 'Luis' experiencia = 2 salario = 24000 ciudad = 'Málaga' )
*    ).
*
*    DATA(lt_candidatos_ampliada) = VALUE tt_candidatos(
*      BASE lt_candidatos
*      ( id = 3 nombre = 'Carlos' experiencia = 6 salario = 32000 ciudad = 'Granada' )
*    ).
*
*    out->write( |\n=== TABLA INICIAL ===| ).
*    out->write( lt_candidatos ).
*
*    out->write( '=== TABLA AMPLIADA ===' ).
*    out->write( lt_candidatos_ampliada ).
*
*    TYPES: BEGIN OF ty_producto,
*             id     TYPE i,
*             nombre TYPE string,
*             precio TYPE p LENGTH 8 DECIMALS 2,
*             stock  TYPE i,
*           END OF ty_producto,
*           tt_productos TYPE STANDARD TABLE OF ty_producto WITH DEFAULT KEY.
*
*    DATA(lt_productos) = VALUE tt_productos(
*      ( id = 1 nombre = 'Monitor' precio = 250 stock = 10 )
*      ( id = 2 nombre = 'Teclado' precio = 50  stock = 20 )
*      ( id = 3 nombre = 'Ratón'   precio = 25  stock = 30 )
*      ( id = 4 nombre = 'Webcam'  precio = 80  stock = 15 )
*    ).
*
*    DATA(ls_producto_2) = lt_productos[ id = 2 ].
*
*    DATA(lv_nombre_3) = lt_productos[ id = 3 ]-nombre.
*
*    DATA(lv_precio_1) = lt_productos[ id = 1 ]-precio.
*
*    DATA(ls_fila_4) = lt_productos[ 4 ].
*
*    out->write( '=== PRODUCTO CON ID 2===' ).
*    out->write( ls_producto_2 ).
*
*    out->write( |\n=== NOMBRE DEL PRODUCTO CON ID 3 ===\n{ lv_nombre_3 }| ).
*
*    out->write( |\n=== PRECIO DEL PRODUCTO CON ID 1 ===\n{ lv_precio_1 } €| ).
*
*    out->write( |\n=== CUARTA FILA POR ÍNDICE ===| ).
*    out->write( ls_fila_4 ).
*
*
*    DATA(ls_producto_99) = VALUE #( lt_productos[ id = 99 ] OPTIONAL ).
*
*    out->write( |\n=== RETO: BÚSQUEDA ID 99===| ).
*    out->write( ls_producto_99 ).
*
*    TYPES: BEGIN OF ty_producto,
*             id     TYPE i,
*             nombre TYPE string,
*             precio TYPE p LENGTH 8 DECIMALS 2,
*           END OF ty_producto,
*           tt_productos TYPE STANDARD TABLE OF ty_producto WITH DEFAULT KEY.
*
*    DATA(lt_productos) = VALUE tt_productos(
*      ( id = 1 nombre = 'Monitor' precio = 250 )
*      ( id = 2 nombre = 'Teclado' precio = 50 )
*      ( id = 3 nombre = 'Ratón'   precio = 25 )
*    ).
*
*    out->write( '=== 1. MANEJO CON TRY / CATCH ===' ).
*    TRY.
*        DATA(ls_prod_1) = lt_productos[ id = 99 ].
*        out->write( ls_prod_1 ).
*      CATCH cx_sy_itab_line_not_found.
*        out->write( 'Excepción capturada: El producto con ID 99 no existe.' ).
*    ENDTRY.
*
*    out->write( |\n=== 2. MANEJO CON line_exists( ) ===| ).
*    IF line_exists( lt_productos[ id = 99 ] ).
*      DATA(ls_prod_2) = lt_productos[ id = 99 ].
*      out->write( ls_prod_2 ).
*    ELSE.
*      out->write( 'Comprobación previa: La línea no existe en la tabla.' ).
*    ENDIF.
*
*    out->write( |\n=== 3. MANEJO CON OPTIONAL ===| ).
*    DATA(ls_prod_3) = VALUE #( lt_productos[ id = 99 ] OPTIONAL ).
*    out->write( ls_prod_3 ).
*
*    out->write( |\n=== 4. MANEJO CON DEFAULT ===| ).
*    DATA(ls_prod_4) = VALUE ty_producto( lt_productos[ id = 99 ]
*                        DEFAULT VALUE #( id = 0 nombre = 'Producto no encontrado' precio = 0 ) ).
*    out->write( ls_prod_4 ).
*
*    TYPES: BEGIN OF ty_candidato,
*             id         TYPE i,
*             nombre     TYPE string,
*             puntuacion TYPE i,
*           END OF ty_candidato,
*           tt_candidatos TYPE STANDARD TABLE OF ty_candidato WITH DEFAULT KEY.
*
*    DATA(lt_candidatos) = VALUE tt_candidatos(
*      ( id = 10 nombre = 'Ana'    puntuacion = 7 )
*      ( id = 20 nombre = 'Carlos' puntuacion = 5 )
*      ( id = 30 nombre = 'Marta'  puntuacion = 9 )
*      ( id = 40 nombre = 'Juan'   puntuacion = 8 )
*    ).
*
*
*
*    DATA(lv_posicion_30) = line_index( lt_candidatos[ id = 30 ] ).
*
*    out->write( '=== 1. BUSCAR CANDIDATO EXISTENTE (ID = 30) ===' ).
*    out->write( |El candidato con ID 30 se encuentra en la posición: { lv_posicion_30 }| ).
*
*    DATA(lv_posicion_99) = line_index( lt_candidatos[ id = 99 ] ).
*
*    out->write( |\n=== 2. BUSCAR CANDIDATO INEXISTENTE (ID = 99) ===| ).
*    IF lv_posicion_99 > 0.
*      out->write( |El candidato se encuentra en la posición: { lv_posicion_99 }| ).
*    ELSE.
*      out->write( 'Candidato no encontrado' ).
*    ENDIF.
*
*    TYPES: BEGIN OF ty_candidato,
*             id         TYPE i,
*             nombre     TYPE string,
*             puntuacion TYPE i,
*           END OF ty_candidato,
*           tt_candidatos TYPE STANDARD TABLE OF ty_candidato WITH DEFAULT KEY.
*
*    TYPES: BEGIN OF ty_seleccionado,
*             nombre     TYPE string,
*             puntuacion TYPE i,
*           END OF ty_seleccionado,
*           tt_seleccionados TYPE STANDARD TABLE OF ty_seleccionado WITH DEFAULT KEY.
*
*    DATA(lt_candidatos) = VALUE tt_candidatos(
*      ( id = 1 nombre = 'Ana'   puntuacion = 8 )
*      ( id = 2 nombre = 'Carlos' puntuacion = 5 )
*      ( id = 3 nombre = 'Marta'  puntuacion = 9 )
*      ( id = 4 nombre = 'Juan'   puntuacion = 6 )
*      ( id = 5 nombre = 'Lucía'  puntuacion = 10 )
*    ).
*
*    DATA(lt_seleccionados) = VALUE tt_seleccionados(
*      FOR ls_cand IN lt_candidatos WHERE ( puntuacion >= 8 )
**      ( nombre     = ls_cand-nombre
**       puntuacion = ls_cand-puntuacion )
*( CORRESPONDING #( ls_cand  ) )
*    ).
*
*    out->write( '=== CANDIDATOS SELECCIONADOS (PUNTUACIÓN >= 8) ===' ).
*    out->write( lt_seleccionados ).
*
*    TYPES: BEGIN OF ty_candidato,
*             id         TYPE i,
*             nombre     TYPE string,
*             puntuacion TYPE i,
*           END OF ty_candidato.
*
*    TYPES tt_candidatos_sorted TYPE SORTED TABLE OF ty_candidato
*      WITH NON-UNIQUE KEY puntuacion.
*
*    TYPES: BEGIN OF ty_filtro_puntuacion,
*             puntuacion TYPE i,
*           END OF ty_filtro_puntuacion,
*           tt_filtro_puntuacion TYPE HASHED TABLE OF ty_filtro_puntuacion
*             WITH UNIQUE KEY puntuacion.
*
*    DATA(lt_candidatos) = VALUE tt_candidatos_sorted(
*      ( id = 1 nombre = 'Ana'    puntuacion = 8 )
*      ( id = 2 nombre = 'Carlos' puntuacion = 5 )
*      ( id = 3 nombre = 'Marta'  puntuacion = 9 )
*      ( id = 4 nombre = 'Juan'   puntuacion = 6 )
*      ( id = 5 nombre = 'Lucía'  puntuacion = 10 )
*    ).
*
*    DATA(lt_puntuaciones_altas) = VALUE tt_filtro_puntuacion(
*      ( puntuacion = 8 )
*      ( puntuacion = 9 )
*      ( puntuacion = 10 )
*    ).
*
*
*    DATA(lt_seleccionados) = FILTER #(
*      lt_candidatos IN lt_puntuaciones_altas
*      WHERE puntuacion = puntuacion
*    ).
*
*    out->write( '=== CANDIDATOS SELECCIONADOS (PUNTUACIÓN >= 8) ===' ).
*    out->write( lt_seleccionados ).
*
*    DATA(lt_descartados) = FILTER #(
*      lt_candidatos EXCEPT IN lt_puntuaciones_altas
*      WHERE puntuacion = puntuacion
*    ).
*
*    out->write( |\n=== RETO: CANDIDATOS DESCARTADOS (EXCEPT WHERE -> PUNTUACIÓN < 8) ===| ).
*    out->write( lt_descartados ).
*
*    TYPES: BEGIN OF ty_candidato,
*             id         TYPE i,
*             nombre     TYPE string,
*             puntuacion TYPE i,
*           END OF ty_candidato,
*           tt_candidatos TYPE STANDARD TABLE OF ty_candidato WITH DEFAULT KEY.
*
*    DATA(lt_candidatos) = VALUE tt_candidatos(
*      ( id = 1 nombre = 'Ana'    puntuacion = 8 )
*      ( id = 2 nombre = 'Carlos' puntuacion = 5 )
*      ( id = 3 nombre = 'Marta'  puntuacion = 9 )
*      ( id = 4 nombre = 'Juan'   puntuacion = 6 )
*      ( id = 5 nombre = 'Lucía'  puntuacion = 10 )
*    ).
*
*    DATA(lv_suma_total) = REDUCE i(
*      INIT suma = 0
*      FOR ls_cand IN lt_candidatos
*      NEXT suma = suma + ls_cand-puntuacion
*    ).
*
*    out->write( '=== 1. SUMA TOTAL DE PUNTUACIONES ===' ).
*    out->write( |La suma total de puntuaciones es: { lv_suma_total }| ).
*
*    DATA(lv_suma_altas) = REDUCE i(
*      INIT suma = 0
*      FOR ls_cand IN lt_candidatos WHERE ( puntuacion >= 8 )
*      NEXT suma = suma + ls_cand-puntuacion
*    ).
*
*    out->write( |\n=== 2. RETO: SUMA DE PUNTUACIONES ALTAS (>= 8) ===| ).
*    out->write( |La suma de puntuaciones altas es: { lv_suma_altas }| ).

*    TYPES: BEGIN OF ty_candidato,
*             id         TYPE i,
*             nombre     TYPE string,
*             puntuacion TYPE i,
*           END OF ty_candidato,
*           tt_candidatos TYPE STANDARD TABLE OF ty_candidato WITH DEFAULT KEY.
*
*    DATA(ls_candidato) = VALUE ty_candidato(
*      id         = 1
*      nombre     = 'Ana'
*      puntuacion = 7
*    ).
*
*    DATA(lr_candidato) = REF #( ls_candidato ).
*
*    lr_candidato->puntuacion = 9.
*
*    out->write( '=== 1. ESTRUCTURA ORIGINAL TRAS MODIFICAR VÍA REF ===' ).
*    out->write( ls_candidato ).
*
*    DATA(lt_candidatos) = VALUE tt_candidatos(
*      ( id = 1 nombre = 'Ana'    puntuacion = 7 )
*      ( id = 2 nombre = 'Carlos' puntuacion = 5 )
*      ( id = 3 nombre = 'Marta'  puntuacion = 9 )
*    ).
*
*    DATA(lr_candidato_2) = REF #( lt_candidatos[ id = 2 ] ).
*
*    lr_candidato_2->puntuacion = 10.
*
*    out->write( |\n=== 2. TABLA INTERNA COMPLETA TRAS MODIFICAR ID = 2 VÍA REF ===| ).
*    out->write( lt_candidatos ).

    DATA(lv_edad)        = 28.
    DATA(lv_experiencia) = 4.
    DATA(lv_puntuacion)  = 8.

    DATA(lv_apto) = xsdbool( lv_edad >= 18
                            AND lv_experiencia >= 3
                            AND lv_puntuacion >= 7 ).

    out->write( '=== EVALUACIÓN DE CANDIDATO ===' ).
    out->write( |¿El candidato es apto?: { lv_apto }| ).
  ENDMETHOD.

ENDCLASS.
