@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI559461_DEMO_ABS_ROOT
  as select from zi559461_t001
{
      @UI.facet: [{ id: 'Student',
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10, label: 'Student' }]

      @UI.lineItem: [{ position: 10, label: 'TravelId' }]
      @UI.identification: [{ position: 10, label: 'TravelId' }]
      @Search.defaultSearchElement: true
  key travel_id     as TravelId,
      @UI.identification: [{ position: 20, label: 'BookingId' },
                           { type: #FOR_ACTION, dataAction: 'InputId', label: 'Input Id' }]
      @UI.lineItem: [{ position: 20, label: 'BookingId' },
                     { type: #FOR_ACTION, dataAction: 'InputId', label: 'Input Id' }]
      @Search.defaultSearchElement: true
  key booking_id    as BookingId,
      @UI.identification: [{ position: 30, label: 'BookingDate' }]
      @UI.lineItem: [{ position: 30, label: 'BookingDate' }]
      @Search.defaultSearchElement: true
      booking_date  as BookingDate,
      @UI.identification: [{ position: 40, label: 'CustomerId' }]
      @UI.lineItem: [{ position: 40, label: 'CustomerId' }]
      customer_id   as CustomerId,
      @UI.identification: [{ position: 50, label: 'CarrierId' }]
      @UI.lineItem: [{ position: 50, label: 'CarrierId' }]
      carrier_id    as CarrierId,
      @UI.identification: [{ position: 60, label: 'ConnectionId' }]
      @UI.lineItem: [{ position: 60, label: 'ConnectionId' }]
      connection_id as ConnectionId,
      @UI.identification: [{ position: 70, label: 'FlightDate' }]
      @UI.lineItem: [{ position: 70, label: 'FlightDate' }]
      flight_date   as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 80, label: 'FlightPrice' }]
      @UI.lineItem: [{ position: 80, label: 'FlightPrice' }]
      flight_price  as FlightPrice,
      @UI.identification: [{ position: 90, label: 'CurrencyCode' }]
      @UI.lineItem: [{ position: 90, label: 'CurrencyCode' }]
      currency_code as CurrencyCode
}
