pageextension 50030 FS_RF_PostedSalesInvSubform extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Line Amount")
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