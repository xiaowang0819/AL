pageextension 50033 FS_RF_SalesReturnOrderSubform extends "Sales Return Order Subform"
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
