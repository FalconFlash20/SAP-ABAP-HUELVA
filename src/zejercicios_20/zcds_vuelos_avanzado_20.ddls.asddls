@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zcds para ejercicio 3'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_vuelos_avanzado_20
  with parameters
    p_fecha : abap.dats
  as select from /dmo/booking as b
  association [1..1] to /dmo/customer as c on b.customer_id = c.customer_id
{
  key b.customer_id       as customer_id,
      c.first_name        as fist_name,
      c.last_name         as last_name,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      sum(b.flight_price) as ImporteTotal,
      count(*)            as Num_Reservas,    
        b.currency_code     as CurrencyCode,
      case
      when sum( b.flight_price ) < 1000 then 'Ocasional'
          when sum( b.flight_price ) >= 1000
           and sum( b.flight_price ) <= 5000 then 'Frecuente'
          else 'VIP'
        end               as TipoCliente
}
where
  b.booking_date > $parameters.p_fecha
group by
  b.customer_id,
  c.first_name,
  c.last_name,
  b.currency_code
