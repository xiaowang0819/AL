pageextension 50048 FS_RF_PostedSalesReturnOrder extends "Sales Return Order Archive"
{
    layout
    {
        addlast(General)
        {
            field(FS_RF_CampaignNo; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
