@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zcds para ejercicio 1'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_vuelos_basico_20
  as select from /dmo/carrier
{
  key carrier_id    as carrier_id,
      name          as name,
      currency_code as currency
}
