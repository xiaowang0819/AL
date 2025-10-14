pageextension 50042 FS_RF_PostedSalesCrMemo extends "Posted Sales Credit Memo"
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
