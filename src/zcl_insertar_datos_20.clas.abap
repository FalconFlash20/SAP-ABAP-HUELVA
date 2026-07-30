CLASS zcl_insertar_datos_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insertar_datos_20 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*  DATA: ls_alumno TYPE zalumnos_20.
*
*    ls_alumno-id_curso = 'CURSO1'.
*    ls_alumno-dni      = '12345678A'.
*    ls_alumno-nombre   = 'Carlos García'.
*    ls_alumno-edad     = 22.
*    ls_alumno-nivel    = 'IN'.
*
*    INSERT zalumnos_20 FROM @ls_alumno.
*
*    IF sy-subrc = 0.
*      out->write( '¡Alumno insertado con éxito!' ).
*    ELSE.
*      out->write( 'Error: El alumno ya existe en la base de datos.' ).
*    ENDIF.


    DATA: ls_taqueria TYPE ztaquerias_20,
          lv_contador TYPE i.
*    " 1. CREATE: Insertando taquerias
*    out->write( '--- 1. CREATE: Insertando taquerías...' ).
*    " Taquería 1
*    ls_taqueria-id_taqueria   = 'TAQ001'.
*    ls_taqueria-nombre        = 'El Pastor de Jalisco'.
*    ls_taqueria-estado        = 'JA'.
*    ls_taqueria-especialidad  = 'PA'.
*    ls_taqueria-nivel_picante = 3.
*    ls_taqueria-precio_taco   = '15.00'.
*    INSERT ztaquerias_20 FROM @ls_taqueria.
*    IF sy-subrc = 0.
*      out->write( 'TAQ001 insertada con éxito.' ).
*    ELSE.
*      out->write( 'Error al insertar TAQ001.' ).
*    ENDIF.
*
*    " Taquería 2
*    ls_taqueria-id_taqueria   = 'TAQ002'.
*    ls_taqueria-nombre        = 'Barbacoa Doña Yuya'.
*    ls_taqueria-estado        = 'OA'.
*    ls_taqueria-especialidad  = 'BA'.
*    ls_taqueria-nivel_picante = 4.
*    ls_taqueria-precio_taco   = '20.00'.
*    INSERT ztaquerias_20 FROM @ls_taqueria.
*    IF sy-subrc = 0.
*      out->write( 'TAQ002 insertada con éxito.' ).
*    ENDIF.
*
*    " Taquería 3
*    ls_taqueria-id_taqueria   = 'TAQ003'.
*    ls_taqueria-nombre        = 'Cochinita Pibil Express'.
*    ls_taqueria-estado        = 'YU'.
*    ls_taqueria-especialidad  = 'CO'.
*    ls_taqueria-nivel_picante = 2.
*    ls_taqueria-precio_taco   = '18.00'.
*    INSERT ztaquerias_20 FROM @ls_taqueria.
*    IF sy-subrc = 0.
*      out->write( 'TAQ003 insertada con éxito.' ).
*    ENDIF.
*    out->write( space ).

    "  2. CREATE (ERROR): Clave duplicada
*    out->write( '--- 2. CREATE (ERROR): Clave duplicada ---' ).
*
*    ls_taqueria-id_taqueria   = 'TAQ001'.
*    ls_taqueria-nombre        = 'Intento Duplicado'.
*    ls_taqueria-estado        = 'JA'.
*    ls_taqueria-especialidad  = 'PA'.
*    ls_taqueria-nivel_picante = 3.
*    ls_taqueria-precio_taco   = '15.00'.
*
*    INSERT ztaquerias_20 FROM @ls_taqueria.
*    IF sy-subrc = 0.
*      out->write( 'TAQ001 insertada con éxito.' ).
*    ELSE.
*      out->write( 'Error al insertar TAQ001.' ).
*    ENDIF.
    out->write( space ).

*    " 3. Leer taqueria por su ID
*    SELECT SINGLE *
*      FROM ztaquerias_20
*      WHERE id_taqueria = 'TAQ002'
*      INTO @ls_taqueria.
*
*    IF sy-subrc = 0.
*      out->write( |Encontrada: { ls_taqueria-nombre } ({ ls_taqueria-estado }) - Taco: { ls_taqueria-precio_taco } MXN| ).
*    ELSE.
*      out->write( 'No se ha encontrado la taquería TAQ002.' ).
*    ENDIF.
*    out->write( space ).
*
*    " 4. Leer taqueria inexistente por su ID
*    SELECT SINGLE *
*      FROM ztaquerias_20
*      WHERE id_taqueria = 'TAQ004'
*      INTO @ls_taqueria.
*
*    IF sy-subrc = 0.
*      out->write( |Encontrada: { ls_taqueria-nombre } ({ ls_taqueria-estado }) - Taco: { ls_taqueria-precio_taco } MXN| ).
*    ELSE.
*      out->write( 'No se ha encontrado la taquería TAQ004.' ).
*    ENDIF.
*    out->write( space ).
*
*    " 5. Listar taquerias por estado
*    SELECT *
*      FROM ztaquerias_20
*      WHERE estado = 'JA'
*      INTO TABLE @DATA(lt_taquerias).
*
*    IF sy-subrc = 0.
*      out->write( 'Taquerías de Jalisco:' ).
*      LOOP AT lt_taquerias INTO ls_taqueria.
*        out->write( | - { ls_taqueria-nombre } (Especialidad: { ls_taqueria-especialidad })| ).
*      ENDLOOP.
*      out->write( space ).
*    ELSE.
*      out->write( 'No se han encontrado taquerías en Jalisco.' ).
*    ENDIF.
*    out->write( space ).
*
*    " 6. Actualizar precio
*    SELECT SINGLE *
*      FROM ztaquerias_20
*      WHERE id_taqueria = 'TAQ002'
*      INTO @ls_taqueria.
*
*    IF sy-subrc = 0.
*      ls_taqueria-precio_taco = '25.00'.
*      UPDATE ztaquerias_20 FROM @ls_taqueria.
*      IF sy-subrc = 0.
*        out->write( 'Precio actualizado.' ).
*      ELSE.
*        out->write( 'Error al actualizar el precio.' ).
*      ENDIF.
*    ELSE.
*      out->write( 'No se ha encontrado la taquería TAQ002.' ).
*    ENDIF.
*    out->write( space ).
*
*    " 7. Update sobre taqueria inexistente
*    SELECT SINGLE *
*      FROM ztaquerias_20
*      WHERE id_taqueria = 'TAQ004'
*      INTO @ls_taqueria.
*
*    IF sy-subrc = 0.
*      ls_taqueria-precio_taco = '25.00'.
*      UPDATE ztaquerias_20 FROM @ls_taqueria.
*      IF sy-subrc = 0.
*        out->write( 'Precio actualizado.' ).
*      ELSE.
*        out->write( 'Error al actualizar el precio.' ).
*      ENDIF.
*    ELSE.
*      out->write( 'No se ha encontrado la taquería TAQ004.' ).
*    ENDIF.
*    out->write( space ).
*
*" 8. Eliminar una taqueria
*    SELECT SINGLE *
*      FROM ztaquerias_20
*      WHERE id_taqueria = 'TAQ003'
*      INTO @ls_taqueria.
*
*    IF sy-subrc = 0.
*      DELETE ztaquerias_20 FROM @ls_taqueria.
*      IF sy-subrc = 0.
*        out->write( 'Taquería eliminada.' ).
*      ELSE.
*        out->write( 'Error al eliminar la taquería.' ).
*      ENDIF.
*    ELSE.
*      out->write( 'No se ha encontrado la taquería TAQ003.' ).
*    ENDIF.
*    out->write( space )
*
*" 9. Recuento final de taquerias
*.SELECT COUNT(*)
*      FROM ztaquerias_20
*      INTO @lv_contador.
*
*    out->write( |El número total de taquerías restantes en la base de datos es: { lv_contador }| ).


    DATA: ls_bodega  TYPE zbodegas_20,
          lt_bodegas TYPE  TABLE OF zbodegas_20.

*    ls_bodega-id_bodega      = 'BOD001'.
*    ls_bodega-nombre_bod         = 'Bodegas Marqués de Rioja'.
*    ls_bodega-denominacion   = 'RI'.
*    ls_bodega-tipo_vino      = 'TI'.
*    ls_bodega-anyo_fundacion = 1902.
*    ls_bodega-precio_botella = '12.50'.
*    ls_bodega-moneda = '€'.
*    INSERT zbodegas_20 FROM @ls_bodega.
*    IF sy-subrc = 0.
*      out->write( |Bodega { ls_bodega-nombre_bod } insertada con exito.| ).
*    ENDIF.
*
*    ls_bodega-id_bodega      = 'BOD002'.
*    ls_bodega-nombre_bod         = 'Pazo do Mar'.
*    ls_bodega-denominacion   = 'RS'.
*    ls_bodega-tipo_vino      = 'BL'.
*    ls_bodega-anyo_fundacion = 1978.
*    ls_bodega-precio_botella = '9.90'.
*    INSERT zbodegas_20 FROM @ls_bodega.
*    IF sy-subrc = 0.
*      out->write( |Bodega { ls_bodega-nombre_bod } insertada con exito.| ).
*    ENDIF.
*
*    INSERT zbodegas_20 FROM @( VALUE #(
*      client         = sy-mandt
*      id_bodega      = 'BOD003'
*      nombre_bod         = 'Finca Priorat Alta'
*      denominacion   = 'PR'
*      tipo_vino      = 'TI'
*      anyo_fundacion = 1995
*      precio_botella = '22.00'
*    ) ).
*    IF sy-subrc = 0.
*      out->write( |Bodega { ls_bodega-nombre_bod } insertada con exito.| ).
*    ENDIF.
*    out->write( space ).
*
*    select single *
*        from zbodegas_20
*        where id_bodega = 'BOD002'
*        into @ls_bodega.
*    if sy-subrc = 0.
*        out->write( |Encontrada:| ).
*        out->write( ls_bodega ).
*    else.
*        out->write( |No se ha encontrado la bodega con ID: { ls_bodega-id_bodega }| ).
*    endif.
*    out->write( space ).
*
*    SELECT *
*        from zbodegas_20
*        where denominacion = 'RI'
*        into table @lt_bodegas.
*    LOOP AT lt_bodegas into ls_bodega.
*    out->write( ls_bodega ).
*    ENDLOOP.
*    out->write( space ).
*
*    update zbodegas_20
*        set precio_botella = '30.50'
*        where  id_bodega = 'BOD003'.
*        if sy-subrc = 0.
*        out->write( 'Precio actualizado.' ).
*    else.
*        out->write( 'Error al actualizar el precio.' ).
*    endif.
*    out->write( space ).
*
*    delete from zbodegas_20 where id_bodega = 'BOD001'.
*    if sy-subrc = 0.
*        out->write( 'Bodega eliminada.' ).
*    else.
*        out->write( 'Error al eliminar la bodega.' ).
*    endif.
*    out->write( space ).
*
*    select count(*)
*        from zbodegas_20
*        into @lv_contador.
*
*    out->write( |El número total de bodegas restantes en la base de datos es: { lv_contador }| ).
*    out->write( space ).
*
*    clear lt_bodegas.
*    lt_bodegas = VALUE #(
*      ( id_bodega = 'BOD004' nombre_bod = 'Bodegas Rías Baixas' denominacion = 'RS' tipo_vino = 'BL' anyo_fundacion = 2010 precio_botella = '14.20' moneda = 'EUR' )
*      ( id_bodega = 'BOD005' nombre_bod = 'Tinto Fino Ribera'   denominacion = 'RI' tipo_vino = 'TI' anyo_fundacion = 2015 precio_botella = '18.90' moneda = 'EUR' )
*    ).
*    INSERT zbodegas_20 FROM TABLE @lt_bodegas.
*    IF sy-subrc = 0.
*      out->write( 'Bodegas insertadas con exito.' ).
*    ENDIF.
*    out->write( space ).
*    out->write( lt_bodegas ).
*
*    UPDATE zbodegas_20
*           SET moneda = '€'
*           WHERE  id_bodega = 'BOD003'.
*
*    UPDATE zbodegas_20
*SET moneda = '€'
*WHERE  id_bodega = 'BOD004'.
*    UPDATE zbodegas_20
*SET moneda = '€'
*WHERE  id_bodega = 'BOD005'.
  ENDMETHOD.
ENDCLASS.
