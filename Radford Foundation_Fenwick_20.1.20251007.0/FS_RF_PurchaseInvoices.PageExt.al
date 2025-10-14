pageextension 50006 FS_RF_PurchaseInvoices extends "Purchase Invoices"
{
    layout
    {
        addlast(Control1)
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
