@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - Jugada'
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZI_JUGADA_VH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZJUGADA_20' )
{
  @UI.hidden: true
  key domain_name,
  @UI.hidden: true
  key value_position,
  @UI.hidden: true
  key language,
  @EndUserText.label: 'Jugada'
  key value_low as Jugada,
      @EndUserText.label: 'Descripción'
      text      as Descripcion
}
