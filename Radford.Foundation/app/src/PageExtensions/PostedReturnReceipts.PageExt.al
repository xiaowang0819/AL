pageextension 50049 FS_RF_PostedReturnReceipts extends "Posted Return Receipts"
{
    layout
    {
        addbefore("Currency Code")
        {
            field(FS_RF_CampaignNo; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
        }
    }
}