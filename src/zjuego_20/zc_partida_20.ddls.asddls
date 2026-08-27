@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZPARTIDA_20'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PARTIDA_20
  provider contract transactional_query
  as projection on ZR_PARTIDA_20
  association [1..1] to ZR_PARTIDA_20 as _BaseEntity on $projection.NumPartida = _BaseEntity.NumPartida
{
  key NumPartida,

      Nombre1,
      @ObjectModel.text.element: ['Jugada1Descripcion']
      Jugada1,
      Jugada1Criticality,
      @Semantics.text: true
      _Jugada1Text.Descripcion as Jugada1Descripcion,
      /* Campo dinámico de color para Jugada 1 */
      
      Nombre2,
      @ObjectModel.text.element: ['Jugada2Descripcion']
      Jugada2,
      Jugada2Criticality,
      @Semantics.text: true
      _Jugada2Text.Descripcion as Jugada2Descripcion,
      /* Campo dinámico de color para Jugada 2 */

      Ganador,
      @Semantics: {
        user.createdBy: true
      }
      CreatedBy,
      @Semantics: {
        user.localInstanceLastChangedBy: true
      }
      LastChangedBy,
      @Semantics: {
        systemDateTime.localInstanceLastChangedAt: true
      }
      LastChangedAt,
      @Semantics: {
        systemDateTime.lastChangedAt: true
      }
      LocalLastChangedAt,
      _Jugada1Text,
      _Jugada2Text,
      _BaseEntity
}
