@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zcds para ejercicio 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_vuelos_medio_20
  with parameters
    p_anio : abap.numc(4)
  as select from /dmo/flight  as f
    inner join   /dmo/carrier as c on f.carrier_id = c.carrier_id
{
  key c.name                           as carrier_name,
      @Semantics.amount.currencyCode: 'currency_code'
      avg(f.price as abap.curr(16,2) ) as precio_medio,
      @Semantics.amount.currencyCode: 'currency_code'
      max (f.price )                   as precio_max,
      @Semantics.amount.currencyCode: 'currency_code'
      min(f.price)                     as precio_min,
      count(*)                         as TotalVuelos,
      f.currency_code                  as currency_code
}
where
  substring( f.flight_date,1,4 ) = $parameters.p_anio
group by
  c.name,
  f.currency_code
