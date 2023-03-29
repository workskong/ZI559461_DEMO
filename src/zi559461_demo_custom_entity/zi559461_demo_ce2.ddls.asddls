@EndUserText.label: 'Custom Entity - Paging'
@ObjectModel.query.implementedBy: 'ABAP:ZI559461_CL_DEMO_CE2'
define root custom entity ZI559461_DEMO_CE2
{
      @UI.lineItem: [{ position: 10, label: 'ebeln' }]
      @UI.selectionField: [{ position: 10 }]
  key ebeln  : abap.numc(10);
      @UI.lineItem: [{ position: 20, label: 'bukrs' }]
      @UI.selectionField: [{ position: 20 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI559461_DEMO_CE', element: 'bukrs' } }]
      bukrs  : abap.char(4);
      @UI.lineItem: [{ position: 30, label: 'bstyp' }]
      bstyp  : abap.char(4);
      @UI.lineItem: [{ position: 40, label: 'aedat' }]
      aedat  : abap.dats;
      @UI.lineItem: [{ position: 50, label: 'ernam' }]
      ernam  : abap.char(20);
      @UI.lineItem: [{ position: 60, label: 'ekorg' }]
      ekorg  : abap.char(4);
      @UI.lineItem: [{ position: 70, label: 'ekgrp' }]
      ekgrp  : abap.char(4);
      @UI.lineItem: [{ position: 80, label: 'price' }]
      @Semantics.amount.currencyCode : 'cuky'
      price  : abap.curr(10,2);
      @UI.lineItem: [{ position: 90, label: 'cuky' }]
      cuky   : abap.cuky;
      @UI.lineItem: [{ position: 100, label: 'status' }]
      status : abap_boolean;
}
