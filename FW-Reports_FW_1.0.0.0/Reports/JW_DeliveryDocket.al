

report 78002 "JW_DeliveryDocket"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = ALL;
    DefaultLayout = Word;
    WordLayout = './Layouts/JW_DeliveryDocket_Final.docx';

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = where("Document Type" = const(Order));
            RequestFilterFields = "No.";

            column(OrderNumber; "No.") { }
            column(ShipToCode; "Ship-to Code") { }
            column(ShipToName; "Ship-to Name") { }
            column(ShipToAddress; "Ship-to Address") { }
            column(ShipToAddress2; "Ship-to Address 2") { }
            column(ShipToCity; "Ship-to City") { }
            column(ShipToState; "Ship-to County") { }
            column(ShipToCountry; "Ship-to Country/Region Code") { }
            column(ShipToPostCode; "Ship-to Post Code") { }
            column(ShipToContact; "Ship-to Contact") { }
            column(ShipToPhone; "Ship-to Phone No.") { }
            column(ExternalDocNo; "External Document No.") { }
            column(ShipmentDate; "Shipment Date") { }
            column(SalesPersonName; "Salesperson Code") { }
            column(DocumentType; "Document Type") { }

            column(WarehouseInstr; WarehouseInstr) { }
            column(DeliveryInstr; DeliveryInstr) { }
            column(CustomText2; CustomText2) { }

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

                trigger OnAfterGetRecord()
                begin
                    if Type = Type::" " then
                        QtyText := ' '
                    else
                        QtyText := Format(Quantity, 0, '<Precision,0:0><Integer><Decimals>');
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.SetTableView(Header);
            end;

            trigger OnAfterGetRecord()
            var
                RecRef: RecordRef;
                FldRef: FieldRef;
            begin
                WarehouseInstr := '';
                DeliveryInstr := '';
                CustomText2 := '';

                RecRef.GetTable(Header);
                FldRef := RecRef.Field(16037487);
                WarehouseInstr := FldRef.Value();
                FldRef := RecRef.Field(16037488);
                DeliveryInstr := FldRef.Value();
                FldRef := RecRef.Field(70256962);
                CustomText2 := FldRef.Value();
            end;
        }

        dataitem(Company; "Company Information")
        {
            column(CompanyPic; "Picture") { }
            column(CompanyName; "Name") { }
            column(CompanyAdd; Address) { }
            column(CompanyCity; City) { }
            column(CompanyEmail; "E-mail") { }
            column(CompanyWeb; "Home Page") { }
            column(CompanyPhone; "Phone No.") { }
        }
    }

    var
        QtyText: Text[20];
        WarehouseInstr: Text[250];
        DeliveryInstr: Text[250];
        CustomText2: Text[250];
}
