pageextension 50029 FS_RF_SalesInvoiceSubform extends "Sales Invoice Subform"
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
