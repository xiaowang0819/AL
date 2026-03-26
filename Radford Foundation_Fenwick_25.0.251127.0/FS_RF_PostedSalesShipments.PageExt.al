pageextension 50020 FS_RF_PostedSalesShipments extends "Posted Sales Shipments"
{
    layout
    {
        addbefore("External Document No.")
        {
            field(FS_RF_YourReference; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field(FS_RF_CampaignNo; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
        }
        modify("External Document No.")
        {
            Visible = true;
        }
    }
}
