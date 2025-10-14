pageextension 50050 FS_RF_PostedReturnReceipt extends "Posted Return Receipt"
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