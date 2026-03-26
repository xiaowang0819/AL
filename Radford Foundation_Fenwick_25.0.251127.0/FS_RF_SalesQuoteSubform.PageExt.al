pageextension 50010 FS_RF_SalesQuoteSubform extends "Sales Quote Subform"
{
    layout
    {
        addafter("Unit Price")
        {
            field(FS_RF_ContractorUnitCost; Rec.FS_RF_ContractorUnitCost)
            {
                ApplicationArea = All;
            }
            field(FS_RF_FreightPrice; Rec.FS_RF_FreightPrice)
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. Assigned")
        {
            field(FS_RF_ExternalDocumentNo; Rec.FS_RF_ExternalDocumentNo)
            {
                ApplicationArea = All;
            }
        }
    }
}
