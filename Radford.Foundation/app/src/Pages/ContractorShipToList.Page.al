page 50500 FS_RF_ContractorShipToList
{
    Caption = 'Contractor Ship-to Address List';
    CardPageId = FS_RF_ContractorShipToAddress;
    DataCaptionFields = FS_RF_VendorNo;
    Editable = false;
    PageType = List;
    SourceTable = FS_RF_ContractorShipToAddress;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Control1)
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
                    Visible = false;
                }
                field(FS_RF_Address2; Rec.FS_RF_Address2)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies additional address information.';
                    Visible = false;
                }
                field(FS_RF_PostCode; Rec.FS_RF_PostCode)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code.';
                    Visible = false;
                }
                field(FS_RF_City; Rec.FS_RF_City)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the city the items are being shipped to.';
                }
                field(FS_RF_CountryRegionCode; Rec.FS_RF_CountryRegionCode)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                    Visible = false;
                }
                field(FS_RF_PhoneNo; Rec.FS_RF_PhoneNo)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the recipient''s telephone number.';
                    Visible = false;
                }
                field(FS_RF_FaxNo; Rec.FS_RF_FaxNo)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the recipient''s fax number.';
                    Visible = false;
                }
                field(FS_RF_Contact; Rec.FS_RF_Contact)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person you contact about orders shipped to this address.';
                    Visible = false;
                }
                field(FS_RF_GLN; Rec.FS_RF_GLN)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the recipient''s GLN code.';
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
                action("Online Map")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Online Map';
                    Image = Map;
                    ToolTip = 'View the address on an online map.';

                    trigger OnAction()
                    begin
                        Rec.DisplayMap();
                    end;
                }
            }
        }
    }
}

