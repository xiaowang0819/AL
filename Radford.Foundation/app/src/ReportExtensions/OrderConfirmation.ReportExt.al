reportextension 50009 FS_RF_OrderConfirmation extends FSG_GLD_OrderConfirmation
{
    dataset
    {
        add("Sales Header")
        {
            column(FS_RF_YourReference; "Your Reference")
            {
            }
        }
    }
    rendering
    {
        layout(FS_RF_OrderConfirmation)
        {
            Type = RDLC;
            LayoutFile = './layouts/OrderConfirmation.rdlc';
        }
    }
    labels
    {
        FS_RF_YourReferenceCaption = 'Your Reference';
    }
}