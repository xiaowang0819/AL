page 50501 FS_RF_ContractorShipToAddress
{
    Caption = 'Contractor Ship-to Address';
    DataCaptionExpression = Rec.Caption();
    PageType = Card;
    SourceTable = FS_RF_ContractorShipToAddress;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                group(Control3)
                {
                    ShowCaption = false;

                    field(FS_RF_Code; Rec.FS_RF_Code)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies a ship-to address code.';
                    }
                    field(FS_RF_Name; Rec.FS_RF_Name)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the name associated with the ship-to address.';
                    }
                    field(FS_RF_Address; Rec.FS_RF_Address)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the ship-to address.';
                    }
                    field(FS_RF_Address2; Rec.FS_RF_Address2)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(FS_RF_City; Rec.FS_RF_City)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the city the items are being shipped to.';
                    }
                    group(Control13)
                    {
                        ShowCaption = false;
                        Visible = IsCountyVisible;

                        field(FS_RF_County; Rec.FS_RF_County)
                        {
                            ApplicationArea = Basic, Suite;
                            ToolTip = 'Specifies the state, province, or county as a part of the address.';
                        }
                    }
                    field(FS_RF_PostCode; Rec.FS_RF_PostCode)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field(FS_RF_CountryRegionCode; Rec.FS_RF_CountryRegionCode)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible:=FormatAddress.UseCounty(Rec.FS_RF_CountryRegionCode);
                        end;
                    }
                    field(ShowMap; ShowMapLbl)
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = true;
                        ToolTip = 'Specifies the Vendor''s address on your preferred map website.';

                        trigger OnDrillDown()
                        begin
                            CurrPage.Update(true);
                            Rec.DisplayMap();
                        end;
                    }
                }
                field(FS_RF_PhoneNo; Rec.FS_RF_PhoneNo)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the recipient''s telephone number.';
                }
                field(FS_RF_Contact; Rec.FS_RF_Contact)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person you contact about orders shipped to this address.';
                }
                field(FS_RF_FaxNo; Rec.FS_RF_FaxNo)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the recipient''s fax number.';
                }
                field(FS_RF_Email; Rec.FS_RF_Email)
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = EMail;
                    Importance = Additional;
                    ToolTip = 'Specifies the recipient''s email address.';
                }
                field(FS_RF_HomePage; Rec.FS_RF_HomePage)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the recipient''s web site.';
                }
                field(FS_RF_LastDateModified; Rec.FS_RF_LastDateModified)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies when the ship-to address was last modified.';
                }
                field(FS_RF_VendorNo; Rec.FS_RF_VendorNo)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Vendor number.';
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group("&Address")
            {
                Caption = '&Address';
                Image = Addresses;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        IsCountyVisible:=FormatAddress.UseCounty(Rec.FS_RF_CountryRegionCode);
    end;
    trigger OnAfterGetRecord()
    begin
        IsCountyVisible:=FormatAddress.UseCounty(Rec.FS_RF_CountryRegionCode);
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        Vendor: Record Vendor;
        IsHandled: Boolean;
    begin
        if not Vendor.Get(Rec.GetFilterVendorNo())then exit;
        IsHandled:=false;
        OnBeforeOnNewRecord(Vendor, IsHandled, Rec);
        if IsHandled then exit;
        Rec.Validate(FS_RF_Name, Vendor.Name);
        Rec.Validate(FS_RF_Address, Vendor.Address);
        Rec.Validate(FS_RF_Address2, Vendor."Address 2");
        Rec.FS_RF_CountryRegionCode:=Vendor."Country/Region Code";
        Rec.FS_RF_City:=Vendor.City;
        Rec.FS_RF_County:=Vendor.County;
        Rec.FS_RF_PostCode:=Vendor."Post Code";
        Rec.Validate(FS_RF_Contact, Vendor.Contact);
        OnAfterOnNewRecord(Vendor, Rec);
    end;
    trigger OnOpenPage()
    begin
        IsCountyVisible:=FormatAddress.UseCounty(Rec.FS_RF_CountryRegionCode);
    end;
    var FormatAddress: Codeunit "Format Address";
    ShowMapLbl: Label 'Show on Map';
    IsCountyVisible: Boolean;
    [IntegrationEvent(false, false)]
    local procedure OnAfterOnNewRecord(var Vendor: Record Vendor; var ShipToAddress: Record FS_RF_ContractorShipToAddress)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnNewRecord(var Vendor: Record Vendor; var IsHandled: Boolean; var ShipToAddress: Record FS_RF_ContractorShipToAddress)
    begin
    end;
}
