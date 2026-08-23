@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity Partidas'
define root view entity ZR_PARTIDA_20
  as select from zpartida_20
{
  key game_id               as GameId,
      jugador1              as Jugador1,
      jugador2              as Jugador2,
      resultado             as Resultado,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
