// report 77601 FW_Invoice
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layout/JWSalesInvoice2.rdlc';
//     //   WordLayout = './layouts/EmailBody/Sales Invoice.docx';
//     Caption = 'FW_Invoice';

//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {
//             dataitem(CopyLoop; Integer)
//             {
//                 dataitem(PageLoop; Integer)
//                 {
//                     dataitem(DimensionLoop1; Integer)
//                     {
//                         column(DimText; 'Text[120]')
//                         {
//                         }
//                         column(Number1_IntergerLine; 'Integer')
//                         {
//                         }
//                         column(HeaderDimensionsCaption; 'Label')
//                         {
//                         }
//                     }
//                     dataitem("Sales Invoice Line"; "Sales Invoice Line")
//                     {
//                         dataitem(LotNoTracking; Integer)
//                         {
//                             column(LotTrackingText; 'Text')
//                             {
//                             }
//                         }
//                         dataitem(SerialNoTracking; Integer)
//                         {
//                             column(SerialTrackingText; 'Text')
//                             {
//                             }
//                         }
//                         dataitem("Sales Shipment Buffer"; Integer)
//                         {
//                             ObsoleteState = Pending;
//                             ObsoleteReason = 'This feature is obsolete and will be removed in the future.';
//                             ObsoleteTag = '22.0';

//                             column(SalesShipBufferPostingDt; 'Text')
//                             {
//                             }
//                             column(SalesShipBufferQty; 'Integer')
//                             {
//                             }
//                             column(ShipmentCaption; 'Text')
//                             {
//                             }
//                         }
//                         dataitem(DimensionLoop2; Integer)
//                         {
//                             column(DimTextCtrl82; 'Text[120]')
//                             {
//                             }
//                             column(LineDimensionsCaption; 'Label')
//                             {
//                             }
//                         }
//                         dataitem(AsmLoop; Integer)
//                         {
//                             column(PostedAsmMeasureCode; 'Text[10]')
//                             {
//                             }
//                             column(PostedAsmLineQty; 'Decimal')
//                             {
//                             }
//                             column(PostedAsmLineVarCode; 'Text')
//                             {
//                             }
//                             column(TempPostedAsmLineDesc; 'Text')
//                             {
//                             }
//                             column(PostedAsmLineNo; 'Text')
//                             {
//                             }
//                         }
//                         column(LineAmt_SalesInvLine; 'Decimal')
//                         {
//                         }
//                         column(Desc_SalesInvLine; 'Text[100]')
//                         {
//                         }
//                         column(No_SalesInvLine; 'Code[20]')
//                         {
//                         }
//                         column(No_SalesInvLineCaption; 'Text')
//                         {
//                         }
//                         column(Qty_SalesInvLine; 'Text')
//                         {
//                         }
//                         column(UnitMeasure_SalesInvLine; 'Code[10]')
//                         {
//                         }
//                         column(UnitPrice_SalesInvLine; 'Decimal')
//                         {
//                         }
//                         column(LineDiscount_SalesInvLine; 'Decimal')
//                         {
//                         }
//                         column(VATIdentifier_SalesInvLine; 'Code[20]')
//                         {
//                         }
//                         column(PostedShipDt_SalesInvLine; 'Text')
//                         {
//                         }
//                         column(SalesLineType_SalesInvLine; 'Text')
//                         {
//                         }
//                         column(InvDiscountAmt_SalesInvLine; 'Decimal')
//                         {
//                         }
//                         column(TotalSubTotal_SalesInvLine; 'Decimal')
//                         {
//                         }
//                         column(TotalInvDiscountAmt_SalesInvLine; 'Decimal')
//                         {
//                         }
//                         column(TotalText_SalesInvLine; 'Text[50]')
//                         {
//                         }
//                         column(Amount__SalesInvLine; 'Decimal')
//                         {
//                         }
//                         column(TotalAmount__SalesInvLine; 'Decimal')
//                         {
//                         }
//                         column(AmtIncludVATAmt; 'Decimal')
//                         {
//                         }
//                         column(AmtIncludVAT_SalesInvLine; 'Decimal')
//                         {
//                         }
//                         column(VATAmtLineVATAmtText; 'Text[30]')
//                         {
//                         }
//                         column(TotalExclVATText; 'Text[50]')
//                         {
//                         }
//                         column(TotalInclVATText; 'Text[50]')
//                         {
//                         }
//                         column(TotalAmtInclVAT; 'Decimal')
//                         {
//                         }
//                         column(TotalAmtVAT; 'Decimal')
//                         {
//                         }
//                         column(VATBaseDisc_SalesInvHdr; 'Decimal')
//                         {
//                         }
//                         column(TotalPaymentDisOnVAT; 'Decimal')
//                         {
//                         }
//                         column(SalesInvHeaderCurrFactor; 'Decimal')
//                         {
//                         }
//                         column(TotalExclVATTextLCY; 'Text[50]')
//                         {
//                         }
//                         column(TotalInclVATTextLCY; 'Text[50]')
//                         {
//                         }
//                         column(AmtIncLCYAmtLCY; 'Decimal')
//                         {
//                         }
//                         column(AmtIncLCY; 'Decimal')
//                         {
//                         }
//                         column(AmtLCY; 'Decimal')
//                         {
//                         }
//                         column(CurrLCYv; 'Boolean')
//                         {
//                         }
//                         column(CurrCode_SalesInvHeader; 'Code[10]')
//                         {
//                         }
//                         column(AmtInWords; 'Boolean')
//                         {
//                         }
//                         column(SalesInvLineLineNo; 'Integer')
//                         {
//                         }
//                         column(UnitPriceCaption; 'Label')
//                         {
//                         }
//                         column(DiscountPercentCaption; 'Label')
//                         {
//                         }
//                         column(AmountCaption; 'Label')
//                         {
//                         }
//                         column(PostedShipmentDateCaption; 'Label')
//                         {
//                         }
//                         column(InvDiscountAmountCaption; 'Label')
//                         {
//                         }
//                         column(SubtotalCaption; 'Label')
//                         {
//                         }
//                         column(PaymentDiscountonVATCaption; 'Label')
//                         {
//                         }
//                         column(ExchangeRateCaption; 'Label')
//                         {
//                         }
//                         column(Desc_SalesInvLineCaption; 'Text')
//                         {
//                         }
//                         column(Qty_SalesInvLineCaption; 'Text')
//                         {
//                         }
//                         column(UnitMeasure_SalesInvLineCaption; 'Text')
//                         {
//                         }
//                         column(VATIdentifier_SalesInvLineCaption; 'Text')
//                         {
//                         }
//                         column(IsLineWithTotals; 'Boolean')
//                         {
//                         }
//                         column(PrepaymentLine_SalesInvLine_FS; 'Boolean')
//                         {
//                         }
//                         column(PrepaymentAmount1_FS; 'Decimal')
//                         {
//                         }
//                         column(PrepaymentAmount2_FS; 'Decimal')
//                         {
//                         }
//                         column(TotalsPrimaryTextColor; 'Text[7]')
//                         {
//                         }
//                         column(GrandTotalAmount; 'Decimal')
//                         {
//                         }
//                         column(GrandTotalVATAmt; 'Decimal')
//                         {
//                         }
//                         column(FSG_GLD_ReferenceNo; 'Code[50]')
//                         {
//                         }
//                         column(FSG_GLD_Comments; 'Text')
//                         {
//                         }
//                         column(HideSimplePrepaymentCaption; 'Boolean')
//                         {
//                         }
//                         column(HideDetailedPrepaymentCaption; 'Boolean')
//                         {
//                         }
//                         column(HideDescriptionOnlyLine; 'Boolean')
//                         {
//                         }
//                         column(HideDetailedLine; 'Boolean')
//                         {
//                         }
//                         column(LineDiscountAmount; 'Decimal')
//                         {
//                         }
//                         column(LocationCode_SalesInvLine; 'Code[10]')
//                         {
//                         }
//                     }
//                     dataitem(VATCounter; Integer)
//                     {
//                         column(VATBase_VATAmtLine; 'Decimal')
//                         {
//                         }
//                         column(VATAmt_VATAmtLine; 'Decimal')
//                         {
//                         }
//                         column(LineAmt_VATAmtLine; 'Decimal')
//                         {
//                         }
//                         column(InvDiscBaseAmt_VATAmtLine; 'Decimal')
//                         {
//                         }
//                         column(InvDiscAmt_VATAmtLine; 'Decimal')
//                         {
//                         }
//                         column(VAT_VATAmtLine; 'Decimal')
//                         {
//                         }
//                         column(VATIdentifier_VATAmtLine; 'Code[20]')
//                         {
//                         }
//                     }
//                     dataitem(VatCounterLCY; Integer)
//                     {
//                         column(VALSpecLCYHdr; 'Text[80]')
//                         {
//                         }
//                         column(VALExchRate; 'Text[50]')
//                         {
//                         }
//                         column(VALVATBaseLCY; 'Decimal')
//                         {
//                         }
//                         column(VALVATAmtLCY; 'Decimal')
//                         {
//                         }
//                         column(VATCtrl164_VATAmtLine; 'Decimal')
//                         {
//                         }
//                         column(VATIndCtrl_VATAmtLine; 'Code[20]')
//                         {
//                         }
//                     }
//                     dataitem(PaymentReportingArgument; "Payment Reporting Argument")
//                     {
//                         column(PaymentServiceLogo; 'Blob')
//                         {
//                         }
//                         column(PaymentServiceURLText; 'Text[250]')
//                         {
//                         }
//                         column(PaymentServiceURL; 'Text')
//                         {
//                         }
//                     }
//                     dataitem(Total; Integer)
//                     {
//                     }
//                     dataitem(Total2; Integer)
//                     {
//                         column(SelltoCustomerNo_SalesInvHeader; 'Code[20]')
//                         {
//                         }
//                         column(ShipToAddr1; 'Text[50]')
//                         {
//                         }
//                         column(ShipToAddr2; 'Text[50]')
//                         {
//                         }
//                         column(ShipToAddr3; 'Text[50]')
//                         {
//                         }
//                         column(ShipToAddr4; 'Text[50]')
//                         {
//                         }
//                         column(ShipToAddr5; 'Text[50]')
//                         {
//                         }
//                         column(ShipToAddr6; 'Text[50]')
//                         {
//                         }
//                         column(ShipToAddr7; 'Text[50]')
//                         {
//                         }
//                         column(ShipToAddr8; 'Text[50]')
//                         {
//                         }
//                         column(ShiptoAddressCaption; 'Label')
//                         {
//                         }
//                         column(SelltoCustomerNo_SalesInvHeaderCaption; 'Text')
//                         {
//                         }
//                     }
//                     dataitem(LineFee; Integer)
//                     {
//                         column(LineFeeCaptionLbl; 'Text[200]')
//                         {
//                         }
//                     }
//                     dataitem(BackOrderSalesLine; "Sales Line")
//                     {
//                         column(No_BackOrderSalesLine; 'Code[20]')
//                         {
//                         }
//                         column(Description_BackOrderSalesLine; 'Text[100]')
//                         {
//                         }
//                         column(EarliestAvailableDate_BackOrderSalesLine; 'Text')
//                         {
//                         }
//                         column(Quantity_BackOrderSalesLine; 'Decimal')
//                         {
//                         }
//                     }
//                     column(CopyText; 'Text[30]')
//                     {
//                     }
//                     column(CompanyInfoPicture; 'Blob')
//                     {
//                     }
//                     column(SalesInvoiceCaption; 'Text')
//                     {
//                     }
//                     column(CustAddr1; 'Text[50]')
//                     {
//                     }
//                     column(CompAddr1; 'Text[50]')
//                     {
//                     }
//                     column(CustAddr2; 'Text[50]')
//                     {
//                     }
//                     column(CompAddr2; 'Text[50]')
//                     {
//                     }
//                     column(CustAddr3; 'Text[50]')
//                     {
//                     }
//                     column(CompAddr3; 'Text[50]')
//                     {
//                     }
//                     column(CustAddr4; 'Text[50]')
//                     {
//                     }
//                     column(CompAddr4; 'Text[50]')
//                     {
//                     }
//                     column(CustAddr5; 'Text[50]')
//                     {
//                     }
//                     column(CompInfoPhoneNo; 'Text[30]')
//                     {
//                     }
//                     column(CompInfoFaxNo; 'Text[30]')
//                     {
//                     }
//                     column(CustAddr6; 'Text[50]')
//                     {
//                     }
//                     column(ShipMethodDesc; 'Text[100]')
//                     {
//                     }
//                     column(PaymentTermsDesc; 'Text[100]')
//                     {
//                     }
//                     column(CompInfoVATRegsNo; 'Text[20]')
//                     {
//                     }
//                     column(CompInfoHomePage; 'Text[80]')
//                     {
//                     }
//                     column(CompInfoEmail; 'Text[80]')
//                     {
//                     }
//                     column(CompInfoGiroNo; 'Text[20]')
//                     {
//                     }
//                     column(CompInfoBankName; 'Text[100]')
//                     {
//                     }
//                     column(CompInfoBankAccNo; 'Text[30]')
//                     {
//                     }
//                     column(CompInfoBankBranchNo; 'Text[20]')
//                     {
//                     }
//                     column(CompInfoSwiftCode; 'Code[20]')
//                     {
//                     }
//                     column(PrimaryColour; 'Code[7]')
//                     {
//                     }
//                     column(SecondaryColour; 'Code[7]')
//                     {
//                     }
//                     column(BilltoCustNo_SalesInvHeader; 'Code[20]')
//                     {
//                     }
//                     column(PostingDt_SalesInvHeader; 'Text')
//                     {
//                     }
//                     column(VATNoText; 'Text[80]')
//                     {
//                     }
//                     column(VATRegsNo_SalesInvHeader; 'Text[20]')
//                     {
//                     }
//                     column(DueDate_SalesInvHeader; 'Text')
//                     {
//                     }
//                     column(SalesPersonText; 'Text[30]')
//                     {
//                     }
//                     column(SalesPurchPersonName; 'Text[50]')
//                     {
//                     }
//                     column(SalesInvHeaderNo1; 'Code[20]')
//                     {
//                     }
//                     column(ReferenceText; 'Text[80]')
//                     {
//                     }
//                     column(SalesInvHeaderYourReference; 'Text[35]')
//                     {
//                     }
//                     column(OrderNoText; 'Text[80]')
//                     {
//                     }
//                     column(OrderNo_SalesInvHdr; 'Code[20]')
//                     {
//                     }
//                     column(CustAddr7; 'Text[50]')
//                     {
//                     }
//                     column(CustAddr8; 'Text[50]')
//                     {
//                     }
//                     column(CompAddr5; 'Text[50]')
//                     {
//                     }
//                     column(CompAddr6; 'Text[50]')
//                     {
//                     }
//                     column(DocumentDate04_SalesInvHeader; 'Text')
//                     {
//                     }
//                     column(PricesIncludVAT_SalesInvHdr; 'Boolean')
//                     {
//                     }
//                     column(OutputNo; 'Integer')
//                     {
//                     }
//                     column(PricesInclVATYesNo; 'Text')
//                     {
//                     }
//                     column(PageCaption; 'Label')
//                     {
//                     }
//                     column(CompInfoABNDivPartNo; 'Text[3]')
//                     {
//                     }
//                     column(CompInfoABN; 'Text')
//                     {
//                     }
//                     column(BusinessTaxNo; 'Text')
//                     {
//                     }
//                     column(DocumentDateCaption; 'Label')
//                     {
//                     }
//                     column(PhoneNoCaption; 'Label')
//                     {
//                     }
//                     column(VATRegNoCaption; 'Label')
//                     {
//                     }
//                     column(GiroNoCaption; 'Label')
//                     {
//                     }
//                     column(BankNameCaption; 'Label')
//                     {
//                     }
//                     column(BankAccountNoCaption; 'Label')
//                     {
//                     }
//                     column(SwiftCodeCaption; 'Label')
//                     {
//                     }
//                     column(DueDateCaption; 'Label')
//                     {
//                     }
//                     column(InvoiceNoCaption; 'Label')
//                     {
//                     }
//                     column(PostingDateCaption; 'Label')
//                     {
//                     }
//                     column(ABNCaption; 'Label')
//                     {
//                     }
//                     column(BusinessTaxType; 'Text')
//                     {
//                     }
//                     column(DivisionPartNoCaption; 'Label')
//                     {
//                     }
//                     column(PaymentTermsDescriptionCaption; 'Label')
//                     {
//                     }
//                     column(ShipmentMethodDescriptionCaption; 'Label')
//                     {
//                     }
//                     column(HomePageCaption; 'Label')
//                     {
//                     }
//                     column(EmailIdCaption; 'Label')
//                     {
//                     }
//                     column(BilltoCustNo_SalesInvHeaderCaption; 'Text')
//                     {
//                     }
//                     column(PricesIncludVAT_SalesInvHdrCaption; 'Text')
//                     {
//                     }
//                     column(ShipToAddr1_FS; 'Text[50]')
//                     {
//                     }
//                     column(ShipToAddr2_FS; 'Text[50]')
//                     {
//                     }
//                     column(ShipToAddr3_FS; 'Text[50]')
//                     {
//                     }
//                     column(ShipToAddr4_FS; 'Text[50]')
//                     {
//                     }
//                     column(ShipToAddr5_FS; 'Text[50]')
//                     {
//                     }
//                     column(ExternalDocumentNo_SalesInvoiceHeader; 'Code[35]')
//                     {
//                     }
//                     column(DocumentText1; 'Text[1024]')
//                     {
//                     }
//                     column(DocumentText2; 'Text[1024]')
//                     {
//                     }
//                     column(DocumentText3; 'Text[1024]')
//                     {
//                     }
//                     column(AccountsEmail; 'Text')
//                     {
//                     }
//                     column(VATHeading; 'Text')
//                     {
//                     }
//                     column(InclVATHeading; 'Text')
//                     {
//                     }
//                     column(BPAYBillerCode; 'Code[20]')
//                     {
//                     }
//                     column(BPAYRefNo; 'Code[20]')
//                     {
//                     }
//                     column(RunBPAYProcessing; 'Boolean')
//                     {
//                     }
//                     column(BPAYLogo; 'Text')
//                     {
//                     }
//                     column(FSG_GLD_PostingDate; 'Text')
//                     {
//                     }
//                     column(PrimaryTextColor; 'Text[7]')
//                     {
//                     }
//                     column(SecondaryTextColor; 'Text[7]')
//                     {
//                     }
//                     column(BankAddr1; 'Text[100]')
//                     {
//                     }
//                     column(BankAddr2; 'Text[100]')
//                     {
//                     }
//                     column(BankAddr3; 'Text[100]')
//                     {
//                     }
//                     column(BankAddr4; 'Text[100]')
//                     {
//                     }
//                     column(BankAddr5; 'Text[100]')
//                     {
//                     }
//                     column(BankAddr6; 'Text[100]')
//                     {
//                     }
//                     column(BankAddr7; 'Text[100]')
//                     {
//                     }
//                     column(BankAddr8; 'Text[100]')
//                     {
//                     }
//                     column(HideBankAddr; 'Boolean')
//                     {
//                     }
//                     column(BankTransitNo; 'Text[20]')
//                     {
//                     }
//                     column(BillToCustRegistrationNo; 'Text[20]')
//                     {
//                     }
//                     column(BankIBAN; 'Code[50]')
//                     {
//                     }
//                     column(BankSWIFTCode; 'Code[20]')
//                     {
//                     }
//                     column(SenderName; 'Text[250]')
//                     {
//                     }
//                     column(SenderEmailAddress; 'Text[250]')
//                     {
//                     }
//                     column(FormalSalutation; 'Text')
//                     {
//                     }
//                     column(InformalSalutation; 'Text')
//                     {
//                     }
//                     column(ContactFirstName; 'Text')
//                     {
//                     }
//                     column(ContactLastName; 'Text')
//                     {
//                     }
//                     column(ShowPaymentLink; 'Boolean')
//                     {
//                     }
//                     column(PaymentLinkIcon; 'Blob')
//                     {
//                     }
//                     column(PaymentLinkUrl_UrlText; 'Text')
//                     {
//                     }
//                     column(PaymentLinkUrlRDLText; 'Text')
//                     {
//                     }
//                     column(PaymentLinkUrl_Url; 'Text')
//                     {
//                     }
//                 }
//             }
//             column(No_SalesInvHeader; 'Code[20]')
//             {
//             }
//             column(VATPercentCaption; 'Label')
//             {
//             }
//             column(VATBaseCaption; 'Label')
//             {
//             }
//             column(VATAmountCaption; 'Label')
//             {
//             }
//             column(VATAmountSpecificationCaption; 'Label')
//             {
//             }
//             column(VATIdentifierCaption; 'Label')
//             {
//             }
//             column(InvDiscBaseAmountCaption; 'Label')
//             {
//             }
//             column(LineAmountCaption; 'Label')
//             {
//             }
//             column(InvoiceDiscountAmountCaption; 'Label')
//             {
//             }
//             column(TotalCaption; 'Label')
//             {
//             }
//             column(PrepaymentInvoice_SalesInvHeader_FS; 'Boolean')
//             {
//             }
//             column(ShowDetailOnInvoice; 'Boolean')
//             {
//             }
//             column(DisplayAdditionalFeeNote; 'Boolean')
//             {
//             }
//             column(BackOrderExists; 'Boolean')
//             {
//             }
//             column(VATHeaderCaption; 'Text')
//             {
//             }
//             column(AmountInclVATHeaderCaption; 'Text')
//             {
//             }
//             column(AmountDueInclVATCaption; 'Text')
//             {
//             }
//             column(AmtDueVATCaption; 'Text')
//             {
//             }
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';

//                     field(NoOfCopies; NoOfCopies)
//                     {
//                         Caption = 'No. of Copies';
//                     }
//                     field(ShowInternalInfo; ShowInternalInfo)
//                     {
//                         Caption = 'Show Internal Information';
//                     }
//                     field(LogInteraction; LogInteraction)
//                     {
//                         Caption = 'Log Interaction';
//                     }
//                     field(ShowTotalInWords; AmountInWords)
//                     {
//                         Caption = 'Show Total In Words';
//                     }
//                     field(ShowLCYForFCY; CurrencyLCY)
//                     {
//                         Caption = 'Show LCY for FCY';
//                     }
//                     field(DisplayAsmInformation; DisplayAssemblyInformation)
//                     {
//                         Caption = 'Show Assembly Components';
//                     }
//                     field(ShowLotSN; ShowLotSN)
//                     {
//                         Caption = 'Show Lot/Serial No. Information';
//                     }
//                     field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
//                     {
//                         Caption = 'Show Additional Fee Note';
//                     }
//                 }
//             }
//         }
//     }
//     var
//         Text004: Label;
//         PageCaptionCap: Label;
//         TempNameValue: Record "Name/Value Buffer" temporary;
//         GLSetup: Record "General Ledger Setup";
//         ShipmentMethod: Record "Shipment Method";
//         PaymentTerms: Record "Payment Terms";
//         SalesPurchPerson: Record "Salesperson/Purchaser";
//         CompanyInfo: Record "Company Information";
//         CompanyInfo1: Record "Company Information";
//         CompanyInfo2: Record "Company Information";
//         CompanyInfo3: Record "Company Information";
//         SalesSetup: Record "Sales & Receivables Setup";
//         Cust: Record Customer;
//         VATAmountLine: Record "VAT Amount Line" temporary;
//         TempVATAmountLineLCY: Record "VAT Amount Line" temporary;
//         DimSetEntry1: Record "Dimension Set Entry";
//         DimSetEntry2: Record "Dimension Set Entry";
//         RespCenter: Record "Responsibility Center";
//         LanguageMgt: Codeunit System.Globalization.Language;
//         CurrExchRate: Record "Currency Exchange Rate";
//         ItemRef: Record "Item Reference";
//         TempPostedAsmLine: Record "Posted Assembly Line" temporary;
//         TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
//         TempHiddenLineBuffer: Record "Sales Invoice Line" temporary;
//         SalesCommentLine: Record "Sales Comment Line";
//         FormatAddr: Codeunit Microsoft.Foundation.Address."Format Address";
//         FormatDocument: Codeunit Microsoft.Utilities."Format Document";
//         SegManagement: Codeunit Microsoft.CRM.Segment.SegManagement;
//         GLDHelper: Codeunit FSG_GLD_Helper;
//         IntegrationHandler: Codeunit FSG_GLD_IntegrationHandler;
//         CustAddr: array[8] of Text[50];
//         ShipToAddr: array[8] of Text[50];
//         CompanyAddr: array[8] of Text[50];
//         OrderNoText: Text[80];
//         SalesPersonText: Text[30];
//         VATNoText: Text[80];
//         ReferenceText: Text[80];
//         TotalText: Text[50];
//         TotalExclVATText: Text[50];
//         TotalInclVATText: Text[50];
//         MoreLines: Boolean;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         ShowShippingAddr: Boolean;
//         NextEntryNo: Integer;
//         FirstValueEntryNo: Integer;
//         DimText: Text[120];
//         OldDimText: Text[75];
//         ShowInternalInfo: Boolean;
//         Continue: Boolean;
//         LogInteraction: Boolean;
//         VALVATBaseLCY: Decimal;
//         VALVATAmountLCY: Decimal;
//         VALSpecLCYHeader: Text[80];
//         Text007: Label;
//         Text008: Label;
//         VALExchRate: Text[50];
//         Text009: Label;
//         CalculatedExchRate: Decimal;
//         Text010: Label;
//         OutputNo: Integer;
//         TotalSubTotal: Decimal;
//         TotalAmount: Decimal;
//         TotalAmountInclVAT: Decimal;
//         TotalAmountVAT: Decimal;
//         TotalInvoiceDiscountAmount: Decimal;
//         TotalPaymentDiscountOnVAT: Decimal;
//         TotalInclVATTextLCY: Text[50];
//         TotalExclVATTextLCY: Text[50];
//         AmountLCY: Decimal;
//         AmountIncLCY: Decimal;
//         CurrencyLCY: Boolean;
//         AmountInWords: Boolean;
//         SalesLine: Record "Sales Line";
//         LogInteractionEnable: Boolean;
//         DisplayAssemblyInformation: Boolean;
//         VATPercentCaptionLbl: Label;
//         VATBaseCaptionLbl: Label;
//         VATAmountCaptionLbl: Label;
//         VATAmountSpecificationCaptionLbl: Label;
//         VATIdentifierCaptionLbl: Label;
//         InvDiscBaseAmountCaptionLbl: Label;
//         LineAmountCaptionLbl: Label;
//         InvoiceDiscountAmountCaptionLbl: Label;
//         TotalCaptionLbl: Label;
//         DocumentDateCaptionLbl: Label;
//         PhoneNoCaptionLbl: Label;
//         VATRegNoCaptionLbl: Label;
//         GiroNoCaptionLbl: Label;
//         BankNameCaptionLbl: Label;
//         BankAccountNoCaptionLbl: Label;
//         SwiftCodeCaptionLbl: Label;
//         DueDateCaptionLbl: Label;
//         InvoiceNoCaptionLbl: Label;
//         PostingDateCaptionLbl: Label;
//         ABNCaptionLbl: Label;
//         DivisionPartNoCaptionLbl: Label;
//         PaymentTermsDescriptionCaptionLbl: Label;
//         ShipmentMethodDescriptionCaptionLbl: Label;
//         HomePageCaptionLbl: Label;
//         EmailIdCaptionLbl: Label;
//         HeaderDimensionsCaptionLbl: Label;
//         UnitPriceCaptionLbl: Label;
//         DiscountPercentCaptionLbl: Label;
//         AmountCaptionLbl: Label;
//         PostedShipmentDateCaptionLbl: Label;
//         InvDiscountAmountCaptionLbl: Label;
//         SubtotalCaptionLbl: Label;
//         PaymentDiscountonVATCaptionLbl: Label;
//         ExchangeRateCaptionLbl: Label;
//         ShipmentCaptionLbl: Label;
//         LineDimensionsCaptionLbl: Label;
//         ShiptoAddressCaptionLbl: Label;
//         DisplayAdditionalFeeNote: Boolean;
//         LineNoWithTotal: Integer;
//         VATBaseRemainderAfterRoundingLCY: Decimal;
//         AmtInclVATRemainderAfterRoundingLCY: Decimal;
//         ReportID: Integer;
//         NeedToPrint: Boolean;
//         TrackingSpecBuffer: Record "Tracking Specification" temporary;
//         ItemTrackingDocHelper: Codeunit FSG_GLD_ItemTrackingDocHelper;
//         DocumentText: array[3] of Text[1024];
//         LotTrackingText: Text;
//         SerialTrackingText: Text;
//         PrepaymentAmount1: Decimal;
//         PrepaymentAmount2: Decimal;
//         GrandTotalAmount: Decimal;
//         GrandTotalVATAmt: Decimal;
//         FGText009: Label;
//         FGText010: Label;
//         RunBPAYProcessing: Boolean;
//         BPAYRefNo: Code[20];
//         BPAYBillerCode: Code[20];
//         BPAYLogoBase64Text: Text;
//         PrimaryTextColor: Text[7];
//         SecondaryTextColor: Text[7];
//         HideSimplePrepaymentCaption: Boolean;
//         HideDetailedPrepaymentCaption: Boolean;
//         HideDescriptionOnlyLine: Boolean;
//         HideDetailedLine: Boolean;
//         HideBankAddr: Boolean;
//         BankAccount: Record "Bank Account";
//         CompanyInfoABNDivPartNo: Text[3];
//         SenderName: Text[250];
//         SenderEmailAddress: Text[250];
//         ReportSelections: Record "Report Selections";
//         InformalSalutation: Text;
//         FormalSalutation: Text;
//         ContactFirstName: Text;
//         ContactLastName: Text;
//         UnshippedLineHandling: Enum FSG_GLD_UnshippedLineHandling;
//         BackOrderExists: Boolean;
//         EarliestAvailableDate: Date;
//         PaymentLinkUrl: Text;
//         ShowPaymentLink: Boolean;
//         PaymentLinkUrl_UrlText: Text;
//         PaymentLinkUrlRDLText: Text;
//         PaymentLinkPayNowLbl: Label;
//         TotalsPrimaryTextColor: Text[7];
//         BusinessTaxNo: Text;
//         BusinessTaxType: Enum FSG_GLD_BusinessTaxType;
//         VATHeaderCaption: Text;
//         AmountInclVATHeaderCaption: Text;
//         AmountDueInclVATCaption: Text;
//         AmtDueVATCaption: Text;
//         ShowLotSN: Boolean;
//         BankAddr: array[8] of Text[100];
// }