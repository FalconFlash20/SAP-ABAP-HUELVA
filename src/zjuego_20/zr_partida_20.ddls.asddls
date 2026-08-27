@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPPT_00'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PARTIDA_20
  as select from zpartida_20

  association [0..1] to ZI_JUGADA_VH as _Jugada1Text on $projection.Jugada1 = _Jugada1Text.Jugada

  association [0..1] to ZI_JUGADA_VH as _Jugada2Text on $projection.Jugada2 = _Jugada2Text.Jugada
{
  key num_partida           as NumPartida,
      nombre_1              as Nombre1,
      jugada_1              as Jugada1,
      case jugada_1
        when '1' then 3   // Verde
        when '2'  then 2   // Amarillo
        when '3' then 1   // Rojo
        else 0                 // Neutral
      end                   as Jugada1Criticality,
      nombre_2              as Nombre2,
      jugada_2              as Jugada2,
      case jugada_2
      when '1' then 3   // Verde
      when '2'  then 2   // Amarillo
      when '3' then 1   // Rojo
      else 0                 // Neutral
      end                   as Jugada2Criticality,
      ganador               as Ganador,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Jugada1Text,
      _Jugada2Text
}
