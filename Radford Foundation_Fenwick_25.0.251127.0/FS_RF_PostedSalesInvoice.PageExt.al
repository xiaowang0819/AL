pageextension 50038 FS_RF_PostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        addafter("External Document No.")
        {
            field(FS_RF_CampaignNo; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
