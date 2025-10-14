table 50500 FS_RF_ContractorShipToAddress
{
    Caption = 'Contractor Ship-to Address';
    DataClassification = CustomerContent;
    DataCaptionFields = FS_RF_VendorNo, FS_RF_Name, FS_RF_Code;
    LookupPageId = FS_RF_ContractorShipToList;

    fields
    {
        field(1; FS_RF_VendorNo; Code[20])
        {
            Caption = 'Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(2; FS_RF_Code; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; FS_RF_Name; Text[100])
        {
            Caption = 'Name';
        }
        field(4; FS_RF_Name2; Text[50])
        {
            Caption = 'Name 2';
        }
        field(5; FS_RF_Address; Text[100])
        {
            Caption = 'Address';

            trigger OnValidate()
            begin
                FS_RF_PostCodeCheck.VerifyAddress(CurrFieldNo, Database::"Ship-to Address", Rec.GetPosition(), 0,
                  FS_RF_Name, FS_RF_Name2, FS_RF_Contact, FS_RF_Address, FS_RF_Address2, FS_RF_City, FS_RF_PostCode, FS_RF_County, FS_RF_CountryRegionCode);
            end;
        }
        field(6; FS_RF_Address2; Text[50])
        {
            Caption = 'Address 2';

            trigger OnValidate()
            begin
                FS_RF_PostCodeCheck.VerifyAddress(CurrFieldNo, Database::"Ship-to Address", Rec.GetPosition(), 0,
                  FS_RF_Name, FS_RF_Name2, FS_RF_Contact, FS_RF_Address, FS_RF_Address2, FS_RF_City, FS_RF_PostCode, FS_RF_County, FS_RF_CountryRegionCode);
            end;
        }
        field(7; FS_RF_City; Text[30])
        {
            Caption = 'City';
            TableRelation = if (FS_RF_CountryRegionCode = const('')) "Post Code".City
            else
            if (FS_RF_CountryRegionCode = filter(<> '')) "Post Code".City where("Country/Region Code" = field(FS_RF_CountryRegionCode));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnBeforeLookupCity(Rec, PostCode);

                PostCode.LookupPostCode(FS_RF_City, FS_RF_PostCode, FS_RF_County, FS_RF_CountryRegionCode);

                OnAfterLookupCity(Rec, PostCode);
            end;

            trigger OnValidate()
            begin
                OnBeforeValidateCity(Rec, PostCode);

                PostCodeCheck.VerifyCity(
                  CurrFieldNo, Database::"Ship-to Address", Rec.GetPosition(), 0,
                  FS_RF_Name, FS_RF_Name2, FS_RF_Contact, FS_RF_Address, FS_RF_Address2, FS_RF_City, FS_RF_PostCode, FS_RF_County, FS_RF_CountryRegionCode);
            end;
        }
        field(8; FS_RF_Contact; Text[100])
        {
            Caption = 'Contact';
        }
        field(9; FS_RF_PhoneNo; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; FS_RF_TelexNo; Text[30])
        {
            Caption = 'Telex No.';
        }
        field(11; FS_RF_CountryRegionCode; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty(FS_RF_City, FS_RF_PostCode, FS_RF_County, FS_RF_CountryRegionCode, xRec.FS_RF_CountryRegionCode);
            end;
        }
        field(12; FS_RF_LastDateModified; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(13; FS_RF_FaxNo; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(14; FS_RF_TelexAnswerBack; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(15; FS_RF_GLN; Code[13])
        {
            Caption = 'GLN';

            trigger OnValidate()
            var
                GLNCalculator: Codeunit "GLN Calculator";
            begin
                if FS_RF_GLN <> '' then
                    GLNCalculator.AssertValidCheckDigit13(FS_RF_GLN);
            end;
        }
        field(16; FS_RF_PostCode; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if (FS_RF_CountryRegionCode = const('')) "Post Code"
            else
            if (FS_RF_CountryRegionCode = filter(<> '')) "Post Code" where("Country/Region Code" = field(FS_RF_CountryRegionCode));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnBeforeLookupPostCode(Rec, PostCode);

                PostCode.LookupPostCode(FS_RF_City, FS_RF_PostCode, FS_RF_County, FS_RF_CountryRegionCode);

                OnAfterLookupPostCode(Rec, PostCode);
            end;

            trigger OnValidate()
            begin
                OnBeforeValidatePostCode(Rec, PostCode);

                PostCodeCheck.VerifyPostCode(
                  CurrFieldNo, Database::"Ship-to Address", Rec.GetPosition(), 0,
                  FS_RF_Name, FS_RF_Name2, FS_RF_Contact, FS_RF_Address, FS_RF_Address2, FS_RF_City, FS_RF_PostCode, FS_RF_County, FS_RF_CountryRegionCode);
            end;
        }
        field(17; FS_RF_County; Text[30])
        {
            CaptionClass = '5,1,' + FS_RF_CountryRegionCode;
            Caption = 'County';
        }
        field(18; FS_RF_Email; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                ValidateEmail()
            end;
        }
        field(19; FS_RF_HomePage; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(20; FS_RF_TaxAreaCode; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(21; FS_RF_TaxLiable; Boolean)
        {
            Caption = 'Tax Liable';
        }
    }

    keys
    {
        key(Key1; FS_RF_VendorNo, FS_RF_Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; FS_RF_Code, FS_RF_Name, FS_RF_Address, FS_RF_City, FS_RF_PostCode)
        {
        }
    }

    trigger OnDelete()
    begin
        DeleteAllAddressID(Database::FS_RF_ContractorShipToAddress, Rec.GetPosition());
    end;

    trigger OnInsert()
    begin
        Vendor.Get(FS_RF_VendorNo);
        FS_RF_Name := Vendor.Name;
    end;

    trigger OnModify()
    begin
        FS_RF_LastDateModified := Today;
    end;

    trigger OnRename()
    begin
        FS_RF_LastDateModified := Today;
        MoveAllAddressID(Database::FS_RF_ContractorShipToAddress, xRec.GetPosition(), Database::FS_RF_ContractorShipToAddress, Rec.GetPosition());
    end;

    var
        Vendor: Record Vendor;
        PostCode: Record "Post Code";
        PostCodeCheck: Codeunit "Post Code Check";
        FS_RF_PostCodeCheck: Codeunit FS_RF_PostCodeCheck;
        UntitledLbl: Label 'untitled';
        OnlineMapSetupRequiredLbl: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';

    procedure Caption(): Text
    begin
        if FS_RF_VendorNo = '' then
            exit(UntitledLbl);
        Vendor.Get(FS_RF_VendorNo);
        exit(StrSubstNo('%1 %2 %3 %4', Vendor."No.", Vendor.Name, FS_RF_Code, FS_RF_Name));
    end;

    procedure DisplayMap()
    var
        OnlineMapSetup: Record "Online Map Setup";
        OnlineMapManagement: Codeunit "Online Map Management";
    begin
        OnlineMapSetup.SetRange(Enabled, true);
        if not OnlineMapSetup.IsEmpty() then begin
            OnlineMapManagement.MakeSelection(Database::"Ship-to Address", GetPosition())
        end else begin
            Message(OnlineMapSetupRequiredLbl);
        end;
    end;

    procedure GetFilterVendorNo(): Code[20]
    begin
        if GetFilter(FS_RF_VendorNo) <> '' then
            if GetRangeMin(FS_RF_VendorNo) = GetRangeMax(FS_RF_VendorNo) then
                exit(GetRangeMax(FS_RF_VendorNo));
    end;

    local procedure ValidateEmail()
    var
        MailManagement: Codeunit "Mail Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeValidateEmail(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        MailManagement.ValidateEmailAddressField(FS_RF_Email);
    end;

    procedure MoveAddressID(FromTableNo: Integer; FromTableKey: Text[1024]; FromAddressType: Option Main,"Bill-to","Ship-to","Sell-to","Pay-to","Buy-from","Transfer-from","Transfer-to"; ToTableNo: Integer; ToTableKey: Text[1024]; ToAddressType: Option Main,"Bill-to","Ship-to","Sell-to","Pay-to","Buy-from","Transfer-from","Transfer-to")
    var
        FromAddressID: Record "Address ID";
        ToAddressID: Record "Address ID";
    begin
        if FromAddressID.Get(FromTableNo, FromTableKey, FromAddressType) then begin
            if not ToAddressID.Get(ToTableNo, ToTableKey, ToAddressType) then begin
                ToAddressID.Init();
                ToAddressID := FromAddressID;
                ToAddressID."Table No." := ToTableNo;
                ToAddressID."Table Key" := ToTableKey;
                ToAddressID."Address Type" := ToAddressType;
                ToAddressID.Insert();
            end else begin
                ToAddressID := FromAddressID;
                ToAddressID."Table No." := ToTableNo;
                ToAddressID."Table Key" := ToTableKey;
                ToAddressID."Address Type" := ToAddressType;
                ToAddressID.Modify();
            end;
            FromAddressID.Delete();
        end else
            if ToAddressID.Get(ToTableNo, ToTableKey, ToAddressType) then
                ToAddressID.Delete();
    end;

    procedure MoveAllAddressID(FromTableNo: Integer; FromTableKey: Text[1024]; ToTableNo: Integer; ToTableKey: Text[1024])
    var
        FromAddressID: Record "Address ID";
        ToAddressID: Record "Address ID";
    begin
        FromAddressID.SetRange("Table No.", FromTableNo);
        FromAddressID.SetRange("Table Key", FromTableKey);
        ToAddressID.SetRange("Table No.", ToTableNo);
        ToAddressID.SetRange("Table Key", ToTableKey);
        ToAddressID.DeleteAll();
        if FromAddressID.Find('-') then
            repeat
                ToAddressID.Init();
                ToAddressID := FromAddressID;
                ToAddressID."Table No." := ToTableNo;
                ToAddressID."Table Key" := ToTableKey;
                ToAddressID.Insert();
            until FromAddressID.Next() = 0;

        FromAddressID.DeleteAll();
    end;


    procedure DeleteAddressID(TableNo: Integer; TableKey: Text[1024]; AddressType: Option Main,"Bill-to","Ship-to","Sell-to","Pay-to","Buy-from","Transfer-from","Transfer-to")
    var
        AddressID: Record "Address ID";
    begin
        AddressID.SetRange("Table No.", TableNo);
        AddressID.SetRange("Table Key", TableKey);
        AddressID.SetRange("Address Type", AddressType);
        AddressID.DeleteAll();
    end;

    procedure DeleteAllAddressID(TableNo: Integer; TableKey: Text[1024])
    var
        AddressID: Record "Address ID";
    begin
        AddressID.SetRange("Table No.", TableNo);
        AddressID.SetRange("Table Key", TableKey);
        AddressID.DeleteAll();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLookupPostCode(var ShipToAddress: Record FS_RF_ContractorShipToAddress; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLookupCity(var ShipToAddress: Record FS_RF_ContractorShipToAddress; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookupCity(var ShipToAddress: Record FS_RF_ContractorShipToAddress; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookupPostCode(var ShipToAddress: Record FS_RF_ContractorShipToAddress; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateCity(ShipToAddress: Record FS_RF_ContractorShipToAddress; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateEmail(var ShiptoAddress: Record FS_RF_ContractorShipToAddress; xShiptoAddress: Record FS_RF_ContractorShipToAddress; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidatePostCode(ShipToAddress: Record FS_RF_ContractorShipToAddress; var PostCodeRec: Record "Post Code");
    begin
    end;
}

