@EndUserText.label: 'Abstract Entity Test'
@ObjectModel: {
  supportedCapabilities: [#DATA_STRUCTURE],
  modelingPattern: #DATA_STRUCTURE
 }
define abstract entity ZI559461_DEMO_ABS
{
  customer_id   : abap.numc(6);
  carrier_id    : abap.numc(3);
  connection_id : abap.numc(4);
}
