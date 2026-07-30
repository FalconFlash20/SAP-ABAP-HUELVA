@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zcds para agencias'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_agencias_medio_20
  with parameters
    p_pais : abap.char( 3 )
  as select from /dmo/agency  as a
    inner join   /dmo/travel  as t on a.agency_id = t.agency_id
    inner join   /dmo/booking as b on t.travel_id = b.travel_id
{
  key a.name                                 as Nom_Agencia,
      count(*)                               as TotalReservas,
      @Semantics.amount.currencyCode: 'moneda'
      avg(b.flight_price as abap.curr(16,2)) as ImporteMedio,
      @Semantics.amount.currencyCode: 'moneda'
      sum(b.flight_price)                    as ImporteTotal,
      b.currency_code                        as moneda
}
where
  a.country_code = $parameters.p_pais
group by
  a.name,
  b.currency_code
