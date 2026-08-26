@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Root View Entity - Penaltis'
define root view entity ZR_PENALTIS_20
  as select from zpenaltis_20

  // Asociaciones para la ayuda de valores y mapeo de textos
  association [0..1] to ZI_DIRECCION_VH_20 as _DirDisparoVH 
    on  $projection.DirDisparo = _DirDisparoVH.Direccion
    and _DirDisparoVH.language = $session.system_language

  association [0..1] to ZI_DIRECCION_VH_20 as _DirPorteroVH 
    on  $projection.DirPortero = _DirPorteroVH.Direccion
    and _DirPorteroVH.language = $session.system_language
{
  key num_lanzamiento       as NumLanzamiento,
      lanzador              as Lanzador,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DIRECCION_VH_20', element: 'Direccion' } }]
      @ObjectModel.text.element: ['DirDisparoText']
      dir_disparo           as DirDisparo,
      _DirDisparoVH.Text    as DirDisparoText,

      portero               as Portero,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DIRECCION_VH_20', element: 'Direccion' } }]
      @ObjectModel.text.element: ['DirPorteroText']
      dir_portero           as DirPortero,
      _DirPorteroVH.Text    as DirPorteroText,

      resultado             as Resultado,

      // Campos de auditoría
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,

      // Exposición de asociaciones
      _DirDisparoVH,
      _DirPorteroVH
}
