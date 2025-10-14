reportextension 50000 FS_RF_StandardSalesInvoice extends "Standard Sales - Invoice"
{
    dataset
    {
        modify(Line)
        {
        trigger OnAfterAfterGetRecord()
        var
            SalesLine: Record "Sales Line";
        begin
            if Header."Prepayment Invoice" then begin
                if SalesLine.Get(SalesLine."Document Type"::Order, Header."Order No.", Line."Line No.")then begin
                    "No.":=SalesLine."No.";
                end;
            end;
        end;
        }
    }
    rendering
    {
        layout(FS_RF_TaxInvoiceLayout)
        {
            Type = Word;
            LayoutFile = './layouts/TaxInvoice.docx';
        }
    }
}
