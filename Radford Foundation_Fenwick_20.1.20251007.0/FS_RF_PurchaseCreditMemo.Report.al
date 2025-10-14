report 50002 FS_RF_PurchaseCreditMemo
{
    WordLayout = './layouts/PurchaseCreditMemo.docx';
    Caption = 'Purchase - Credit Memo';
    PreviewMode = PrintLayout;
    DefaultLayout = Word;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Cr. Memo';

            column(No_PurchCrMemoHeader; "No.")
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber())
            {
            }
            column(Vendor_Cr__Memo_No_; "Vendor Cr. Memo No.")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
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
            column(CompanyInfoEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfoHomePage; CompanyInfo."Home Page")
            {
            }
            column(DocumentCaption; StrSubstNo(DocumentCaption(), CopyText))
            {
            }
            column(VendAddr1; VendAddr[1])
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(VendAddr2; VendAddr[2])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(VendAddr3; VendAddr[3])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(VendAddr4; VendAddr[4])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(VendAddr5; VendAddr[5])
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
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
            column(CompanyInfoHomePage1; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoEmail1; CompanyInfo."E-Mail")
            {
            }
            column(VendAddr7; VendAddr[7])
            {
            }
            column(VendAddr8; VendAddr[8])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyInfoABNDivPartNo; CompanyInfo."ABN Division Part No.")
            {
            }
            column(CompanyInfoABN; CompanyInfo.ABN)
            {
            }
            column(PaytoVendNo_PurchCrMemoHeader; Header."Pay-to Vendor No.")
            {
            }
            column(PaytoVendNo_PurchCrMemoHeaderCaption; Header.FieldCaption("Pay-to Vendor No."))
            {
            }
            column(VATNoText; VATNoText)
            {
            }
            column(VATRegNo_PurchCrMemoHeader; Header."VAT Registration No.")
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
            column(BuyfromVendNo_PurchCrMemoHeader; Header."Buy-from Vendor No.")
            {
            }
            column(YourRef_PurchCrMemoHeader; Header."Your Reference")
            {
            }
            column(DocDate_PurchCrMemoHeader; Format(Header."Document Date", 0, 4))
            {
            }
            column(AppliedToText; AppliedToText)
            {
            }
            column(ReturnOrderNoText; ReturnOrderNoText)
            {
            }
            column(No1_PurchCrMemoHeader; Header."No.")
            {
            }
            column(PostDate_PurchCrMemoHeader; Header."Posting Date")
            {
            }
            column(PostDate_PurchCrMemoHeaderCaption; Header.FieldCaption("Posting Date"))
            {
            }
            column(PricesInclVAT_PurchCrMemoHeader; Header."Prices Including VAT")
            {
            }
            column(PricesInclVAT_PurchCrMemoHeaderCaption; Header.FieldCaption("Prices Including VAT"))
            {
            }
            column(ReturnOrderNo_PurchCrMemoHeader; Header."Return Order No.")
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(ABNDivPartNo_PurchCrMemoHeader; Header."ABN Division Part No.")
            {
            }
            column(ABN_PurchCrMemoHeader; Header.ABN)
            {
            }
            column(ReasonCode_PurchCrMemoHeader; Header."Reason Code")
            {
            }
            column(OriginalInvDate; OriginalInvDate)
            {
            }
            column(GSTEnabled; GSTEnabled)
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
            column(ABNDivisionPartNoCaption; ABNDivisionPartNoCaptionLbl)
            {
            }
            column(ABNCaption; ABNCaptionLbl)
            {
            }
            column(CreditMemoNoCaption; CreditMemoNoCaptionLbl)
            {
            }
            column(ReasonCodeCaption; ReasonCodeCaptionLbl)
            {
            }
            column(OriginalInvNoCaption; OriginalInvNoCaptionLbl)
            {
            }
            column(OriginalInvDateCaption; OriginalInvDateCaptionLbl)
            {
            }
            column(DocumentDtCaption; DocumentDtCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            column(BuyFromVendorCaption; BuyFromVendorCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            dataitem(Line; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");

                column(ShowInternalInfo; ShowInternalInfo)
                {
                }
                column(AllowInvDiscount; AllowInvDiscount)
                {
                }
                column(PricesIncludingVAT; PricesIncludingVAT)
                {
                }
                column(Type_PurchCrMemoLine; Format(Line.Type, 0, 2))
                {
                }
                column(VATBasDisc_PurchCrMemoHeader; Header."VAT Base Discount %")
                {
                }
                column(VATAmountText; VATAmountText)
                {
                }
                column(LineAmount_PurchCrMemoLine; "Line Amount")
                {
                AutoFormatExpression = Line.GetCurrencyCode();
                AutoFormatType = 1;
                }
                column(Description_Line; Description)
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(Desc_PurchCrMemoLineCaption; FieldCaption(Description))
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(No_PurchCrMemoLineCaption; FieldCaption("No."))
                {
                }
                column(Quantity_Line; Quantity)
                {
                }
                column(Quantity_PurchCrMemoLineCaption; FieldCaption(Quantity))
                {
                }
                column(UOM_Line; "Unit of Measure")
                {
                }
                column(UOM_PurchCrMemoLineCaption; FieldCaption("Unit of Measure"))
                {
                }
                column(DirectUnitCost_PurchCrMemoLine; "Direct Unit Cost")
                {
                AutoFormatExpression = GetCurrencyCode();
                AutoFormatType = 2;
                }
                column(LineDisc_PurchCrMemoLine; "Line Discount %")
                {
                }
                column(AllowInvDisc_PurchCrMemoLine; "Allow Invoice Disc.")
                {
                IncludeCaption = false;
                }
                column(VATIdent_PurchCrMemoLine; "VAT Identifier")
                {
                }
                column(VATIdent_PurchCrMemoLineCaption; FieldCaption("VAT Identifier"))
                {
                }
                column(InvDisctAmt_PurchCrMemoLine;-"Inv. Discount Amount")
                {
                AutoFormatExpression = GetCurrencyCode();
                AutoFormatType = 1;
                }
                column(TotalText; TotalText)
                {
                }
                column(Amount_PurchCrMemoLine; Amount)
                {
                AutoFormatExpression = GetCurrencyCode();
                AutoFormatType = 1;
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(AmtInclVAT_PurchCrMemoLine; "Amount Including VAT")
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
                column(AmountIncLCY; AmountIncLCY)
                {
                AutoFormatExpression = GetCurrencyCode();
                AutoFormatType = 1;
                }
                column(CurrFactor_PurchCrMemoHeader; Header."Currency Factor")
                {
                }
                column(TotalExclVATTextLCY; TotalExclVATTextLCY)
                {
                }
                column(TotalInclVATTextLCY; TotalInclVATTextLCY)
                {
                }
                column(AmountIncLCYAmountLCY; AmountIncLCY - AmountLCY)
                {
                AutoFormatExpression = GetCurrencyCode();
                AutoFormatType = 1;
                }
                column(AmountLCY; AmountLCY)
                {
                AutoFormatExpression = GetCurrencyCode();
                AutoFormatType = 1;
                }
                column(CurrencyLCY; CurrencyLCY)
                {
                }
                column(CurrCode_PurchCrMemoHeader; Header."Currency Code")
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
                column(LineNo_PurchCrMemoLine; "Line No.")
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                AutoFormatExpression = Header."Currency Code";
                AutoFormatType = 1;
                }
                column(InvDiscountAmtCaption; InvDiscountAmtCaptionLbl)
                {
                }
                column(SubtotalCaption; SubtotalCaptionLbl)
                {
                }
                column(PaymentDiscVATCaption; PaymentDiscVATCaptionLbl)
                {
                }
                column(ExchangeRateCaption; ExchangeRateCaptionLbl)
                {
                }
                column(AllowInvoiceDiscountCaption; AllowInvoiceDiscountCaptionLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if(Type = Type::"G/L Account") and (not ShowInternalInfo)then "No.":='';
                    VATAmountLine.Init();
                    VATAmountLine."VAT Identifier":="VAT Identifier";
                    VATAmountLine."VAT Calculation Type":="VAT Calculation Type";
                    VATAmountLine."Tax Group Code":="Tax Group Code";
                    VATAmountLine."Use Tax":="Use Tax";
                    VATAmountLine."VAT %":="VAT %";
                    VATAmountLine."VAT Base":=Amount;
                    VATAmountLine."VAT Amount":="Amount Including VAT" - Amount;
                    VATAmountLine."Amount Including VAT":="Amount Including VAT";
                    VATAmountLine."Line Amount":="Line Amount";
                    if "Allow Invoice Disc." then VATAmountLine."Inv. Disc. Base Amount":="Line Amount";
                    VATAmountLine."Invoice Discount Amount":="Inv. Discount Amount";
                    VATAmountLine.InsertLine();
                    AllowInvDiscount:=Format("Allow Invoice Disc.");
                    TotalSubTotal+="Line Amount";
                    TotalInvoiceDiscountAmount-="Inv. Discount Amount";
                    TotalAmount+=Amount;
                    TotalAmountVAT+="Amount Including VAT" - Amount;
                    TotalAmountInclVAT+="Amount Including VAT";
                    TotalPaymentDiscountOnVAT+=-("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                end;
                trigger OnPreDataItem()
                var
                    PurchCrMemoLine: Record "Purch. Cr. Memo Line";
                    VATIdentifier: Code[20];
                begin
                    VATAmountLine.DeleteAll();
                    MoreLines:=Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0)do MoreLines:=Next(-1) <> 0;
                    if not MoreLines then CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    PurchCrMemoLine.SetRange("Document No.", Header."No.");
                    PurchCrMemoLine.SetFilter(Type, '<>%1', 0);
                    VATAmountText:='';
                    if PurchCrMemoLine.Find('-')then begin
                        VATAmountText:=StrSubstNo(Text012, PurchCrMemoLine."VAT %");
                        VATIdentifier:=PurchCrMemoLine."VAT Identifier";
                        repeat if(PurchCrMemoLine."VAT Identifier" <> VATIdentifier) and (PurchCrMemoLine.Quantity <> 0)then VATAmountText:=Text013;
                        until PurchCrMemoLine.Next() = 0;
                    end;
                    AllowInvDiscount:=Format("Allow Invoice Disc.");
                    FormattedVATPct:=Format(Line."VAT %");
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
                DecimalPlaces = 0: 5;
                }
                column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
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
                column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                {
                }
                column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                {
                }
                column(LineAmountCaption; LineAmountCaptionLbl)
                {
                }
                column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
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
                DecimalPlaces = 0: 5;
                }
                column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    VATAmountLine.GetLine(Number);
                    VALVATBaseLCY:=VATAmountLine.GetBaseLCY(Header."Posting Date", Header."Currency Code", Header."Currency Factor");
                    VALVATAmountLCY:=VATAmountLine.GetAmountLCY(Header."Posting Date", Header."Currency Code", Header."Currency Factor");
                end;
                trigger OnPreDataItem()
                begin
                    if(not GLSetup."Print VAT specification in LCY") or (Header."Currency Code" = '')then CurrReport.Break();
                    SetRange(Number, 1, VATAmountLine.Count);
                    Clear(VALVATBaseLCY);
                    Clear(VALVATAmountLCY);
                    if GLSetup."LCY Code" = '' then VALSpecLCYHeader:=Text008 + Text009
                    else
                        VALSpecLCYHeader:=Text008 + Format(GLSetup."LCY Code");
                    CurrExchRate.FindCurrency(Header."Posting Date", Header."Currency Code", 1);
                    CalculatedExchRate:=Round(1 / Header."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                    VALExchRate:=StrSubstNo(Text010, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                end;
            }
            dataitem(Total; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(TotalInvDiscountAmount; TotalInvoiceDiscountAmount)
                {
                AutoFormatExpression = Header."Currency Code";
                AutoFormatType = 1;
                }
                column(TotalAmount; TotalAmount)
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
            dataitem(Total2; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

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
                column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                {
                }
                trigger OnPreDataItem()
                begin
                    if ShipToAddr[1] = '' then CurrReport.Break();
                end;
            }
            trigger OnPreDataItem()
            begin
            end;
            trigger OnPostDataItem()
            begin
                if not IsReportInPreviewMode()then Codeunit.Run(Codeunit::"PurchCrMemo-Printed", Header);
            end;
            trigger OnAfterGetRecord()
            begin
                TotalSubTotal:=0;
                TotalInvoiceDiscountAmount:=0;
                TotalAmount:=0;
                TotalAmountVAT:=0;
                TotalAmountInclVAT:=0;
                TotalPaymentDiscountOnVAT:=0;
                CurrReport.Language:=LanguageCodeunit.GetLanguageIdOrDefault("Language Code");
                GSTEnabled:=GLSetup.GSTEnabled(Header."Document Date");
                FormatAddressFields(Header);
                FormatDocumentFields(Header);
                if BuyFromContact.Get("Buy-from Contact No.")then;
                if PayToContact.Get("Pay-to Contact No.")then;
                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
                if "Applies-to Doc. No." = '' then begin
                    AppliedToText:='' end
                else
                begin
                    if GLSetup.GSTEnabled(PurchInvHeader."Document Date")then begin
                        AppliedToText:="Applies-to Doc. No.";
                        if PurchInvHeader.Get("Adjustment Applies-to")then begin
                            OriginalInvDate:=PurchInvHeader."Document Date" end
                        else
                        begin
                            OriginalInvDate:=0D;
                        end;
                    end
                    else
                    begin
                        AppliedToText:=Format(StrSubstNo(Text003, Format("Applies-to Doc. Type"), "Applies-to Doc. No."));
                    end;
                end;
                CalcFields(Amount);
                CalcFields("Amount Including VAT");
                AmountLCY:=Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate(), "Currency Code", Amount, "Currency Factor"));
                AmountIncLCY:=Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate(), "Currency Code", "Amount Including VAT", "Currency Factor"));
                PurchaseLine.InitTextVariable();
                PurchaseLine.FormatNoText(AmountLangA, "Amount Including VAT", "Currency Code");
                if ShowTHFormatting then begin
                    PurchaseLine.InitTextVariableTH();
                    PurchaseLine.FormatNoTextTH(AmountLangB, "Amount Including VAT", "Currency Code");
                end
                else
                begin
                    AmountLangB[1]:='';
                    AmountLangB[2]:='';
                end;
                PricesIncludingVAT:=Format(Header."Prices Including VAT");
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
            LogInteractionEnable:=true;
        end;
        trigger OnOpenPage()
        begin
            LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Cr. Memo") <> '';
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
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
        if LogInteraction and not IsReportInPreviewMode()then if Header.FindSet()then repeat SegManagement.LogDocument(16, Header."No.", 0, 0, Database::Vendor, Header."Buy-from Vendor No.", Header."Purchaser Code", '', Header."Posting Description", '');
                until Header.Next() = 0;
    end;
    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then InitLogInteraction();
    end;
    var GLSetup: Record "General Ledger Setup";
    CompanyInfo: Record "Company Information";
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
    Text003: Label '(Applies to %1 %2)';
    Text005: Label 'Purchase - Credit Memo%1', Comment = '%1 = Document No.';
    VendAddr: array[8]of Text[100];
    ShipToAddr: array[8]of Text[100];
    CompanyAddr: array[8]of Text[100];
    ReturnOrderNoText: Text[80];
    PurchaserText: Text[30];
    VATNoText: Text[80];
    ReferenceText: Text[80];
    AppliedToText: Text;
    TotalText: Text[50];
    TotalInclVATText: Text[50];
    TotalExclVATText: Text[50];
    AllowInvDiscount: Text[30];
    PricesIncludingVAT: Text[30];
    VATAmountText: Text[30];
    MoreLines: Boolean;
    OutputNo: Integer;
    CopyText: Text[30];
    ShowInternalInfo: Boolean;
    LogInteraction: Boolean;
    VALVATBaseLCY: Decimal;
    VALVATAmountLCY: Decimal;
    VALSpecLCYHeader: Text[80];
    VALExchRate: Text[50];
    Text008: Label 'VAT Amount Specification in ';
    Text009: Label 'Local Currency';
    Text010: Label 'Exchange rate: %1/%2';
    CalculatedExchRate: Decimal;
    TotalInclVATTextLCY: Text[50];
    TotalExclVATTextLCY: Text[50];
    AmountLCY: Decimal;
    AmountIncLCY: Decimal;
    AmountLangA: array[2]of Text[80];
    AmountLangB: array[2]of Text[80];
    CurrencyLCY: Boolean;
    AmountInWords: Boolean;
    PurchaseLine: Record "Purchase Line";
    ShowTHFormatting: Boolean;
    OriginalInvDate: Date;
    PurchInvHeader: Record "Purch. Inv. Header";
    Text011: Label 'Purchase - Prepmt. Credit Memo %1';
    Text012: Label '%1% VAT';
    Text013: Label 'VAT Amount';
    GSTEnabled: Boolean;
    [InDataSet]
    LogInteractionEnable: Boolean;
    TotalSubTotal: Decimal;
    TotalAmount: Decimal;
    TotalAmountInclVAT: Decimal;
    TotalAmountVAT: Decimal;
    TotalInvoiceDiscountAmount: Decimal;
    TotalPaymentDiscountOnVAT: Decimal;
    PhoneNoCaptionLbl: Label 'Phone No.';
    VATRegNoCaptionLbl: Label 'VAT Registration No.';
    GiroNoCaptionLbl: Label 'Giro No.';
    BankNameCaptionLbl: Label 'Bank';
    BankAccNoCaptionLbl: Label 'Account No.';
    ABNDivisionPartNoCaptionLbl: Label 'Division Part No.';
    ABNCaptionLbl: Label 'ABN';
    CreditMemoNoCaptionLbl: Label 'Credit Memo No.';
    ReasonCodeCaptionLbl: Label 'Reason Code';
    OriginalInvNoCaptionLbl: Label 'Original Invoice No.';
    OriginalInvDateCaptionLbl: Label 'Original Invoice Date';
    DocumentDtCaptionLbl: Label 'Document Date';
    HomePageCaptionLbl: Label 'Home Page';
    EmailCaptionLbl: Label 'Email';
    BuyFromVendorCaptionLbl: Label 'Buy From Vendor';
    PageCaptionLbl: Label 'Page';
    DirectUnitCostCaptionLbl: Label 'Direct Unit Cost';
    DiscountPercentCaptionLbl: Label 'Discount %';
    AmountCaptionLbl: Label 'Amount';
    InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
    SubtotalCaptionLbl: Label 'Subtotal';
    PaymentDiscVATCaptionLbl: Label 'Payment Discount on VAT';
    ExchangeRateCaptionLbl: Label 'Exchange Rate';
    AllowInvoiceDiscountCaptionLbl: Label 'Allow invoice Discount';
    VATPercentCaptionLbl: Label 'VAT %';
    VATBaseCaptionLbl: Label 'VAT Base';
    VATAmountCaptionLbl: Label 'VAT Amount';
    VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
    VATIdentifierCaptionLbl: Label 'VAT Identifier';
    LineAmountCaptionLbl: Label 'Line Amount';
    InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
    TotalCaptionLbl: Label 'Total';
    BuyFromContactPhoneNoLbl: Label 'Buy-from Contact Phone No.';
    BuyFromContactMobilePhoneNoLbl: Label 'Buy-from Contact Mobile Phone No.';
    BuyFromContactEmailLbl: Label 'Buy-from Contact E-Mail';
    PayToContactPhoneNoLbl: Label 'Pay-to Contact Phone No.';
    PayToContactMobilePhoneNoLbl: Label 'Pay-to Contact Mobile Phone No.';
    PayToContactEmailLbl: Label 'Pay-to Contact E-Mail';
    ShiptoAddressCaptionLbl: Label 'Ship-to Address';
    FormattedVATPct: Text;
    procedure InitLogInteraction()
    begin
        LogInteraction:=SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Cr. Memo") <> '';
    end;
    local procedure DocumentCaption(): Text[250]begin
        if Header."Prepayment Credit Memo" then exit(Text011);
        exit(Text005);
    end;
    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        ShowInternalInfo:=NewShowInternalInfo;
        LogInteraction:=NewLogInteraction;
    end;
    local procedure IsReportInPreviewMode(): Boolean var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody());
    end;
    local procedure FormatAddressFields(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
        FormatAddr.GetCompanyAddr(PurchCrMemoHdr."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchCrMemoPayTo(VendAddr, PurchCrMemoHdr);
        FormatAddr.PurchCrMemoShipTo(ShipToAddr, PurchCrMemoHdr);
    end;
    local procedure FormatDocumentFields(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
        FormatDocument.SetTotalLabels(PurchCrMemoHdr."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchCrMemoHdr."Purchaser Code", PurchaserText);
        ReturnOrderNoText:=FormatDocument.SetText(PurchCrMemoHdr."Return Order No." <> '', PurchCrMemoHdr.FieldCaption("Return Order No."));
        ReferenceText:=FormatDocument.SetText(PurchCrMemoHdr."Your Reference" <> '', PurchCrMemoHdr.FieldCaption("Your Reference"));
        VATNoText:=FormatDocument.SetText(PurchCrMemoHdr."VAT Registration No." <> '', PurchCrMemoHdr.FieldCaption("VAT Registration No."));
        AppliedToText:=FormatDocument.SetText(PurchCrMemoHdr."Applies-to Doc. No." <> '', Format(StrSubstNo(Text003, Format(PurchCrMemoHdr."Applies-to Doc. Type"), PurchCrMemoHdr."Applies-to Doc. No.")));
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
