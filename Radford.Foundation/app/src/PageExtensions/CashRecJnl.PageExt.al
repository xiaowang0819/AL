pageextension 50040 FS_RF_CashRecJnl extends "Cash Receipt Journal"
{
    layout
    {
        addbefore(Amount)
        {
            field(FS_RF_CampaignNo; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
        }
    }
}