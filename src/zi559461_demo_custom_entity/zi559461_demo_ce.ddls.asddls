@EndUserText.label: 'agency data from ES5'
@ObjectModel.query.implementedBy: 'ABAP:ZI559461_CL_DEMO_CE'
define root custom entity ZI559461_DEMO_CE
{
      @UI.facet: [{ id: 'Student',
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10, label: 'Student' }]

      @UI.selectionField: [{ element: 'Id', position: 10 }]
      @UI.lineItem: [{ position: 10, label: 'Id' }]
      @UI.identification: [{ position: 10, label: 'Id' }]
  key Id   : abap.numc( 6 );
      @UI.lineItem: [{ position: 20, label: 'Name' }]
      @UI.identification: [{ position: 10, label: 'Name' }]
      Name : abap.char( 31 );
      @UI.lineItem: [{ position: 30, label: 'City' }]
      City : abap.char( 25 );
}
