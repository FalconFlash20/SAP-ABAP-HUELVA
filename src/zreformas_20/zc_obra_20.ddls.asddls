@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Proyección UI - Obras'
@Search.searchable: true
@Metadata.allowExtensions: true
@UI.headerInfo: { typeName: 'Obra', typeNamePlural: 'Obras y Reformas', title: { type: #STANDARD, value: 'Cliente' } }
define root view entity ZC_OBRA_20
  provider contract transactional_query
  as projection on zr_obra_20
{
      @UI.facet: [ 
        { id: 'DatosGenerales', type: #FIELDGROUP_REFERENCE, position: 10, label: 'Información General', targetQualifier: 'GeneralData' }
      ]

      @UI.lineItem: [ { position: 10 } ]
      @UI.fieldGroup: [ { qualifier: 'GeneralData', position: 10 } ]
      @Search.defaultSearchElement: true
  key IdObra,

      @UI.lineItem: [ { position: 20 } ]
      @UI.fieldGroup: [ { qualifier: 'GeneralData', position: 20 } ]
      @Search.defaultSearchElement: true
      Cliente,

      @UI.lineItem: [ { position: 30 } ]
      @UI.fieldGroup: [ { qualifier: 'GeneralData', position: 30 } ]
      Direccion,

      @UI.lineItem: [ { position: 40 } ]
      @UI.fieldGroup: [ { qualifier: 'GeneralData', position: 40 } ]
      FechaInicio,

      @UI.lineItem: [ { position: 50 } ]
      @UI.fieldGroup: [ { qualifier: 'GeneralData', position: 50 } ]
      Estado,

      @UI.lineItem: [ { position: 60 } ]
      @UI.fieldGroup: [ { qualifier: 'GeneralData', position: 60 } ]
      PresupuestoTot,
      
      Moneda
}
