pageextension 50007 FS_RF_PostedPurchaseInvoice extends "Posted Purchase Invoice"
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
        }
    }
}
