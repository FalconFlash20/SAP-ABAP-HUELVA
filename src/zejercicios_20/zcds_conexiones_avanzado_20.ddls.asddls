@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio de conexiones avanzado'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_conexiones_avanzado_20
  with parameters
    p_distancia : abap.int4
  as select from /dmo/connection as c
  inner join /dmo/carrier as carr on c.carrier_id = carr.carrier_id
{
  key c.airport_from_id              as ID_Orig,
      avg( c.distance as abap.dec(12,2) ) as Distancia,
      count(*)                       as TotalConexiones,
      case
          when avg( c.distance as abap.dec(12,2) ) < 1000 then 'Corta'
          when avg( c.distance as abap.dec(12,2)) >= 1000
           and avg( c.distance as abap.dec(12,2)) <= 5000 then 'Media'
          else 'Larga'
        end                          as TipoRuta,

      c.distance_unit                as UnidadDistancia
}
where
  c.distance > $parameters.p_distancia
group by
  c.airport_from_id,
  c.distance_unit
