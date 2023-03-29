@EndUserText.label: 'Custom Entity - Consumption'
@ObjectModel.query.implementedBy: 'ABAP:ZI559461_CL_DEMO_CE'
define root custom entity ZI559461_DEMO_CE
{
      @UI.facet: [{ id: 'Company_Code',
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10, label: 'Company Code' }]

      @UI.selectionField: [{ element: 'bukrs', position: 10 }]
      @UI.lineItem: [{ position: 10, label: 'Company Code' }]
      @UI.identification: [{ position: 10, label: 'Company Code' }]
  key bukrs : abap.char( 4 );
      @UI.lineItem: [{ position: 20, label: 'Discription' }]
      @UI.identification: [{ position: 20, label: 'Discription' }]
      Name  : abap.char( 40 );
}
