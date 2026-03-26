

report 78005 "JW_CommercialInvoice_SO"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = ALL;
    DefaultLayout = Word;
    WordLayout = './Layouts/JW_CommercialInvoices_SO.docx';

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = where("Document Type" = const(Order));
            RequestFilterFields = "No.";

            column(Order_No_; "No.") { }
            column(ExternalDocNo; "External Document No.") { }
            column(Reference; "Your Reference") { }
            column(Amount; Amount) { }
            column(PostingDate; "Posting Date") { }
            column(CustomerName; "Sell-to Customer Name") { }
            column(ShipToCode; "Ship-to Code") { }
            column(ShipToName; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(ShipToState; "Ship-to County") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(ShipToPostCode; "Ship-to Post Code") { }
            column(Ship_to_Contact; "Ship-to Contact") { }
            column(ShipToPhone; "Ship-to Phone No.") { }


            column(ShipmentDate; "Shipment Date") { }
            column(SalesPersonName; "Salesperson Code") { }
            column(DocumentType; "Document Type") { }

            dataitem(Line; "Sales Line")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(LineDocumentType; "Document Type") { }
                column(LineDocumentNo; "Document No.") { }
                column(LineType; Type) { }
                column(PartNumber; "No.") { }
                column(ItemDescription; Description) { }
                column(QuantityDigit; Quantity) { }
                column(Quantity; QtyText) { }
                column(Originally_Ordered_No_; "Originally Ordered No.") { }
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
    }

    var
        QtyText: Text[20];
}
