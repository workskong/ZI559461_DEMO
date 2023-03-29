@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi559461_i_booking_tcve
  as select from /dmo/booking as _Booking
  association to parent zi559461_i_trav_tcve        as _Travel on $projection.TravelId = _Travel.TravelId
  composition [0..*] of zi559461_i_booking_sup_tcve as _Suppl
{
  key travel_id     as TravelId,
  key booking_id    as BookingId,
      booking_date  as BookingDate,
      customer_id   as CustomerId,
      carrier_id    as CarrierId,
      connection_id as ConnectionId,
      flight_date   as FlightDate,
      //      flight_price  as FlightPrice,
      //      currency_code as CurrencyCode

      /* Associations */
      _Travel,
      _Suppl
}
