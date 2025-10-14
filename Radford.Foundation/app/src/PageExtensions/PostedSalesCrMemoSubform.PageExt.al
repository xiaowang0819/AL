pageextension 50031 FS_RF_PostedSalesCrMemoSubform extends "Posted Sales Cr. Memo Subform"
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