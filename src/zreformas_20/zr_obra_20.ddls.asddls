@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS raiz'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_obra_20 as select from zobra_20
{
    key id_obra               as IdObra,
      cliente               as Cliente,
      direccion             as Direccion,
      fecha_inicio          as FechaInicio,
      estado                as Estado,
      @Semantics.amount.currencyCode: 'Moneda'
      presupuesto_tot       as PresupuestoTot,
      moneda                 as Moneda,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt
}
