@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zi559461_i_trav_tcve
  as select from /dmo/travel as Travel
  composition [0..*] of zi559461_i_booking_tcve as _Booking
  association [0..1] to /DMO/I_Agency           as _Agency   on $projection.AgencyId = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer         as _Customer on $projection.CustomerId = _Customer.CustomerID
{
  key travel_id   as TravelId,
      agency_id   as AgencyId,
      customer_id as CustomerId,
      begin_date  as BeginDate,
      end_date    as EndDate,
      /* Associations */
      _Booking,
      _Agency,
      _Customer
}
