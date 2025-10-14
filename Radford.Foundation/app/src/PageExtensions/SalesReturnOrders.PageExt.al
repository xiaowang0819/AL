pageextension 50053 FS_RF_SalesReturnOrders extends "Sales Return Order List"
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