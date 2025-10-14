pageextension 50035 FS_RF_SalesCrMemoSubform extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Qty. Assigned")
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
