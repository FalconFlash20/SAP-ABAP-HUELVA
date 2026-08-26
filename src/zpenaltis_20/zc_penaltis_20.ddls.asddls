@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View - Penaltis'
@Metadata.allowExtensions: true

define root view entity ZC_PENALTIS_20
  provider contract transactional_query
  as projection on ZR_PENALTIS_20
{
  key NumLanzamiento,
      Lanzador,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DIRECCION_VH_20', element: 'Direccion' } }]
      @ObjectModel.text.element: ['DirDisparoText']
      @UI.textArrangement: #TEXT_ONLY
      DirDisparo,
      DirDisparoText,

      Portero,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DIRECCION_VH_20', element: 'Direccion' } }]
      @ObjectModel.text.element: ['DirPorteroText']
      @UI.textArrangement: #TEXT_ONLY
      DirPortero,
      DirPorteroText,

      Resultado,
      
      LocalLastChangedAt
}
