reportextension 50005 FS_RF_SalesInvoice extends FSG_GLD_SalesInvoice
{
    dataset
    {
        add("Sales Invoice Header")
        {
            column(FS_RF_OurAccountNo_Customer; Customer."Our Account No.")
            {
            }
            column(FS_RF_ForeignCustomer; ForeignCustomer)
            {
            }
            column(FS_RF_YourReference; "Your Reference")
            {
            }
        }
        add("Sales Invoice Line")
        {
            column(FS_RF_UnitPrice_PrepaymentInvLine; UnitPrice)
            {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 2;
            }
            column(FS_RF_Qty_PrepaymentInvLine; FS_RF_GLDHelper.FormatQuantity(LineQuantity, "Unit of Measure Code"))
            {
            }
            column(FS_RF_PrepaymentInvoice_SalesInvoiceHeader; "Sales Invoice Header"."Prepayment Invoice")
            {
            }
        }
        modify("Sales Invoice Header")
        {
        trigger OnAfterAfterGetRecord()
        var
            SalesSetup: Record "Sales & Receivables Setup";
        begin
            SalesSetup.Get();
            Customer.Get("Sales Invoice Header"."Bill-to Customer No.");
            if Customer."VAT Bus. Posting Group" = SalesSetup.FS_RF_ForeignGSTPostingGroup then begin
                ForeignCustomer:=true;
            end;
        end;
        }
        modify("Sales Invoice Line")
        {
        trigger OnAfterAfterGetRecord()
        var
            SalesLine2: Record "Sales Line";
        begin
            LineQuantity:=0;
            UnitPrice:=0;
            if "Sales Invoice Header"."Prepayment Invoice" then begin
                if(("Sales Invoice Line"."Order Line No." <> 0) and ("Sales Invoice Header"."Order No." <> '')) and SalesLine2.Get(SalesLine2."Document Type"::Order, "Sales Invoice Header"."Order No.", "Sales Invoice Line"."Order Line No.")then begin
                    LineQuantity:=SalesLine2.Quantity;
                    UnitPrice:=SalesLine2."Unit Price";
                    "Sales Invoice Line"."No.":=SalesLine2."No.";
                end
                else
                begin
                    if SalesLine2.Get(SalesLine2."Document Type"::Order, "Sales Invoice Header"."Prepayment Order No.", "Sales Invoice Line"."Line No.")then begin
                        LineQuantity:=SalesLine2.Quantity;
                        UnitPrice:=SalesLine2."Unit Price";
                        "Sales Invoice Line"."No.":=SalesLine2."No.";
                    end;
                end;
            end;
        end;
        }
    }
    rendering
    {
        layout(FS_RF_SalesInvoice)
        {
            Type = RDLC;
            LayoutFile = './layouts/SalesInvoice.rdlc';
        }
    }
    labels
    {
    FS_RF_VendorNumberCaption='VENDOR NUMBER ';
    FS_RF_AmountCaption='Amount';
    FS_RF_TotalCaption='Total';
    FS_RF_YourReferenceCaption='Your Reference';
    }
    var Customer: Record Customer;
    FS_RF_GLDHelper: Codeunit FSG_GLD_DocumentHelper;
    LineQuantity: Decimal;
    UnitPrice: Decimal;
    ForeignCustomer: Boolean;
}
