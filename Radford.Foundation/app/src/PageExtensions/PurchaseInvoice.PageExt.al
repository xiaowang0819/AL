pageextension 50005 FS_RF_PurchaseInvoice extends "Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field(FS_RF_LinkedOrder; Rec.FS_RF_LinkedOrder)
            {
                ApplicationArea = All;
                Editable = false;

                trigger OnAssistEdit()
                begin
                    Rec.FS_RF_LookupSourcePage();
                end;
            }
            field(FS_RF_YourReference; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
    }
}
