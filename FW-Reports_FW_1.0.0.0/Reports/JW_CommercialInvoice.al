report 78004 "JW Commercial Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Commercial Invoice';

    DefaultLayout = Word;
    WordLayout = './Layouts/JW_CommercialInvoices.docx';

    dataset
    {
        dataitem(Company; "Company Information")
        {
            column(CompanyPic; "Picture") { }
            column(CompanyName; "Name") { }
            column(CompanyAdd; Address) { }
            column(CompanyCity; City) { }
            column(County; County) { }
            column(Country_Region_Code; "Country/Region Code") { }

            column(CompanyEmail; "E-mail") { }
            column(CompanyWeb; "Home Page") { }
            column(CompanyPhone; "Phone No.") { }
            column(ABN; ABN) { }


        }
        dataitem(SIH; "Sales Invoice Header")
        {
            RequestFilterFields = "Sell-to Customer No.", "Posting Date";

            column(InvoiceNo; "No.") { }
            column(Order_No_; "Order No.") { }
            column(ExternalDoc; "External Document No.") { }
            column(Reference; "Your Reference") { }
            column(Amount; Amount) { }
            column(GST; "Amount Including VAT" - Amount) { }
            column(AmountIncl; "Amount Including VAT") { }
            column(CustomerName; "Sell-to Customer Name") { }
            column(CustomerNo; "Sell-to Customer No.") { }
            column(SalesPerson; "Salesperson Code") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Contact; "Ship-to Contact") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Shipment_Date; "Shipment Date") { }
            column(Ship_to_Phone_No_; "Ship-to Phone No.") { }

            column(PostingDate; "Posting Date") { }

            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLinkReference = SIH;
                DataItemLink = "Document No." = field("No.");
                column(LineDocumentNo; "Document No.") { }
                column(LineType; Type) { }
                column(PartNumber; "No.") { }
                column(ItemDescription; Description) { }
                column(QuantityDigit; Quantity) { }
                column(Quantity; QtyText) { }
                column(Line_Amount; "Line Amount") { }


                trigger OnAfterGetRecord()
                begin
                    if Type = Type::" " then
                        QtyText := ' '
                    else
                        QtyText := Format(Quantity, 0, '<Precision,0:0><Integer><Decimals>');
                end;
            }
        }

    }

    var

        QtyText: Text[20];

}


pageextension 78012 JW_PostedSI extends "Posted Sales Invoice"
{
    actions
    {
        addlast(processing)
        {
            action(FW_Commercial_Invoice)
            {
                Caption = 'FW Commercial Invoices';
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                var
                    SIH: Record "Sales Invoice Header";
                begin
                    SIH.SetRange("No.", Rec."No.");
                    Report.RunModal(78004, true, true, SIH);
                end;
            }
        }
    }
}
