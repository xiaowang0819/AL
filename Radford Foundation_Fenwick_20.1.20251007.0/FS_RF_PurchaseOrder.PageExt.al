pageextension 50017 FS_RF_PurchaseOrder extends "Purchase Order"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field(FS_RF_ExternalDocumentNo; Rec.FS_RF_ExternalDocumentNo)
            {
                ApplicationArea = All;
            }
            field(FS_RF_YourReference; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
    }
}
