CLASS zcl_empleados_20 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES tt_empleados TYPE STANDARD TABLE OF ztab_usuario_20 WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        iv_nombre          TYPE zde_nombre_20
        iv_apellido        TYPE zde_apellido_20
        iv_telefono        TYPE zde_telefono_20
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i.
    METHODS calcular_sueldo
      RETURNING VALUE(rv_sueldo) TYPE zde_sueldo_20.
    METHODS generar_id
      RETURNING VALUE(rv_id) TYPE zde_id_empleado_20.
    METHODS alta_empleado
      RETURNING VALUE(rv_mensaje) TYPE string.
    METHODS modificar_empleado
      IMPORTING
        iv_id              TYPE zde_id_empleado_20
        iv_nombre          TYPE zde_nombre_20
        iv_apellido        TYPE zde_apellido_20
        iv_telefono        TYPE zde_telefono_20
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i
      RETURNING VALUE(rv_mensaje) TYPE string.
    METHODS consultar_empleados
      IMPORTING iv_id            TYPE zde_id_empleado_20 DEFAULT 0
      RETURNING VALUE(rt_empleados) TYPE tt_empleados.
    METHODS consultar_n_registros
      IMPORTING iv_num           TYPE i
      RETURNING VALUE(rt_empleados) TYPE tt_empleados.
  PRIVATE SECTION.
    DATA mv_nombre          TYPE zde_nombre_20.
    DATA mv_apellido        TYPE zde_apellido_20.
    DATA mv_telefono        TYPE zde_telefono_20.
    DATA mv_experiencia     TYPE i.
    DATA mv_certificaciones TYPE i.
ENDCLASS.


CLASS zcl_empleados_20 IMPLEMENTATION.

  METHOD constructor.
    mv_nombre          = iv_nombre.
    mv_apellido        = iv_apellido.
    mv_telefono        = iv_telefono.
    mv_experiencia     = iv_experiencia.
    mv_certificaciones = iv_certificaciones.
  ENDMETHOD.

  METHOD calcular_sueldo.
    rv_sueldo = 1000
              + ( mv_certificaciones * 50 )
              + ( mv_experiencia * 100 ).
  ENDMETHOD.

  METHOD generar_id.
    SELECT SINGLE FROM ztab_usuario_20
      FIELDS MAX( id_empleado ) AS max_id
      INTO @DATA(lv_max_id).
    rv_id = lv_max_id + 1.
  ENDMETHOD.

  METHOD alta_empleado.
    DATA ls_empleado TYPE ztab_usuario_20.
    ls_empleado-id_empleado = generar_id( ).
    ls_empleado-nombre      = mv_nombre.
    ls_empleado-apellido    = mv_apellido.
    ls_empleado-telefono    = mv_telefono.
    ls_empleado-sueldo      = calcular_sueldo( ).
    INSERT ztab_usuario_20 FROM @ls_empleado.
    IF sy-subrc = 0.
      rv_mensaje = |OK: empleado { ls_empleado-id_empleado } | &&
                   |({ ls_empleado-nombre } { ls_empleado-apellido }) | &&
                   |dado de alta con sueldo { ls_empleado-sueldo }.|.
    ELSE.
      rv_mensaje = |ERROR: no se ha podido dar de alta al empleado.|.
    ENDIF.
  ENDMETHOD.

  METHOD modificar_empleado.
    SELECT SINGLE FROM ztab_usuario_20
      FIELDS id_empleado
      WHERE id_empleado = @iv_id
      INTO @DATA(lv_id).
    IF sy-subrc <> 0.
      rv_mensaje = |ERROR: el empleado { iv_id } no existe. | &&
                   |No se modifica ni se crea ningun registro.|.
      RETURN.
    ENDIF.
    mv_nombre          = iv_nombre.
    mv_apellido        = iv_apellido.
    mv_telefono        = iv_telefono.
    mv_experiencia     = iv_experiencia.
    mv_certificaciones = iv_certificaciones.
    DATA(lv_sueldo) = calcular_sueldo( ).
    UPDATE ztab_usuario_20
      SET nombre   = @mv_nombre,
          apellido = @mv_apellido,
          telefono = @mv_telefono,
          sueldo   = @lv_sueldo
      WHERE id_empleado = @iv_id.
    IF sy-subrc = 0.
      rv_mensaje = |OK: empleado { iv_id } modificado. | &&
                   |Nuevo sueldo: { lv_sueldo }.|.
    ELSE.
      rv_mensaje = |ERROR: no se ha podido modificar el empleado { iv_id }.|.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_empleados.
    IF iv_id = 0.
      SELECT FROM ztab_usuario_20
        FIELDS *
        ORDER BY id_empleado
        INTO TABLE @rt_empleados.
    ELSE.
      SELECT FROM ztab_usuario_20
        FIELDS *
        WHERE id_empleado = @iv_id
        INTO TABLE @rt_empleados.
    ENDIF.

  ENDMETHOD.

  METHOD consultar_n_registros.
    IF iv_num <= 0.
      RETURN.
    ENDIF.
    SELECT FROM ztab_usuario_20
      FIELDS *
      ORDER BY id_empleado
      INTO TABLE @rt_empleados
      UP TO @iv_num ROWS.
  ENDMETHOD.
ENDCLASS.
