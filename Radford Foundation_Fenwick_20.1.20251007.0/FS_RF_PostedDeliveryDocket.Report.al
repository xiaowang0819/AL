report 50003 FS_RF_PostedDeliveryDocket
{
    WordLayout = './layouts/PostedDeliveryDocket.docx';
    Caption = 'Posted Delivery Docket';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';

            column(No_SalesShptHeader; "No.")
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(SellToContactName; "Sell-to Contact")
            {
            }
            column(PageCaption; PageCaptionCap)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo1Picture; CompanyInfo1.Picture)
            {
            }
            column(CompanyInfo2Picture; CompanyInfo2.Picture)
            {
            }
            column(CompanyInfo3Picture; CompanyInfo3.Picture)
            {
            }
            column(SalesShptCopyText; StrSubstNo(Text002, CopyText))
            {
            }
            column(ShipToAddr1; ShipToAddr[1])
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(ShipToAddr2; ShipToAddr[2])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(ShipToAddr3; ShipToAddr[3])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(ShipToAddr4; ShipToAddr[4])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(ShipToAddr5; ShipToAddr[5])
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(ShipToAddr6; ShipToAddr[6])
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber())
            {
            }
            column(CompanyInfoEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName; CompanyBankAccount.Name)
            {
            }
            column(CompanyInfoBankAccNo; CompanyBankAccount."Bank Account No.")
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(UnitofMeasureCaption; UnitofMeasureCaptionLbl)
            {
            }
            column(SelltoCustNo_SalesShptHeader; Header."Sell-to Customer No.")
            {
            }
            column(ShptHeaderDocDate; Format(Header."Document Date"))
            {
            }
            column(ExtDocNo_SalesHeader; "External Document No.")
            {
            }
            column(SalesPersonText; SalesPersonText)
            {
            }
            column(SalesPurchPersonName; SalesPurchPerson.Name)
            {
            }
            column(ReferenceText; ReferenceText)
            {
            }
            column(YourReference_SalesShptHeader; Header."Your Reference")
            {
            }
            column(ShipToAddr7; ShipToAddr[7])
            {
            }
            column(ShipToAddr8; ShipToAddr[8])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
            {
            }
            column(ShipmentDate_SalesShptHeader; Format(Header."Shipment Date"))
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(CompanyInfoABNDivisionPartNo; CompanyInfo."ABN Division Part No.")
            {
            }
            column(CompanyInfoABN; CompanyInfo.ABN)
            {
            }
            column(ItemTrackingAppendixCaption; ItemTrackingAppendixCaptionLbl)
            {
            }
            column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
            {
            }
            column(CompanyInfoVATRegistrationNoCaption; CompanyInfoVATRegistrationNoCaptionLbl)
            {
            }
            column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
            {
            }
            column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
            {
            }
            column(CompanyInfoBankAccountNoCaption; CompanyInfoBankAccountNoCaptionLbl)
            {
            }
            column(SalesShipmentHeaderNoCaption; SalesShipmentHeaderNoCaptionLbl)
            {
            }
            column(SalesShipmentHeaderShipmentDateCaption; SalesShipmentHeaderShipmentDateCaptionLbl)
            {
            }
            column(CompanyInfoABNCaption; CompanyInfoABNCaptionLbl)
            {
            }
            column(CompanyInfoABNDivisionPartNoCaption; CompanyInfoABNDivisionPartNoCaptionLbl)
            {
            }
            column(SelltoCustNo_SalesShptHeaderCaption; Header.FieldCaption("Sell-to Customer No."))
            {
            }
            column(OrderNoCaption_SalesShptHeader; OurDocumentNoLbl)
            {
            }
            column(OrderNo_SalesShptHeader; Header."Order No.")
            {
            }
            column(ExternalDocumentNoCaption_SalesShptHeader; PurchaseOrderNoLbl)
            {
            }
            column(ExternalDocumentNo_SalesShptHeader; Header."External Document No.")
            {
            }
            column(Contact; Header."Sell-to Contact")
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            dataitem(Line; "Sales Shipment Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.")where(Type=filter(Item));

                column(Description_Line; Description)
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                }
                column(ShipmentDate_Line; Format("Shipment Date"))
                {
                }
                column(Description_SalesShptLine; Description)
                {
                IncludeCaption = false;
                }
                column(ShowInternalInfo; ShowInternalInfo)
                {
                }
                column(ShowCorrectionLines; ShowCorrectionLines)
                {
                }
                column(Type_SalesShptLine; Format(Type, 0, 2))
                {
                }
                column(AsmHeaderExists; AsmHeaderExists)
                {
                }
                column(DocumentNo_SalesShptLine; "Document No.")
                {
                }
                column(LinNo; LinNo)
                {
                }
                column(ItemReferenceNo_Line; "Item Reference No.")
                {
                }
                column(ItemReferenceNo_Line_Lbl; FieldCaption("Item Reference No."))
                {
                }
                column(Qty_SalesShptLine; Quantity)
                {
                }
                column(UnitofMeasure_SalesShptLine; "Unit of Measure")
                {
                }
                column(No_SalesShptLine; "No.")
                {
                }
                column(LineNo_SalesShptLine; "Line No.")
                {
                }
                column(SalesShipmentLineNoCaption; FieldCaption("No."))
                {
                }
                column(Quantity_SalesShptLineCaption; FieldCaption(Quantity))
                {
                }
                column(UnitofMeasure_SalesShptLineCaption; FieldCaption("Unit of Measure"))
                {
                }
                column(LineComment; LineComment)
                {
                }
                column(state; Header."Sell-to County")
                {
                }
                column(ShipTostate; Header."Ship-to County")
                {
                }
                dataitem(DimensionLoop2; "Integer")
                {
                    DataItemTableView = sorting(Number)where(Number=filter(1..));

                    column(DimText1; DimText)
                    {
                    }
                    column(DimLoopNumber; DimensionLoop2.Number)
                    {
                    }
                    column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if Number = 1 then begin
                            if not DimSetEntry2.FindSet()then CurrReport.Break();
                        end
                        else
                        begin
                            if not Continue then begin
                                CurrReport.Break();
                            end;
                        end;
                        Clear(DimText);
                        Continue:=false;
                        repeat OldDimText:=DimText;
                            if DimText = '' then DimText:=StrSubstNo('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                            else
                                DimText:=StrSubstNo('%1; %2 - %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                            if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                DimText:=OldDimText;
                                Continue:=true;
                                exit;
                            end;
                        until DimSetEntry2.Next() = 0;
                    end;
                    trigger OnPreDataItem()
                    begin
                        if not ShowInternalInfo then CurrReport.Break();
                    end;
                }
                dataitem(DisplayAsmInfo; "Integer")
                {
                    column(PostedAsmLineUnitofMeasureCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                    {
                    }
                    column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(PostedAsmLineDescription; BlanksForIndent() + PostedAsmLine.Description)
                    {
                    }
                    column(PostedAsmLineItemNo; BlanksForIndent() + PostedAsmLine."No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        ItemTranslation: Record "Item Translation";
                    begin
                        if Number = 1 then PostedAsmLine.FindSet()
                        else
                            PostedAsmLine.Next();
                        if ItemTranslation.Get(PostedAsmLine."No.", PostedAsmLine."Variant Code", Header."Language Code")then PostedAsmLine.Description:=ItemTranslation.Description;
                    end;
                    trigger OnPreDataItem()
                    begin
                        if not DisplayAssemblyInformation then CurrReport.Break();
                        if not AsmHeaderExists then CurrReport.Break();
                        PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                        SetRange(Number, 1, PostedAsmLine.Count);
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    i: Integer;
                begin
                    LinNo:="Line No.";
                    if not ShowCorrectionLines and Correction then CurrReport.Skip();
                    DimSetEntry2.SetRange("Dimension Set ID", "Dimension Set ID");
                    if DisplayAssemblyInformation then AsmHeaderExists:=AsmToShipmentExists(PostedAsmHeader);
                    LineComment:='';
                    SalesCommentLine.Reset();
                    SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::Shipment);
                    SalesCommentLine.SetRange("No.", Header."No.");
                    SalesCommentLine.SetRange("Document Line No.", Line."Line No.");
                    SalesCommentLine.SetFilter(Comment, '<>%1', '');
                    if SalesCommentLine.FindSet()then repeat i+=1;
                            if i = 1 then LineComment:=SalesCommentLine.Comment
                            else
                                LineComment:=LineComment + ' ' + SalesCommentLine.Comment;
                        until SalesCommentLine.Next() = 0;
                end;
                trigger OnPostDataItem()
                begin
                    if ShowLotSN then begin
                        ItemTrackingDocMgt.SetRetrieveAsmItemTracking(true);
                        TrackingSpecCount:=ItemTrackingDocMgt.RetrieveDocumentItemTracking(TrackingSpecBuffer, Header."No.", Database::"Sales Shipment Header", 0);
                        ItemTrackingDocMgt.SetRetrieveAsmItemTracking(false);
                    end;
                end;
                trigger OnPreDataItem()
                begin
                    MoreLines:=Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0)do MoreLines:=Next(-1) <> 0;
                    if not MoreLines then CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                end;
            }
            dataitem(Total; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));
            }
            dataitem(Total2; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(BilltoCustNo_SalesShptHeader; Header."Bill-to Customer No.")
                {
                }
                column(BilltoAddressCaption; BilltoAddressCaptionLbl)
                {
                }
                column(BilltoCustNo_SalesShptHeaderCaption; Header.FieldCaption("Bill-to Customer No."))
                {
                }
                trigger OnPreDataItem()
                begin
                    if not ShowCustAddr then CurrReport.Break();
                end;
            }
            dataitem(ItemTrackingLine; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(TrackingSpecBufferItemNo; TrackingSpecBuffer."Item No.")
                {
                }
                column(TrackingSpecBufferDescription; TrackingSpecBuffer.Description)
                {
                }
                column(TrackingSpecBufferLotNo; TrackingSpecBuffer."Lot No.")
                {
                }
                column(TrackingSpecBufferSerialNo; TrackingSpecBuffer."Serial No.")
                {
                }
                column(TrackingSpecBufferQty; TrackingSpecBuffer."Quantity (Base)")
                {
                }
                column(ShowTotal; ShowTotal)
                {
                }
                column(ShowGroup; ShowGroup)
                {
                }
                column(SerialNoCaption; SerialNoCaptionLbl)
                {
                }
                column(LotNoCaption; LotNoCaptionLbl)
                {
                }
                column(NoCaption; NoCaptionLbl)
                {
                }
                dataitem(TotalItemTracking; "Integer")
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(TotalQuantity; TotalQty)
                    {
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then TrackingSpecBuffer.FindSet()
                    else
                        TrackingSpecBuffer.Next();
                    if not ShowCorrectionLines and TrackingSpecBuffer.Correction then CurrReport.Skip();
                    if TrackingSpecBuffer.Correction then TrackingSpecBuffer."Quantity (Base)":=-TrackingSpecBuffer."Quantity (Base)";
                    ShowTotal:=false;
                    if ItemTrackingAppendix.IsStartNewGroup(TrackingSpecBuffer)then ShowTotal:=true;
                    ShowGroup:=false;
                    if(TrackingSpecBuffer."Source Ref. No." <> OldRefNo) or (TrackingSpecBuffer."Item No." <> OldNo)then begin
                        OldRefNo:=TrackingSpecBuffer."Source Ref. No.";
                        OldNo:=TrackingSpecBuffer."Item No.";
                        TotalQty:=0;
                    end
                    else
                        ShowGroup:=true;
                    TotalQty+=TrackingSpecBuffer."Quantity (Base)";
                end;
                trigger OnPreDataItem()
                begin
                    if TrackingSpecCount = 0 then CurrReport.Break();
                    SetRange(Number, 1, TrackingSpecCount);
                    TrackingSpecBuffer.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                end;
            }
            trigger OnPreDataItem()
            begin
                // Item Tracking:
                if ShowLotSN then begin
                    TrackingSpecCount:=0;
                    OldRefNo:=0;
                    ShowGroup:=false;
                end;
            end;
            trigger OnAfterGetRecord()
            begin
                TotalQty:=0;
                CurrReport.Language:=LanguageCodeunit.GetLanguageIdOrDefault("Language Code");
                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                if not CompanyBankAccount.Get(Header."Company Bank Account Code")then CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);
                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
                if not IsReportInPreviewMode()then Codeunit.Run(Codeunit::"Sales Shpt.-Printed", Header);
            end;
            trigger OnPostDataItem()
            begin
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if the document shows internal information.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the reports that you print as interactions.';
                    }
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Correction Lines';
                        ToolTip = 'Specifies if the correction lines of an undoing of quantity posting will be shown on the report.';
                    }
                    field(ShowLotSN; ShowLotSN)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Serial/Lot Number Appendix';
                        ToolTip = 'Specifies if you want to print an appendix to the sales shipment report showing the lot and serial numbers in the shipment.';
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable:=true;
        end;
        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        SalesSetup.Get();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
        CompanyInfo.CalcFields(Picture);
        OnAfterInitReport();
    end;
    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode()then if Header.FindSet()then repeat SegManagement.LogDocument(5, Header."No.", 0, 0, Database::Customer, Header."Sell-to Customer No.", Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", '');
                until Header.Next() = 0;
    end;
    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then InitLogInteraction();
        OnAfterOnPreReport(Header);
    end;
    var SalesPurchPerson: Record "Salesperson/Purchaser";
    CompanyBankAccount: Record "Bank Account";
    CompanyInfo: Record "Company Information";
    CompanyInfo1: Record "Company Information";
    CompanyInfo2: Record "Company Information";
    CompanyInfo3: Record "Company Information";
    SalesSetup: Record "Sales & Receivables Setup";
    DimSetEntry1: Record "Dimension Set Entry";
    DimSetEntry2: Record "Dimension Set Entry";
    SalesCommentLine: Record "Sales Comment Line";
    TrackingSpecBuffer: Record "Tracking Specification" temporary;
    PostedAsmHeader: Record "Posted Assembly Header";
    PostedAsmLine: Record "Posted Assembly Line";
    RespCenter: Record "Responsibility Center";
    ItemTrackingAppendix: Report "Item Tracking Appendix";
    LanguageCodeunit: Codeunit Language;
    FormatAddr: Codeunit "Format Address";
    FormatDocument: Codeunit "Format Document";
    SegManagement: Codeunit SegManagement;
    ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
    Text002: Label 'Delivery Docket %1', Comment = '%1 = Document No.';
    LineComment: Text;
    CustAddr: array[8]of Text[100];
    ShipToAddr: array[8]of Text[100];
    CompanyAddr: array[8]of Text[100];
    SalesPersonText: Text[20];
    ReferenceText: Text[80];
    MoreLines: Boolean;
    NoOfCopies: Integer;
    OutputNo: Integer;
    TrackingSpecCount: Integer;
    OldRefNo: Integer;
    OldNo: Code[20];
    CopyText: Text[30];
    ShowCustAddr: Boolean;
    DimText: Text[120];
    OldDimText: Text[75];
    ShowInternalInfo: Boolean;
    Continue: Boolean;
    LogInteraction: Boolean;
    ShowCorrectionLines: Boolean;
    ShowLotSN: Boolean;
    ShowTotal: Boolean;
    ShowGroup: Boolean;
    TotalQty: Decimal;
    [InDataSet]
    LogInteractionEnable: Boolean;
    DisplayAssemblyInformation: Boolean;
    AsmHeaderExists: Boolean;
    LinNo: Integer;
    PageCaptionCap: Label 'Page %1 of %2';
    QuantityCaptionLbl: Label 'Quantity';
    DescriptionCaptionLbl: Label 'Description';
    UnitofMeasureCaptionLbl: Label 'Unit of Measure';
    ItemTrackingAppendixCaptionLbl: Label 'Item Tracking - Appendix';
    CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
    CompanyInfoVATRegistrationNoCaptionLbl: Label 'VAT Registration No.';
    CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
    CompanyInfoBankNameCaptionLbl: Label 'Bank';
    CompanyInfoBankAccountNoCaptionLbl: Label 'Account No.';
    SalesShipmentHeaderNoCaptionLbl: Label 'Shipment No.';
    SalesShipmentHeaderShipmentDateCaptionLbl: Label 'Shipment Date';
    CompanyInfoABNCaptionLbl: Label 'ABN';
    CompanyInfoABNDivisionPartNoCaptionLbl: Label 'Division Part No.';
    LineDimensionsCaptionLbl: Label 'Line Dimensions';
    BilltoAddressCaptionLbl: Label 'Bill-to Address';
    SerialNoCaptionLbl: Label 'Serial No.';
    LotNoCaptionLbl: Label 'Lot No.';
    NoCaptionLbl: Label 'No.';
    DocumentDateCaptionLbl: Label 'Document Date';
    HomePageCaptionLbl: Label 'Home Page';
    EmailCaptionLbl: Label 'Email';
    OurDocumentNoLbl: Label 'Our Document No.';
    PurchaseOrderNoLbl: Label 'Purchase Order No.';
    procedure InitLogInteraction()
    begin
        LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Shpt. Note") <> '';
    end;
    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies:=NewNoOfCopies;
        ShowInternalInfo:=NewShowInternalInfo;
        LogInteraction:=NewLogInteraction;
        ShowCorrectionLines:=NewShowCorrectionLines;
        ShowLotSN:=NewShowLotSN;
        DisplayAssemblyInformation:=DisplayAsmInfo;
    end;
    local procedure IsReportInPreviewMode(): Boolean var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody());
    end;
    local procedure FormatAddressFields(SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        SalesShipmentHeader."Ship-to Contact":='';
        SalesShipmentHeader."Sell-to Contact":='';
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        ShowCustAddr:=FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
        FormatAddr.SalesShptSellTo(CustAddr, SalesShipmentHeader);
    end;
    local procedure FormatDocumentFields(SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesShipmentHeader."Salesperson Code", SalesPersonText);
        ReferenceText:=FormatDocument.SetText(SalesShipmentHeader."Your Reference" <> '', SalesShipmentHeader.FieldCaption("Your Reference"));
    end;
    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[50]var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode)then exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;
    procedure BlanksForIndent(): Text[10]begin
        exit(PadStr('', 2, ' '));
    end;
    [IntegrationEvent(true, false)]
    local procedure OnAfterInitReport()
    begin
    end;
    [IntegrationEvent(true, false)]
    local procedure OnAfterOnPreReport(var SalesShipmentHeader: Record "Sales Shipment Header")
    begin
    end;
}
