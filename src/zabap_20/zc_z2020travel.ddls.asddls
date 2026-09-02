@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'Z2020TRAVEL'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_Z2020TRAVEL
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_Z2020TRAVEL
  association [1..1] to ZR_Z2020TRAVEL as _BaseEntity on $projection.TRAVELID = _BaseEntity.TRAVELID
{
  key TravelID,
  AgencyID,
  CustomerID,
  BeginDate,
  EndDate,
  Status,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
