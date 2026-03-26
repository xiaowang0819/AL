reportextension 50007 FS_RF_Order extends FSG_GLD_Order
{
    dataset
    {
        add("Purchase Header")
        {
            column(FS_RF_ShipmentMethodCode; "Shipment Method Code")
            {
            }
            column(FS_RF_ExternalDocumentNo; FS_RF_ExternalDocumentNo)
            {
            }
            column(FS_RF_YourReference; "Your Reference")
            {
            }
        }
    }
    rendering
    {
        layout(FS_RF_Order)
        {
            Type = RDLC;
            LayoutFile = './layouts/Order.rdlc';
        }
    }
    labels
    {
    FS_RF_ShipmentMethodCaption='Shipment Method';
    FS_RF_ExternalDocNoCaption='External Document No.';
    FS_RF_YourReferenceCaption='Your Reference';
    }
}
