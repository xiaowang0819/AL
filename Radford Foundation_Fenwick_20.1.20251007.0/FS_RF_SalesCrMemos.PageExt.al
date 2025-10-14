pageextension 50054 FS_RF_SalesCrMemos extends "Sales Credit Memos"
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
