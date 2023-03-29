@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi559461_c_booking_tcve
  as projection on zi559461_i_booking_tcve
{
  key TravelId,
  key BookingId,
      BookingDate,
      CustomerId,
      CarrierId,
      ConnectionId,
      FlightDate,
      /* Associations */
      _Travel : redirected to parent zi559461_c_trav_tcve,
      _Suppl  : redirected to composition child zi559461_c_booking_sup_tcve
}
