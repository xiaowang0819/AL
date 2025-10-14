pageextension 50043 FS_RF_PostedSalesCrMemos extends "Posted Sales Credit Memos"
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