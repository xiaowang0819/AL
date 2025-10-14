pageextension 50037 FS_RF_PostedSalesShptSubform extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("Shipment Date")
        {
            field(FS_RF_ExternalDocumentNo; Rec.FS_RF_ExternalDocumentNo)
            {
                ApplicationArea = All;
            }
            field(FS_RF_BlanketOrderNo; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
            }
            field(FS_RF_BlanketOrderLineNo; Rec."Blanket Order Line No.")
            {
                ApplicationArea = All;
            }
            field(FS_RF_CampaignNo; Rec.FS_RF_CampaignNo)
            {
                ApplicationArea = All;
            }
        }
    }
}