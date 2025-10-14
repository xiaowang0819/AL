reportextension 50008 FS_RF_SalesShipment extends FSG_GLD_SalesShipment
{
    rendering
    {
        layout(FS_RF_SalesShipment)
        {
            Type = RDLC;
            LayoutFile = './layouts/SalesShipment.rdlc';
        }
    }
    labels
    {
    FS_RF_ExternalDocNoCaption='External Document No';
    FS_RF_YourReferenceCaption='Your Reference';
    }
}
