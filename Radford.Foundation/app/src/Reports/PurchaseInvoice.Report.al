report 50004 FS_RF_PurchaseInvoice
{
    WordLayout = './layouts/PurchaseInvoice.docx';
    Caption = 'Purchase - Invoice';
    PreviewMode = PrintLayout;
    DefaultLayout = Word;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Purch. Inv. Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Invoice';

            column(No_PurchInvHeader; "No.")
            {
            }
            column(InvDiscountAmtCaption; InvDiscountAmtCaptionLbl)
            {
            }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl)
            {
            }
            column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(AllowInvoiceDiscCaption; AllowInvoiceDiscCaptionLbl)
            {
            }
            column(BuyFromContactPhoneNoLbl; BuyFromContactPhoneNoLbl)
            {
            }
            column(BuyFromContactMobilePhoneNoLbl; BuyFromContactMobilePhoneNoLbl)
            {
            }
            column(BuyFromContactEmailLbl; BuyFromContactEmailLbl)
            {
            }
            column(PayToContactPhoneNoLbl; PayToContactPhoneNoLbl)
            {
            }
            column(PayToContactMobilePhoneNoLbl; PayToContactMobilePhoneNoLbl)
            {
            }
            column(PayToContactEmailLbl; PayToContactEmailLbl)
            {
            }
            column(BuyFromContactPhoneNo; BuyFromContact."Phone No.")
            {
            }
            column(BuyFromContactMobilePhoneNo; BuyFromContact."Mobile Phone No.")
            {
            }
            column(BuyFromContactEmail; BuyFromContact."E-Mail")
            {
            }
            column(PayToContactPhoneNo; PayToContact."Phone No.")
            {
            }
            column(PayToContactMobilePhoneNo; PayToContact."Mobile Phone No.")
            {
            }
            column(PayToContactEmail; PayToContact."E-Mail")
            {
            }
            column(No_Header; "No.")
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber())
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoEmail; CompanyInfo."E-Mail")
            {
            }
            column(DocumentCaption; StrSubstNo(DocumentCaption(), CopyText))
            {
            }
            column(VendorInvoiceNo; Header."Vendor Invoice No.")
            {
            }
            column(VendAddr1; VendAddr[1])
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(VendAddr2; VendAddr[2])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(VendAddr3; VendAddr[3])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(VendAddr4; VendAddr[4])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(VendAddr5; VendAddr[5])
            {
            }
            column(VendAddr6; VendAddr[6])
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(VendAddr7; VendAddr[7])
            {
            }
            column(VendAddr8; VendAddr[8])
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(FormatAddrPrintBarCode4; FormatAddr.PrintBarCode(4))
            {
            }
            column(CompanyInfoABNDivisionPartNo; CompanyInfo."ABN Division Part No.")
            {
            }
            column(CompanyInfoABN; CompanyInfo.ABN)
            {
            }
            column(PaytoVendNo_PurchInvHeader; Header."Pay-to Vendor No.")
            {
            }
            column(VATNoText; VATNoText)
            {
            }
            column(VATRegNo_PurchInvHeader; Header."VAT Registration No.")
            {
            }
            column(PurchaserText; PurchaserText)
            {
            }
            column(SalesPurchPersonName; SalesPurchPerson.Name)
            {
            }
            column(ReferenceText; ReferenceText)
            {
            }
            column(YourRef_PurchInvHeader; Header."Your Reference")
            {
            }
            column(DocDate_PurchInvHeader; Format(Header."Document Date", 0, 4))
            {
            }
            column(OrderNoText; OrderNoText)
            {
            }
            column(DueDate_PurchInvHeader; Format(Header."Due Date"))
            {
            }
            column(No1_PurchInvHeader; Header."No.")
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(OrderNo_PurchInvHeader; Header."Order No.")
            {
            }
            column(PostDate_PurchInvHeader; Format(Header."Posting Date"))
            {
            }
            column(PricesInclVAT_PurchInvHeader; Header."Prices Including VAT")
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(ShowInternalInfo; ShowInternalInfo)
            {
            }
            column(VATBaseDisc_PurchInvHeader; Header."VAT Base Discount %")
            {
            }
            column(PricesInclVATtxt; PricesInclVATtxt)
            {
            }
            column(ABN_PurchInvHeader; Header.ABN)
            {
            }
            column(ABNDivPartNo_PurchInvHeader; Header."ABN Division Part No.")
            {
            }
            column(PhoneNoCaption; PhoneNoCaptionLbl)
            {
            }
            column(VATRegNoCaption; VATRegNoCaptionLbl)
            {
            }
            column(GiroNoCaption; GiroNoCaptionLbl)
            {
            }
            column(BankNameCaption; BankNameCaptionLbl)
            {
            }
            column(BankAccNoCaption; BankAccNoCaptionLbl)
            {
            }
            column(ABNCaption; ABNCaptionLbl)
            {
            }
            column(ABNDivisionPartNoCaption; ABNDivisionPartNoCaptionLbl)
            {
            }
            column(InvoiceNoCaption; InvoiceNoCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(EmailCaption; EMailCaptionLbl)
            {
            }
            column(HomepageCaption; HomePageCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(PaytoVendNo_PurchInvHeaderCaption; Header.FieldCaption("Pay-to Vendor No."))
            {
            }
            column(PricesInclVAT_PurchInvHeaderCaption; Header.FieldCaption("Prices Including VAT"))
            {
            }
            column(VATPercentCaption; VATPercentCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATAmounttSpecCaption; VATAmounttSpecCaptionLbl)
            {
            }
            column(InvDiscBaseAmountCaption; InvDiscBaseAmountCaptionLbl)
            {
            }
            column(LineAmountCaption; LineAmountCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem(DimensionLoop1; "Integer")
            {
                DataItemLinkReference = Header;
                DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                column(DimText; DimText)
                {
                }
                column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then begin
                        if not DimSetEntry1.FindSet() then CurrReport.Break();
                    end
                    else begin
                        if not Continue then begin
                            CurrReport.Break();
                        end;
                    end;
                    Clear(DimText);
                    Continue := false;
                    repeat
                        OldDimText := DimText;
                        if DimText = '' then
                            DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                        else
                            DimText := StrSubstNo('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                        if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                            DimText := OldDimText;
                            Continue := true;
                            exit;
                        end;
                    until DimSetEntry1.Next() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowInternalInfo then CurrReport.Break();
                end;
            }
            dataitem(Line; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");

                column(LineAmount_PurchInvLine; "Line Amount")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(Description_PurchInvLine; Description)
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(LineNo_Line; "Line No.")
                {
                }
                column(No_Line; Line."No.")
                {
                }
                column(Quantity_PurchInvLine; Quantity)
                {
                }
                column(UOM_PurchInvLine; "Unit of Measure")
                {
                }
                column(DirectUnitCost_PurchInvLine; "Direct Unit Cost")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 2;
                }
                column(LineDiscount_PurchInvLine; "Line Discount %")
                {
                }
                column(AllowInvDisc_PurchInvLine; "Allow Invoice Disc.")
                {
                    IncludeCaption = false;
                }
                column(VATIdentifier_PurchInvLine; "VAT Identifier")
                {
                }
                column(LineNo_PurchInvLine; "Line No.")
                {
                }
                column(AllowVATDisctxt; AllowVATDisctxt)
                {
                }
                column(PurchInLineTypeNo; PurchInLineTypeNo)
                {
                }
                column(VATAmountText; VATAmountText)
                {
                }
                column(InvDiscAmt_PurchInvLine; -"Inv. Discount Amount")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(TotalText; TotalText)
                {
                }
                column(Amount_PurchInvLine; Amount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(AmtInclVAT_PurchInvLine; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncludingVATAmount; "Amount Including VAT" - Amount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText())
                {
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalInclVATTextLCY; TotalInclVATTextLCY)
                {
                }
                column(CurrFactor_PurchInvHeader; Header."Currency Factor")
                {
                }
                column(TotalExclVATTextLCY; TotalExclVATTextLCY)
                {
                }
                column(AmountLCY; AmountLCY)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncLCYAmountLCY; AmountIncLCY - AmountLCY)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncLCY; AmountIncLCY)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(CurrencyLCY; CurrencyLCY)
                {
                }
                column(CurrCode_PurchInvHeader; Header."Currency Code")
                {
                }
                column(AmountLangB1AmountLangB2; AmountLangB[1] + ' ' + AmountLangB[2])
                {
                }
                column(AmountLangA1AmountLangA2; AmountLangA[1] + ' ' + AmountLangA[2])
                {
                }
                column(AmountInWords; AmountInWords)
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmount; TotalAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(PaymentDiscVATCaption; PaymentDiscVATCaptionLbl)
                {
                }
                column(ExchangeRateCaption; ExchangeRateCaptionLbl)
                {
                }
                column(Description_PurchInvLineCaption; FieldCaption(Description))
                {
                }
                column(No_PurchInvLineCaption; FieldCaption("No."))
                {
                }
                column(Quantity_PurchInvLineCaption; FieldCaption(Quantity))
                {
                }
                column(UOM_PurchInvLineCaption; FieldCaption("Unit of Measure"))
                {
                }
                column(VATIdentifier_PurchInvLineCaption; FieldCaption("VAT Identifier"))
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if (Type = Type::"G/L Account") then "No." := '';
                    VATAmountLine.Init();
                    VATAmountLine."VAT Identifier" := "VAT Identifier";
                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."Use Tax" := "Use Tax";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."VAT Amount" := "Amount Including VAT" - Amount;
                    VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    VATAmountLine."Line Amount" := "Line Amount";
                    if "Allow Invoice Disc." then VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    VATAmountLine.InsertLine();
                    AllowVATDisctxt := Format("Allow Invoice Disc.");
                    PurchInLineTypeNo := Type.AsInteger();
                    PurchInLineTypeNo := Type.AsInteger();
                    TotalSubTotal += "Line Amount";
                    TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                    FormattedVATPct := Format(Line."VAT %");
                end;

                trigger OnPreDataItem()
                var
                    PurchInvLine: Record "Purch. Inv. Line";
                    VATIdentifier: Code[20];
                begin
                    VATAmountLine.DeleteAll();
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do MoreLines := Next(-1) <> 0;
                    if not MoreLines then CurrReport.Break();
                    // SetRange("Line No.", 0, "Line No.");
                    PurchInvLine.SetRange("Document No.", Header."No.");
                    PurchInvLine.SetFilter(Type, '<>%1', 0);
                    VATAmountText := '';
                    if PurchInvLine.Find('-') then begin
                        VATAmountText := StrSubstNo(Text011, PurchInvLine."VAT %");
                        VATIdentifier := PurchInvLine."VAT Identifier";
                        repeat
                            if (PurchInvLine."VAT Identifier" <> VATIdentifier) and (PurchInvLine.Quantity <> 0) then VATAmountText := Text012;
                        until PurchInvLine.Next() = 0;
                    end;
                end;
            }
            dataitem(VATCounter; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineInvoiceDiscAmt; VATAmountLine."Invoice Discount Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmountLineVAT; VATAmountLine."VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    VATAmountLine.GetLine(Number);
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, VATAmountLine.Count);
                end;
            }
            dataitem(VATCounterLCY; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(VALExchRate; VALExchRate)
                {
                }
                column(VALSpecLCYHeader; VALSpecLCYHeader)
                {
                }
                column(VALVATAmountLCY; VALVATAmountLCY)
                {
                    AutoFormatType = 1;
                }
                column(VALVATBaseLCY; VALVATBaseLCY)
                {
                    AutoFormatType = 1;
                }
                column(VATAmountLineVAT1; VATAmountLine."VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    VATAmountLine.GetLine(Number);
                    VALVATBaseLCY := VATAmountLine.GetBaseLCY(Header."Posting Date", Header."Currency Code", Header."Currency Factor");
                    VALVATAmountLCY := VATAmountLine.GetAmountLCY(Header."Posting Date", Header."Currency Code", Header."Currency Factor");
                end;

                trigger OnPreDataItem()
                begin
                    if (not GLSetup."Print VAT specification in LCY") or (Header."Currency Code" = '') then CurrReport.Break();
                    SetRange(Number, 1, VATAmountLine.Count);
                    Clear(VALVATBaseLCY);
                    Clear(VALVATAmountLCY);
                    if GLSetup."LCY Code" = '' then
                        VALSpecLCYHeader := Text007 + Text008
                    else
                        VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");
                    CurrExchRate.FindCurrency(Header."Posting Date", Header."Currency Code", 1);
                    CalculatedExchRate := Round(1 / Header."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                    VALExchRate := StrSubstNo(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                end;
            }
            dataitem(Total; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                column(TotalInvDiscountAmount; TotalInvoiceDiscountAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountInclVAT; TotalAmountInclVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountVAT; TotalAmountVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
                {
                    AutoFormatType = 1;
                }
                column(DirectUnitCostCaption; DirectUnitCostCaptionLbl)
                {
                }
                column(DiscountPercentCaption; DiscountPercentCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
            }
            dataitem(Total2; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                column(BuyfromVendNo_PurchInvHeader; Header."Buy-from Vendor No.")
                {
                }
                column(BuyfromVendNo_PurchInvHeaderCaption; Header.FieldCaption("Buy-from Vendor No."))
                {
                }
                trigger OnPreDataItem()
                begin
                    if Header."Buy-from Vendor No." = Header."Pay-to Vendor No." then CurrReport.Break();
                end;
            }
            dataitem(Total3; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                column(ShipToAddr1; ShipToAddr[1])
                {
                }
                column(ShipToAddr2; ShipToAddr[2])
                {
                }
                column(ShipToAddr3; ShipToAddr[3])
                {
                }
                column(ShipToAddr4; ShipToAddr[4])
                {
                }
                column(ShipToAddr5; ShipToAddr[5])
                {
                }
                column(ShipToAddr6; ShipToAddr[6])
                {
                }
                column(ShipToAddr7; ShipToAddr[7])
                {
                }
                column(ShipToAddr8; ShipToAddr[8])
                {
                }
                column(ShipToAddressCaption; ShipToAddressCaptionLbl)
                {
                }
                trigger OnPreDataItem()
                begin
                    if ShipToAddr[1] = '' then CurrReport.Break();
                end;
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = sorting("Line No.");
                UseTemporary = true;

                column(Description_ReportTotalsLine; Description)
                {
                }
                column(Amount_ReportTotalsLine; Amount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                }
                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines();
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TotalSubTotal := 0;
                TotalInvoiceDiscountAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscountOnVAT := 0;
                CurrReport.Language := LanguageCodeunit.GetLanguageIdOrDefault("Language Code");
                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                if BuyFromContact.Get("Buy-from Contact No.") then;
                if PayToContact.Get("Pay-to Contact No.") then;
                PricesInclVATtxt := Format("Prices Including VAT");
                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
                CalcFields(Amount);
                CalcFields("Amount Including VAT");
                AmountLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate(), "Currency Code", Amount, "Currency Factor"));
                AmountIncLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate(), "Currency Code", "Amount Including VAT", "Currency Factor"));
                PurchaseLine.InitTextVariable();
                PurchaseLine.FormatNoText(AmountLangA, "Amount Including VAT", "Currency Code");
                if ShowTHFormatting then begin
                    PurchaseLine.InitTextVariableTH();
                    PurchaseLine.FormatNoTextTH(AmountLangB, "Amount Including VAT", "Currency Code");
                end
                else begin
                    AmountLangB[1] := '';
                    AmountLangB[2] := '';
                end;
                if not IsReportInPreviewMode() then Codeunit.Run(Codeunit::"Purch. Inv.-Printed", Header);
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
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field(ShowTotalInWords; AmountInWords)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Total In Words';
                        ToolTip = 'Specifies that you want to print total amounts as words.';
                    }
                    field(ShowLCYForFCY; CurrencyLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show LCY for FCY';
                        ToolTip = 'Specifies if you want to use your own currency instead of the currency of your customers or vendors.';
                    }
                    field(ShowTHAmountInWords; ShowTHFormatting)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show TH Amount In Words';
                        ToolTip = 'Specifies that you want to print Thai amounts as words.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        OnAfterInitReport();
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if Header.FindSet() then
                repeat
                    SegManagement.LogDocument(14, Header."No.", 0, 0, Database::Vendor, Header."Buy-from Vendor No.", Header."Purchaser Code", '', Header."Posting Description", '');
                until Header.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then InitLogInteraction();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        BuyFromContact: Record Contact;
        PayToContact: Record Contact;
        LanguageCodeunit: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        Text004: Label 'Purchase - Invoice %1', Comment = '%1 = Document No.';
        VendAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        OrderNoText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        TotalInclVATTextLCY: Text[50];
        TotalExclVATTextLCY: Text[50];
        AmountLCY: Decimal;
        AmountIncLCY: Decimal;
        CurrencyLCY: Boolean;
        AmountInWords: Boolean;
        AmountLangA: array[2] of Text[80];
        AmountLangB: array[2] of Text[80];
        PurchaseLine: Record "Purchase Line";
        ShowTHFormatting: Boolean;
        Text010: Label 'Purchase - Prepayment Invoice %1', Comment = '%1 = Document No.';
        OutputNo: Integer;
        PricesInclVATtxt: Text[30];
        AllowVATDisctxt: Text[30];
        VATAmountText: Text[30];
        Text011: Label '%1% VAT';
        Text012: Label 'VAT Amount';
        PurchInLineTypeNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        PhoneNoCaptionLbl: Label 'Phone No.';
        HomePageCaptionLbl: Label 'Home Page';
        EMailCaptionLbl: Label 'Email';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        ABNCaptionLbl: Label 'ABN';
        ABNDivisionPartNoCaptionLbl: Label 'Div. Part No.';
        InvoiceNoCaptionLbl: Label 'Invoice No.';
        PostingDateCaptionLbl: Label 'Posting Date';
        DueDateCaptionLbl: Label 'Due Date';
        PageCaptionLbl: Label 'Page';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShipmentMethodCaptionLbl: Label 'Shipment Method';
        DocumentDateCaptionLbl: Label 'Document Date';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost';
        DiscountPercentCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        PaymentDiscVATCaptionLbl: Label 'Payment Discount on VAT';
        ExchangeRateCaptionLbl: Label 'Exchange Rate';
        VATPercentCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmountCaptionLbl: Label 'VAT Amount';
        FormattedVATPct: Text;
        VATAmounttSpecCaptionLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmountCaptionLbl: Label 'Inv. Disc. Base Amount';
        LineAmountCaptionLbl: Label 'Line Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        TotalCaptionLbl: Label 'Total';
        ShipToAddressCaptionLbl: Label 'Ship-to Address';
        InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
        BuyFromContactPhoneNoLbl: Label 'Buy-from Contact Phone No.';
        BuyFromContactMobilePhoneNoLbl: Label 'Buy-from Contact Mobile Phone No.';
        BuyFromContactEmailLbl: Label 'Buy-from Contact E-Mail';
        PayToContactPhoneNoLbl: Label 'Pay-to Contact Phone No.';
        PayToContactMobilePhoneNoLbl: Label 'Pay-to Contact Mobile Phone No.';
        PayToContactEmailLbl: Label 'Pay-to Contact E-Mail';

    local procedure DocumentCaption(): Text[250]
    begin
        if Header."Prepayment Invoice" then exit(Text010);
        exit(Text004);
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Inv.") <> '';
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatAddressFields(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        FormatAddr.GetCompanyAddr(PurchInvHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchInvPayTo(VendAddr, PurchInvHeader);
        FormatAddr.PurchInvShipTo(ShipToAddr, PurchInvHeader);
    end;

    local procedure FormatDocumentFields(PurchInvHeader: Record "Purch. Inv. Header")
    begin
        FormatDocument.SetTotalLabels(PurchInvHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchInvHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchInvHeader."Payment Terms Code", PurchInvHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchInvHeader."Shipment Method Code", PurchInvHeader."Language Code");
        OrderNoText := FormatDocument.SetText(PurchInvHeader."Order No." <> '', PurchInvHeader.FieldCaption("Order No."));
        ReferenceText := FormatDocument.SetText(PurchInvHeader."Your Reference" <> '', PurchInvHeader.FieldCaption("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchInvHeader."VAT Registration No." <> '', PurchInvHeader.FieldCaption("VAT Registration No."));
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll();
        if TotalAmountVAT <> 0 then ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        if TotalAmountVAT <> 0 then ReportTotalsLine.Add(VATAmountLine.VATAmountText(), TotalAmountVAT, false, true, false);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterInitReport()
    begin
    end;
}
