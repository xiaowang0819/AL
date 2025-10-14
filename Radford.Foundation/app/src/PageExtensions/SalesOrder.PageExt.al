pageextension 50015 FS_RF_SalesOrder extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field(FS_RF_ReadyForShipping; Rec.FS_RF_ReadyForShipping)
            {
                ApplicationArea = All;
            }
            field(FS_RF_Completed; Rec.FS_RF_Completed)
            {
                ApplicationArea = All;
            }
            field(FS_RF_InvoiceSubmitted; Rec.FS_RF_InvoiceSubmitted)
            {
                ApplicationArea = All;
            }
            field(FS_RF_ApprovedToPay; Rec.FS_RF_ApprovedToPay)
            {
                ApplicationArea = All;
            }
            field(FS_RF_CampaignNo; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."No.");
                if SalesLine.FindSet() then begin
                    repeat
                        SalesLine.FS_RF_FreightPrice := SalesLine.FS_RF_UpdateFreightPrice();
                        SalesLine.Modify();
                    until SalesLine.Next() = 0;
                end;
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."No.");
                if SalesLine.FindSet() then begin
                    repeat
                        SalesLine.FS_RF_FreightPrice := SalesLine.FS_RF_UpdateFreightPrice();
                        SalesLine.Modify();
                    until SalesLine.Next() = 0;
                end;
            end;
        }
        addafter(Status)
        {
            field(FS_RF_LinkedPI; Rec.FS_RF_LinkedPI)
            {
                ApplicationArea = All;
                Editable = false;
                trigger OnAssistEdit()
                begin
                    Rec.FS_RF_LookupPurchaseInvPage();
                end;
            }
            field(FS_RF_ApprForCustInvoice; Rec.FS_RF_ApprForCustInvoice)
            {
                ApplicationArea = All;
            }

            field(FS_RF_DocumentEmailSent; Rec.FS_RF_DocumentEmailSent)
            {
                ApplicationArea = All;

            }
        }
        addafter(ShippingOptions)
        {
            field(FS_RF_ContractorShipTo; Rec.FS_RF_ContractorShipTo)
            {
                ApplicationArea = All;
                Editable = ContractorEditable;
                trigger OnValidate()
                begin
                    if Rec.FS_RF_ContractorShipTo <> '' then
                        ShipToOptions := ShipToOptions::"Custom Address";
                end;
            }
        }
        modify("Work Description")
        {
            Visible = false;
        }
        addbefore("Shipping and Billing")
        {
            group(FS_RF_ServiceDetail)
            {
                Caption = 'Service Details';

                field(FS_RF_ServiceProvider; Rec.FS_RF_ServiceProvider)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(FS_RF_ServiceProviderName; Rec.FS_RF_ServiceProviderName)
                {
                    ApplicationArea = All;
                }
                field(FS_RF_PhoneNo; Rec.FS_RF_PhoneNo)
                {
                    ApplicationArea = All;
                }
                group(FS_RF_Shipping)
                {
                    ShowCaption = false;

                    field(FS_RF_ShippingOptions; FS_RF_ShipToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Store Location';
                        OptionCaption = 'Default (Service provider Address),Alternate Shipping Address,Custom Address';
                        ToolTip = 'Specifies the address that the products on the sales document are shipped to. Default (Service provider Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.';

                        trigger OnValidate()
                        var
                            ShipToAddress: Record "Ship-to Address";
                            ShipToAddressList: Page "Ship-to Address List";
                        begin
                            case FS_RF_ShipToOptions of
                                FS_RF_ShipToOptions::"Default (Service provider Address)":
                                    begin
                                        Rec.Validate(FS_RF_ShipToCode, '');
                                        Rec.FS_RF_CopySellToAddressToShipToAddress();
                                    end;
                                FS_RF_ShipToOptions::"Alternate Shipping Address":
                                    begin
                                        ShipToAddress.SetRange("Customer No.", Rec."Sell-to Customer No.");
                                        ShipToAddressList.LookupMode := true;
                                        ShipToAddressList.SetTableView(ShipToAddress);
                                        if ShipToAddressList.RunModal() = Action::LookupOK then begin
                                            ShipToAddressList.GetRecord(ShipToAddress);
                                            Rec.Validate(FS_RF_ShipToCode, ShipToAddress.Code);
                                            FS_RF_IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                        end
                                        else
                                            FS_RF_ShipToOptions := FS_RF_ShipToOptions::"Custom Address";
                                    end;
                                FS_RF_ShipToOptions::"Custom Address":
                                    begin
                                        Rec.Validate(FS_RF_ShipToCode, '');
                                        FS_RF_IsShipToCountyVisible := FormatAddress.UseCounty(Rec.FS_RF_ShipToCountryRegionCode);
                                    end;
                            end;
                        end;
                    }
                    group(FS_RF_Control4)
                    {
                        ShowCaption = false;
                        Visible = not (FS_RF_ShipToOptions = FS_RF_ShipToOptions::"Default (Service provider Address)");

                        field(FS_RF_ShipToCode; Rec.FS_RF_ShipToCode)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Code';
                            Editable = FS_RF_ShipToOptions = FS_RF_ShipToOptions::"Alternate Shipping Address";
                            Importance = Promoted;
                            ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                            trigger OnValidate()
                            var
                                ShipToAddress: Record "Ship-to Address";
                            begin
                                if (xRec.FS_RF_ShipToCode <> '') and (Rec.FS_RF_ShipToCode = '') then Error(EmptyShipToCodeErr);
                                if Rec.FS_RF_ShipToCode <> '' then begin
                                    ShipToAddress.Get(Rec."Sell-to Customer No.", Rec.FS_RF_ShipToCode);
                                    FS_RF_IsShipToCountyVisible := FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                                end
                                else
                                    FS_RF_IsShipToCountyVisible := false;
                            end;
                        }
                        field(FS_RF_ShipToName; Rec.FS_RF_ShipToName)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Name';
                            Editable = FS_RF_ShipToOptions = FS_RF_ShipToOptions::"Custom Address";
                            ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                        }
                        field(FS_RF_ShipToAddress; Rec.FS_RF_ShipToAddress)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address';
                            Editable = FS_RF_ShipToOptions = FS_RF_ShipToOptions::"Custom Address";
                            QuickEntry = false;
                            ToolTip = 'Specifies the address that products on the sales document will be shipped to.';
                        }
                        field(FS_RF_ShipToAddress2; Rec.FS_RF_ShipToAddress2)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address 2';
                            Editable = FS_RF_ShipToOptions = FS_RF_ShipToOptions::"Custom Address";
                            QuickEntry = false;
                            ToolTip = 'Specifies additional address information.';
                        }
                        field(FS_RF_ShipToCity; Rec.FS_RF_ShipToCity)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'City';
                            Editable = FS_RF_ShipToOptions = FS_RF_ShipToOptions::"Custom Address";
                            QuickEntry = false;
                            ToolTip = 'Specifies the city of the customer on the sales document.';
                        }
                        group(FS_RF_Control297)
                        {
                            ShowCaption = false;
                            Visible = FS_RF_IsShipToCountyVisible;

                            field(FS_RF_ShipToCounty; Rec.FS_RF_ShipToCounty)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'County';
                                Editable = FS_RF_ShipToOptions = FS_RF_ShipToOptions::"Custom Address";
                                QuickEntry = false;
                                ToolTip = 'Specifies the state, province or county of the address.';
                            }
                        }
                        field(FS_RF_ShipToPostCode; Rec.FS_RF_ShipToPostCode)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Post Code';
                            Editable = FS_RF_ShipToOptions = FS_RF_ShipToOptions::"Custom Address";
                            QuickEntry = false;
                            ToolTip = 'Specifies the postal code.';
                        }
                        field(FS_RF_ShipToCountryRegionCode; Rec.FS_RF_ShipToCountryRegionCode)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Country/Region';
                            Editable = FS_RF_ShipToOptions = FS_RF_ShipToOptions::"Custom Address";
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the customer''s country/region.';

                            trigger OnValidate()
                            begin
                                FS_RF_IsShipToCountyVisible := FormatAddress.UseCounty(Rec.FS_RF_ShipToCountryRegionCode);
                            end;
                        }
                    }
                    field(FS_RF_ShipToContact; Rec.FS_RF_ShipToContact)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                    }
                }
                group(FS_RF_WorkDescriptionGroup)
                {
                    Caption = 'Work Description';

                    field(FS_RF_WorkDescription; WorkDescription)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the products or service being offered.';

                        trigger OnValidate()
                        begin
                            Rec.SetWorkDescription(WorkDescription);
                        end;
                    }
                }
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(FS_RF_CalculateFreight)
            {
                Caption = 'Calculate Freight';
                ApplicationArea = All;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    TotalFreightPrice: Decimal;
                begin
                    Rec.FS_RF_CreateFreightSalesLine(TotalFreightPrice, SalesLine);
                end;
            }
        }
        modify(CreatePurchaseInvoice)
        {
            Visible = false;
        }
        addafter(CreatePurchaseInvoice)
        {
            action(FS_RF_CreatePurchaseInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Purchase Invoice';
                Image = NewPurchaseInvoice;
                Promoted = false;
                ToolTip = 'Create a new purchase invoice to buy all the items that are required by the sales document, even if some of the items are already available.';

                trigger OnAction()
                var
                    SalesSetup: Record "Sales & Receivables Setup";
                    SelectedSalesLine: Record "Sales Line";
                    PurchDocFromSalesDoc: Codeunit "Purch. Doc. From Sales Doc.";
                begin
                    CurrPage.SalesLines.Page.SetSelectionFilter(SelectedSalesLine);
                    if SalesSetup.Get() and SalesSetup.FS_RF_DisableServiceProvider then
                        PurchDocFromSalesDoc.CreatePurchaseInvoice(Rec, SelectedSalesLine)
                    else
                        Utilities.PurchDocFromSalesDoc_CreatePurchaseInvoice(Rec, SelectedSalesLine);
                end;
            }
        }
        addafter("Print Confirmation")
        {
            action(FS_RF_SendEmailServiceRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Service Request Email Confirmation';
                Ellipsis = true;
                Image = Email;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;
                ToolTip = 'Send a service request by email. The attachment is sent as a .pdf.';

                trigger OnAction()
                begin
                    Utilities.EmailSalesHeaderServiceRequest(Rec);
                end;
            }
        }
        addafter("Pick Instruction")
        {
            action(FS_RF_PrintDelDocket)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delivery Docket';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Print a delivery docket.';

                trigger OnAction()
                begin
                    Utilities.PrintDeliveryDocket(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        WorkDescription := Rec.GetWorkDescription();
        FS_RF_UpdateShipToGroupVisibility();
        ContractorEditable := Rec.FS_RF_ServiceProvider <> '';
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ContractorEditable := Rec.FS_RF_ServiceProvider <> '';
    end;

    trigger OnOpenPage()
    begin
        ActivateFields()
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesOrderTempl: Record FS_RF_SalesOrderTemplate;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesOrderTemplates: Page FS_RF_SalesOrderTemplateList;
    begin
        if not (SalesSetup.Get() and SalesSetup.FS_RF_DisableSalesOrderTempl) then begin
            SalesOrderTemplates.LookupMode := true;
            SalesOrderTemplates.Editable := false;
            if SalesOrderTemplates.RunModal() = Action::LookupOK then begin
                SalesOrderTemplates.GetRecord(SalesOrderTempl);
                SalesOrderTempl.TestField(FS_RF_NoSeries);
                NoSeriesMgt.InitSeries(NoSeriesMgt.GetNoSeriesWithCheck(SalesOrderTempl.FS_RF_NoSeries, false, Rec."No. Series"), xRec."No. Series", Rec."Posting Date", Rec."No.", Rec."No. Series");
            end
            else
                Error('');
        end;
        FS_RF_UpdateShipToGroupVisibility();
    end;

    var
        FormatAddress: Codeunit "Format Address";
        Utilities: Codeunit FS_RF_Utilities;
        WorkDescription: Text;
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        [InDataSet]
        ContractorEditable: Boolean;

    protected var
        FS_RF_ShipToOptions: Option "Default (Service provider Address)","Alternate Shipping Address","Custom Address";
        FS_RF_IsShipToCountyVisible: Boolean;

    local procedure ActivateFields()
    begin
        FS_RF_IsShipToCountyVisible := FormatAddress.UseCounty(Rec.FS_RF_ShipToCountryRegionCode);
    end;

    procedure FS_RF_UpdateShipToGroupVisibility()
    begin
        Utilities.CalculateShipToOptions(FS_RF_ShipToOptions, Rec);
    end;
}