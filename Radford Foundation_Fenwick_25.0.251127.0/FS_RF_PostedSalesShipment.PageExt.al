pageextension 50019 FS_RF_PostedSalesShipment extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Order No.")
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
