codeunit 50001 FS_RF_PostCodeCheck
{
    procedure VerifyAddress(CurrentFieldNo: Integer; TableNo: Integer; TableKey: Text; AddressType: Option Main, "Bill-to", "Ship-to", "Sell-to", "Pay-to", "Buy-from", "Transfer-from", "Transfer-to"; var Name: Text[100]; var Name2: Text[50]; var Contact: Text[100]; var Address: Text[100]; var Address2: Text[50]; var City: Text[30]; var PostCode: Code[20]; var County: Text[30]; var CountryCode: Code[10])
    begin
        if(PostCode = '') or (City = '') or (CurrentFieldNo = 0) or (not GuiAllowed)then exit;
        GetAddressValidationSetup(CountryCode);
        case Country."Address Validation" of Country."Address Validation"::"Entire Address", Country."Address Validation"::"Address ID": RunAddressValidation(TableNo, TableKey, AddressType, 3, Name, Name2, Contact, Address, Address2, City, PostCode, County, CountryCode);
        end;
    end;
    local procedure GetAddressValidationSetup(CountryCode: Code[10])
    begin
        if CountryCode = '' then begin
            GLSetup.Get();
            Clear(Country);
            Country."Address Validation":=GLSetup."Address Validation";
            Country."AMAS Software":=GLSetup."AMAS Software";
        end
        else
        begin
            Country.Get(CountryCode);
        end;
    end;
    local procedure RunAddressValidation(TableNo: Integer; TableKey: Text; AddressType: Option Main, "Bill-to", "Ship-to", "Sell-to", "Pay-to", "Buy-from", "Transfer-from", "Transfer-to"; ValidationType: Option " ", "GUI Only", "GUI Optional", "No GUI"; var Name: Text[100]; var Name2: Text[50]; var Contact: Text[100]; var Address: Text[100]; var Address2: Text[50]; var City: Text[30]; var PostCode: Code[20]; var County: Text[30]; var CountryCode: Code[10])
    var
        AddressID: Record "Address ID";
        TempAddressBuffer: Record "Address Buffer" temporary;
        TableKey2: Text[200];
    begin
        TableKey2:=CopyStr(TableKey, 1, 200);
        Country.TestField("AMAS Software");
        TempAddressBuffer.Init();
        TempAddressBuffer.Name:=Name;
        TempAddressBuffer."Name 2":=Name2;
        TempAddressBuffer.Contact:=Contact;
        TempAddressBuffer.Address:=Address;
        TempAddressBuffer."Address 2":=Address2;
        TempAddressBuffer.City:=City;
        TempAddressBuffer."Post Code":=PostCode;
        TempAddressBuffer.County:=County;
        TempAddressBuffer."Country/Region Code":=CountryCode;
        TempAddressBuffer."Validation Type":=ValidationType;
        TempAddressBuffer.Insert();
        CODEUNIT.Run(Country."AMAS Software", TempAddressBuffer);
        if(TempAddressBuffer."Address ID" <> '') or (TempAddressBuffer."Bar Code" <> '') or (TempAddressBuffer."Error Flag No." <> '')then if not AddressID.Get(TableNo, TableKey2, AddressType)then begin
                AddressID.Init();
                AddressID."Table No.":=TableNo;
                AddressID."Table Key":=TableKey2;
                AddressID."Address Type":=AddressType;
                AddressID.Validate("Address ID", TempAddressBuffer."Address ID");
                AddressID."Address Sort Plan":=TempAddressBuffer."Address Sort Plan";
                AddressID."Error Flag No.":=TempAddressBuffer."Error Flag No.";
                AddressID."Bar Code System":=TempAddressBuffer."Bar Code System";
                AddressID.Insert();
            end
            else
            begin
                AddressID.Validate("Address ID", TempAddressBuffer."Address ID");
                AddressID."Address Sort Plan":=TempAddressBuffer."Address Sort Plan";
                AddressID."Error Flag No.":=TempAddressBuffer."Error Flag No.";
                AddressID."Bar Code System":=TempAddressBuffer."Bar Code System";
                AddressID.Modify();
            end;
        if Country."Address Validation" = Country."Address Validation"::"Entire Address" then begin
            Name:=TempAddressBuffer.Name;
            Name2:=CopyStr(TempAddressBuffer."Name 2", 1, 50);
            Contact:=TempAddressBuffer.Contact;
            Address:=TempAddressBuffer.Address;
            Address2:=CopyStr(TempAddressBuffer."Address 2", 1, 50);
            City:=CopyStr(TempAddressBuffer.City, 1, 30);
            PostCode:=CopyStr(TempAddressBuffer."Post Code", 1, 20);
            County:=CopyStr(TempAddressBuffer.County, 1, 30);
            CountryCode:=CopyStr(TempAddressBuffer."Country/Region Code", 1, 10);
        end;
    end;
    var GLSetup: Record "General Ledger Setup";
    Country: Record "Country/Region";
}
