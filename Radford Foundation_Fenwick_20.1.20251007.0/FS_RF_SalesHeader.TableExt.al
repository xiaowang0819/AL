tableextension 50011 FS_RF_SalesHeader extends "Sales Header"
{
    fields
    {
        field(50000; FS_RF_ServiceProvider; Code[20])
        {
            Caption = 'Service Provider';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(50001; FS_RF_PhoneNo; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(50002; FS_RF_ServiceRequestFlag; Boolean)
        {
            Caption = 'Service Request Flag';
            DataClassification = CustomerContent;
        }
        field(50003; FS_RF_Completed; Boolean)
        {
            Caption = 'Completed';
            DataClassification = CustomerContent;
        }
        field(50004; FS_RF_InvoiceSubmitted; Boolean)
        {
            Caption = 'Alphagates';
            DataClassification = CustomerContent;
        }
        field(50005; FS_RF_ApprovedToPay; Boolean)
        {
            Caption = 'Sigmagates';
            DataClassification = CustomerContent;
        }
        field(50006; FS_RF_ShipToCode; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = CustomerContent;
            TableRelation = "Ship-to Address".Code where("Customer No."=field("Sell-to Customer No."));

            trigger OnValidate()
            var
                ShipToAddr: Record "Ship-to Address";
                IsHandled: Boolean;
                CopyShipToAddress: Boolean;
            begin
                IsHandled:=false;
                if IsHandled then exit;
                if("Document Type" = "Document Type"::Order) and (xRec.FS_RF_ShipToCode <> FS_RF_ShipToCode)then begin
                    SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SetRange("Document No.", "No.");
                    SalesLine.SetFilter("Purch. Order Line No.", '<>0');
                    if not SalesLine.IsEmpty()then Error(LinkedPurchasesExistLbl, FieldCaption(FS_RF_ShipToCode));
                    SalesLine.Reset();
                end;
                CopyShipToAddress:=not IsCreditDocType();
                if CopyShipToAddress then if FS_RF_ShipToCode <> '' then begin
                        ShipToAddr.Get("Sell-to Customer No.", FS_RF_ShipToCode);
                        FS_RF_SetShipToCustomerAddressFieldsFromShipToAddr(ShipToAddr);
                    end
                    else
                    begin
                        if "Sell-to Customer No." <> '' then begin
                            FS_RF_GetCust("Sell-to Customer No.");
                            FS_RF_CopyShipToCustomerAddressFieldsFromCust(Cust);
                        end;
                    end;
            end;
        }
        field(50007; FS_RF_ShipToName; Text[100])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(50008; FS_RF_ShipToName2; Text[50])
        {
            Caption = 'Ship-to Name 2';
            DataClassification = CustomerContent;
        }
        field(50009; FS_RF_ShipToAddress; Text[100])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                FS_RF_PostCodeCheck.VerifyAddress(CurrFieldNo, Database::"Sales Header", GetPosition(), 2, FS_RF_ShipToName, FS_RF_ShipToName2, FS_RF_ShipToContact, FS_RF_ShipToAddress, FS_RF_ShipToAddress2, FS_RF_ShipToCity, FS_RF_ShipToPostCode, FS_RF_ShipToCounty, FS_RF_ShipToCountryRegionCode);
            end;
        }
        field(50010; FS_RF_ShipToAddress2; Text[50])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                FS_RF_PostCodeCheck.VerifyAddress(CurrFieldNo, Database::"Sales Header", GetPosition(), 2, FS_RF_ShipToName, FS_RF_ShipToName2, FS_RF_ShipToContact, FS_RF_ShipToAddress, FS_RF_ShipToAddress2, FS_RF_ShipToCity, FS_RF_ShipToPostCode, FS_RF_ShipToCounty, FS_RF_ShipToCountryRegionCode);
            end;
        }
        field(50011; FS_RF_ShipToCity; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = CustomerContent;
            TableRelation = if(FS_RF_ShipToCountryRegionCode=const(''))"Post Code".City
            else if(FS_RF_ShipToCountryRegionCode=filter(<>''))"Post Code".City where("Country/Region Code"=field(FS_RF_ShipToCountryRegionCode));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(FS_RF_ShipToCity, FS_RF_ShipToPostCode, FS_RF_ShipToCounty, FS_RF_ShipToCountryRegionCode);
            end;
            trigger OnValidate()
            begin
                PostCodeCheck.VerifyCity(CurrFieldNo, Database::"Sales Header", GetPosition(), 2, FS_RF_ShipToName, FS_RF_ShipToName2, FS_RF_ShipToContact, FS_RF_ShipToAddress, FS_RF_ShipToAddress2, FS_RF_ShipToCity, FS_RF_ShipToPostCode, FS_RF_ShipToCounty, FS_RF_ShipToCountryRegionCode);
            end;
        }
        field(50012; FS_RF_ShipToContact; Text[100])
        {
            Caption = 'Ship-to Contact';
            DataClassification = CustomerContent;
        }
        field(50013; FS_RF_ShipToPostCode; Code[20])
        {
            Caption = 'Ship-to Post Code';
            DataClassification = CustomerContent;
            TableRelation = if(FS_RF_ShipToCountryRegionCode=const(''))"Post Code"
            else if(FS_RF_ShipToCountryRegionCode=filter(<>''))"Post Code" where("Country/Region Code"=field(FS_RF_ShipToCountryRegionCode));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(FS_RF_ShipToCity, FS_RF_ShipToPostCode, FS_RF_ShipToCounty, FS_RF_ShipToCountryRegionCode);
            end;
            trigger OnValidate()
            begin
                PostCodeCheck.VerifyPostCode(CurrFieldNo, Database::"Sales Header", GetPosition(), 2, FS_RF_ShipToName, FS_RF_ShipToName2, FS_RF_ShipToContact, FS_RF_ShipToAddress, FS_RF_ShipToAddress2, FS_RF_ShipToCity, FS_RF_ShipToPostCode, FS_RF_ShipToCounty, FS_RF_ShipToCountryRegionCode);
            end;
        }
        field(50014; FS_RF_ShipToCounty; Text[30])
        {
            CaptionClass = '5,1,' + FS_RF_ShipToCountryRegionCode;
            Caption = 'Ship-to County';
            DataClassification = CustomerContent;
        }
        field(50015; FS_RF_ShipToCountryRegionCode; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(50016; FS_RF_ServiceProviderName; Text[100])
        {
            Caption = 'Service Provider Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No."=field(FS_RF_ServiceProvider)));
            Editable = false;
        }
        field(50017; FS_RF_ContractorShipTo; Code[10])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Contractor Ship-to Code';
            TableRelation = FS_RF_ContractorShipToAddress.FS_RF_Code where(FS_RF_VendorNo=field(FS_RF_ServiceProvider));

            trigger OnValidate()
            var
                ContractorShipToAddress: Record FS_RF_ContractorShipToAddress;
                SalesLine: Record "Sales Line";
                CopyShipToAddress: Boolean;
            begin
                if("Document Type" = "Document Type"::Order)then begin
                    Rec.TestField(FS_RF_ServiceProvider);
                    SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SetRange("Document No.", "No.");
                    SalesLine.SetFilter("Purch. Order Line No.", '<>0');
                    if not SalesLine.IsEmpty()then Error(LinkedPurchasesExistLbl, FieldCaption(FS_RF_ContractorShipTo));
                    SalesLine.Reset();
                    Rec.Validate("Ship-to Code", '');
                    CopyShipToAddress:=not IsCreditDocType();
                    if CopyShipToAddress then if FS_RF_ContractorShipTo <> '' then begin
                            ContractorShipToAddress.Get(FS_RF_ServiceProvider, FS_RF_ContractorShipTo);
                            FS_RF_SetShipToCustomerAddressFieldsFromContractorAddr(ContractorShipToAddress);
                        end;
                end;
            end;
        }
        field(50018; FS_RF_LinkedPI; Code[20])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Linked PI';
            Editable = false;
        }
        field(50019; FS_RF_ApprForCustInvoice; Boolean)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Appr for Cust Invoice';
            Editable = false;
        }
        field(50020; FS_RF_DocumentEmailSent; Boolean)
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'Document Email Sent';
        }
        field(50021; FS_RF_ReadyForShipping; Boolean)
        {
            Caption = 'Ready for Shipping';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50022; FS_RF_Shipped; Boolean)
        {
            Caption = 'Shipped Existing';
            FieldClass = FlowField;
            CalcFormula = exist("Sales Line" where("Document No."=field("No."), "Document Type"=field("Document Type"), Type=filter(Item), "Quantity Shipped"=filter(>0)));
        }
        modify("Ship-to Code")
        {
        trigger OnAfterValidate()
        begin
            if(Rec."Ship-to Code" <> xRec."Ship-to Code") and (Rec."Ship-to Code" <> '')then begin
                SalesLine.SetRange("Document Type", "Document Type");
                SalesLine.SetRange("Document No.", "No.");
                if SalesLine.FindSet()then begin
                    repeat SalesLine.FS_RF_FreightPrice:=SalesLine.FS_RF_UpdateFreightPrice();
                        SalesLine.Modify();
                    until SalesLine.Next() = 0;
                end;
            end;
        end;
        }
        modify("Campaign No.")
        {
        trigger OnAfterValidate()
        var
            SalesLine: Record "Sales Line";
        begin
            if Rec."Campaign No." <> xRec."Campaign No." then begin
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.ModifyAll(FS_RF_CampaignNo, Rec."Campaign No.");
            end;
        end;
        }
    }
    var SalesLine: Record "Sales Line";
    Cust: Record Customer;
    PostCode: Record "Post Code";
    PostCodeCheck: Codeunit "Post Code Check";
    FS_RF_PostCodeCheck: Codeunit FS_RF_PostCodeCheck;
    LinkedPurchasesExistLbl: Label 'You cannot change %1 because the order is associated with one or more purchase orders.';
    procedure FS_RF_CreateFreightSalesLine(var TotalFreightPrice: Decimal; var FreightSalesLine: Record "Sales Line")
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        Resource: Record Resource;
        LineNo: Integer;
    begin
        SalesSetup.Get();
        SalesSetup.TestField(FS_RF_DefaultFreightCode);
        Resource.Get(SalesSetup.FS_RF_DefaultFreightCode);
        SalesLine2.SetRange("Document Type", Rec."Document Type");
        SalesLine2.SetRange("Document No.", Rec."No.");
        if SalesLine2.FindSet()then begin
            repeat TotalFreightPrice+=SalesLine2.FS_RF_FreightPrice;
            until SalesLine2.Next() = 0;
        end;
        if TotalFreightPrice <> 0 then begin
            FreightSalesLine.SetRange("Document Type", Rec."Document Type");
            FreightSalesLine.SetRange("Document No.", Rec."No.");
            FreightSalesLine.SetRange(Type, FreightSalesLine.Type::Resource);
            FreightSalesLine.SetRange("No.", SalesSetup.FS_RF_DefaultFreightCode);
            if FreightSalesLine.FindFirst()then begin
                if TotalFreightPrice <> FreightSalesLine."Amount Including VAT" then begin
                    FreightSalesLine.Validate("Unit Price", TotalFreightPrice);
                    FreightSalesLine.Modify();
                end;
            end
            else
            begin
                FreightSalesLine.Reset();
                FreightSalesLine.Init();
                FreightSalesLine.Validate("Document Type", "Document Type");
                FreightSalesLine.Validate("Document No.", "No.");
                SalesLine3.SetRange("Document Type", "Document Type");
                SalesLine3.SetRange("Document No.", "No.");
                if SalesLine3.FindLast()then begin
                    LineNo:=SalesLine3."Line No." + 10000;
                end
                else
                begin
                    LineNo:=10000;
                end;
                FreightSalesLine.Validate("Line No.", LineNo);
                FreightSalesLine.Validate(Type, FreightSalesLine.Type::Resource);
                FreightSalesLine.Validate("No.", SalesSetup.FS_RF_DefaultFreightCode);
                FreightSalesLine.Validate("Location Code", "Location Code");
                FreightSalesLine.Validate(Quantity, 1);
                FreightSalesLine.Validate("Unit of Measure Code", Resource."Base Unit of Measure");
                FreightSalesLine.Validate("Unit Price", TotalFreightPrice);
                FreightSalesLine.Insert();
            end;
        end;
    end;
    procedure FS_RF_SetShipToCustomerAddressFieldsFromShipToAddr(ShipToAddr: Record "Ship-to Address")
    begin
        FS_RF_ShipToName:=ShipToAddr.Name;
        FS_RF_ShipToName2:=ShipToAddr."Name 2";
        FS_RF_ShipToAddress:=ShipToAddr.Address;
        FS_RF_ShipToAddress2:=ShipToAddr."Address 2";
        FS_RF_ShipToCity:=ShipToAddr.City;
        FS_RF_ShipToPostCode:=ShipToAddr."Post Code";
        FS_RF_ShipToCounty:=ShipToAddr.County;
        Validate(FS_RF_ShipToCountryRegionCode, ShipToAddr."Country/Region Code");
        FS_RF_ShipToContact:=ShipToAddr.Contact;
    end;
    procedure FS_RF_CopyShipToCustomerAddressFieldsFromCust(var SellToCustomer: Record Customer)
    begin
        FS_RF_ShipToName:=SellToCustomer.Name;
        FS_RF_ShipToName2:=SellToCustomer."Name 2";
        if FS_RF_SellToCustomerIsReplaced() or FS_RF_ShipToAddressEqualsOldSellToAddress() or (FS_RF_HasDifferentShipToAddress(SellToCustomer) and SellToCustomer.HasAddress())then begin
            FS_RF_ShipToAddress:=SellToCustomer.Address;
            FS_RF_ShipToAddress2:=SellToCustomer."Address 2";
            FS_RF_ShipToCity:=SellToCustomer.City;
            FS_RF_ShipToPostCode:=SellToCustomer."Post Code";
            FS_RF_ShipToCounty:=SellToCustomer.County;
            Validate(FS_RF_ShipToCountryRegionCode, SellToCustomer."Country/Region Code");
        end;
        FS_RF_ShipToContact:=SellToCustomer.Contact;
    end;
    procedure FS_RF_HasDifferentShipToAddress(Customer: Record Customer)Result: Boolean begin
        Result:=(FS_RF_ShipToAddress <> Customer.Address) or (FS_RF_ShipToAddress2 <> Customer."Address 2") or (FS_RF_ShipToCity <> Customer.City) or (FS_RF_ShipToCountryRegionCode <> Customer."Country/Region Code") or (FS_RF_ShipToCounty <> Customer.County) or (FS_RF_ShipToPostCode <> Customer."Post Code") or (FS_RF_ShipToContact <> Customer.Contact);
    end;
    local procedure FS_RF_SellToCustomerIsReplaced(): Boolean begin
        exit((xRec."Sell-to Customer No." <> '') and (xRec."Sell-to Customer No." <> "Sell-to Customer No."));
    end;
    local procedure FS_RF_ShipToAddressEqualsOldSellToAddress(): Boolean begin
        exit(IsShipToAddressEqualToSellToAddress(xRec, Rec));
    end;
    procedure FS_RF_ShipToAddressEqualsSellToAddress(): Boolean begin
        exit(IsShipToAddressEqualToSellToAddress(Rec, Rec));
    end;
    local procedure IsShipToAddressEqualToSellToAddress(SalesHeaderWithSellTo: Record "Sales Header"; SalesHeaderWithShipTo: Record "Sales Header"): Boolean var
        Result: Boolean;
    begin
        Result:=(SalesHeaderWithSellTo."Sell-to Address" = SalesHeaderWithShipTo.FS_RF_ShipToAddress) and (SalesHeaderWithSellTo."Sell-to Address 2" = SalesHeaderWithShipTo.FS_RF_ShipToAddress2) and (SalesHeaderWithSellTo."Sell-to City" = SalesHeaderWithShipTo.FS_RF_ShipToCity) and (SalesHeaderWithSellTo."Sell-to County" = SalesHeaderWithShipTo.FS_RF_ShipToCounty) and (SalesHeaderWithSellTo."Sell-to Post Code" = SalesHeaderWithShipTo.FS_RF_ShipToPostCode) and (SalesHeaderWithSellTo."Sell-to Country/Region Code" = SalesHeaderWithShipTo.FS_RF_ShipToCountryRegionCode) and (SalesHeaderWithSellTo."Sell-to Contact" = SalesHeaderWithShipTo.FS_RF_ShipToContact);
        exit(Result);
    end;
    procedure FS_RF_CopySellToAddressToShipToAddress()
    begin
        FS_RF_ShipToAddress:="Sell-to Address";
        FS_RF_ShipToAddress2:="Sell-to Address 2";
        FS_RF_ShipToCity:="Sell-to City";
        FS_RF_ShipToContact:="Sell-to Contact";
        FS_RF_ShipToCountryRegionCode:="Sell-to Country/Region Code";
        FS_RF_ShipToCounty:="Sell-to County";
        FS_RF_ShipToPostCode:="Sell-to Post Code";
    end;
    procedure FS_RF_GetCust(CustNo: Code[20]): Record Customer begin
        if not(("Document Type" = "Document Type"::Quote) and (CustNo = ''))then begin
            if CustNo <> Cust."No." then Cust.Get(CustNo);
        end
        else
        begin
            Clear(Cust);
        end;
        exit(Cust);
    end;
    procedure FS_RF_SetShipToCustomerAddressFieldsFromContractorAddr(ShipToAddr: Record FS_RF_ContractorShipToAddress)
    var
        IsHandled: Boolean;
    begin
        IsHandled:=false;
        FS_RF_OnBeforeCopyShipToCustomerAddressFieldsFromContractorShipToAddr(Rec, ShipToAddr, IsHandled);
        if IsHandled then exit;
        "Ship-to Name":=ShipToAddr.FS_RF_Name;
        "Ship-to Name 2":=ShipToAddr.FS_RF_Name2;
        "Ship-to Address":=ShipToAddr.FS_RF_Address;
        "Ship-to Address 2":=ShipToAddr.FS_RF_Address2;
        "Ship-to City":=ShipToAddr.FS_RF_City;
        "Ship-to Post Code":=ShipToAddr.FS_RF_PostCode;
        "Ship-to County":=ShipToAddr.FS_RF_County;
        Validate("Ship-to Country/Region Code", ShipToAddr.FS_RF_CountryRegionCode);
        "Ship-to Contact":=ShipToAddr.FS_RF_Contact;
        if ShipToAddr.FS_RF_TaxAreaCode <> '' then Validate("Tax Area Code", ShipToAddr.FS_RF_TaxAreaCode);
        Validate("Tax Liable", ShipToAddr.FS_RF_TaxLiable);
        FS_RF_ShipToName:=ShipToAddr.FS_RF_Name;
        FS_RF_ShipToName2:=ShipToAddr.FS_RF_Name2;
        FS_RF_ShipToAddress:=ShipToAddr.FS_RF_Address;
        FS_RF_ShipToAddress2:=ShipToAddr.FS_RF_Address2;
        FS_RF_ShipToCity:=ShipToAddr.FS_RF_City;
        FS_RF_ShipToPostCode:=ShipToAddr.FS_RF_PostCode;
        FS_RF_ShipToCounty:=ShipToAddr.FS_RF_County;
        FS_RF_ShipToContact:=ShipToAddr.FS_RF_Contact;
        FS_RF_ShipToCountryRegionCode:=ShipToAddr.FS_RF_CountryRegionCode;
        FS_RF_OnAfterCopyShipToCustomerAddressFieldsFromContractorShipToAddr(Rec, ShipToAddr, xRec);
    end;
    procedure FS_RF_LookupPurchaseInvPage()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if Rec.FS_RF_LinkedPI = '' then exit;
        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Invoice, Rec.FS_RF_LinkedPI)then begin
            Page.Run(Page::"Purchase Invoice", PurchaseHeader);
        end;
    end;
    [IntegrationEvent(false, false)]
    local procedure FS_RF_OnAfterCopyShipToCustomerAddressFieldsFromContractorShipToAddr(var SalesHeader: Record "Sales Header"; ShipToAddress: Record FS_RF_ContractorShipToAddress; xSalesHeader: Record "Sales Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure FS_RF_OnBeforeCopyShipToCustomerAddressFieldsFromContractorShipToAddr(var SalesHeader: Record "Sales Header"; var ShipToAddress: Record FS_RF_ContractorShipToAddress; var IsHandled: Boolean)
    begin
    end;
}
