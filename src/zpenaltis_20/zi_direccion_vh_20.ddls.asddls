@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help para Direcciones de Penalti'
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true

define view entity ZI_DIRECCION_VH_20
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZDOM_DIRECCION_20' )
{
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @UI.hidden: true
  key language,
      @ObjectModel.text.element: ['Text']
  key value_low as Direccion,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      text      as Text
}
