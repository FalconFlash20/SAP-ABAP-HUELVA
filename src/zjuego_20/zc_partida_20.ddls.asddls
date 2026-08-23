@EndUserText.label: 'Projection View Partidas'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'GameId' ]

define root view entity ZC_PARTIDA_20
  provider contract transactional_query
  as projection on ZR_PARTIDA_20
{
  key GameId,

  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_JUGADA_VH', element: 'Jugada' } }]
  Jugador1,

  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_JUGADA_VH', element: 'Jugada' } }]
  Jugador2,

  Resultado
}
