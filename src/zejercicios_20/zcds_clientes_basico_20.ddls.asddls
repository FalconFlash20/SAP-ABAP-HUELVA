@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio de clientes basico'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_clientes_basico_20
  as select from /dmo/customer
{
  key customer_id                                 as id,
      concat_with_space(first_name, last_name,1 ) as Nombre,
      city                                        as ciudad,
      country_code                                as pais
}
