pageextension 50034 FS_RF_PostedRetReceiptSubform extends "Posted Return Receipt Subform"
{
    layout
    {
        addafter("Shipment Date")
        {
            field(FS_RF_ExternalDocumentNo; Rec.FS_RF_ExternalDocumentNo)
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
