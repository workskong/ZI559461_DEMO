@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zi559461_c_trav_tcve
  as projection on zi559461_i_trav_tcve
{
  key TravelId,
      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,
      /* Associations */
      _Booking : redirected to composition child zi559461_c_booking_tcve
}
