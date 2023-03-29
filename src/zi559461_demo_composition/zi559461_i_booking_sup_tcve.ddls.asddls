@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi559461_i_booking_sup_tcve
  as select from /dmo/book_suppl as Suppl
  association to parent zi559461_i_booking_tcve as _Booking on  $projection.BookingId = _Booking.BookingId
                                                            and $projection.TravelId  = _Booking.TravelId
  association to zi559461_i_trav_tcve           as _Travel  on  $projection.TravelId = _Travel.TravelId
{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      /* Association */
      _Travel,
      _Booking
}
