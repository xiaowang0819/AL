codeunit 50000 FS_RF_Utilities
{
    var
        TypeNotSupportedErr: Label 'Type %1 is not supported.', Comment = 'Line or Document type';
        ReportAsPdfFileNamePluralMsg: Label 'Sales %1.pdf', Comment = '%1 = Document Type in plural form';
        PdfFileNamePluralMsg: Label '%1.pdf', Comment = '%1 = Document Type in plural form';
        ReportAsPdfFileNameMsg: Label '%1 %2.pdf', Comment = '%1 = Document Type %2 = Invoice No. or Job Number';
        EmailSubjectCapTxt: Label '%1 - %2 %3', Comment = '%1 = Customer Name. %2 = Document Type %3 = Invoice No.';
        EmailSubjectPluralCapTxt: Label '%1 - %2', Comment = '%1 = Customer Name. %2 = Document Type in plural form';

    procedure EmailSalesHeaderServiceRequest(SalesHeader: Record "Sales Header")
    var
        DocumentPrint: Codeunit "Document-Print";
    begin
        SalesHeader.FS_RF_ServiceRequestFlag := true;
        DocumentPrint.EmailSalesHeader(SalesHeader);
        SalesHeader.FS_RF_ServiceRequestFlag := false;
    end;

    procedure SelectAttachmentFile(DocumentVariant: Variant)
    var
        DocumentAttachmentDetails: Page "Document Attachment Details";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(DocumentVariant);
        DocumentAttachmentDetails.OpenForRecRef(RecRef);
        DocumentAttachmentDetails.RunModal();
    end;

    procedure GetAccountTableId(DocumentTableId: Integer): Integer
    begin
        case DocumentTableId of
            Database::"Sales Header", Database::"Sales Invoice Header", Database::"Sales Cr.Memo Header", Database::"Sales Shipment Header", Database::"Return Receipt Header":
                exit(Database::Customer);
            Database::"Purchase Header", Database::"Purch. Inv. Header", Database::"Purch. Cr. Memo Hdr.", Database::"Purch. Rcpt. Header", Database::"Return Shipment Header":
                exit(Database::Vendor);
        end;
    end;

    procedure EmailFileWithMultiAttachments(var TempEmailItem: Record "Email Item" temporary; countFileAttachment: Integer; var AttachmentStream: array[25] of InStream; var AttachmentName: array[25] of Text; HtmlBodyFilePath: Text[250]; PostedDocNo: Code[20]; ToEmailAddress: Text[250]; EmailDocName: Text[250]; HideDialog: Boolean; ReportUsage: Integer; SourceTables: List of [Integer]; SourceIDs: List of [Guid]; SourceRelationTypes: List of [Integer]): Boolean
    begin
        exit(EmailFileInternal(TempEmailItem, HtmlBodyFilePath, '', ToEmailAddress, PostedDocNo, EmailDocName, HideDialog, ReportUsage, true, '', Enum::"Email Scenario"::Default));
    end;

    local procedure EmailFileInternal(var TempEmailItem: Record "Email Item" temporary; HtmlBodyFilePath: Text[250]; EmailSubject: Text[250]; ToEmailAddress: Text[250]; PostedDocNo: Code[20]; EmailDocName: Text[250]; HideDialog: Boolean; ReportUsage: Integer; IsFromPostedDoc: Boolean; SenderUserID: Code[50]; EmailScenario: Enum "Email Scenario"): Boolean
    var
        OfficeMgt: Codeunit "Office Management";
        EmailScenarioMapping: Codeunit "Email Scenario Mapping";
        Attachments: Codeunit "Temp Blob List";
        Attachment: Codeunit "Temp Blob";
        EmailSentSuccesfully: Boolean;
        AttachmentStream: InStream;
        AttachmentNames: List of [Text];
        Name: Text[250];
    begin
        TempEmailItem."Send to" := ToEmailAddress;
        TempEmailItem.GetAttachments(Attachments, AttachmentNames);
        // If true, that means we came from "EmailFile" call and need to get data from the document
        if IsFromPostedDoc then begin
            if Attachments.Count() > 0 then begin
                Name := CopyStr(AttachmentNames.Get(1), 1, 250);
                GetAttachmentFileName(Name, PostedDocNo, EmailDocName, ReportUsage);
                if Name <> AttachmentNames.Get(1) then AttachmentNames.Set(1, Name);
            end;
            EmailSubject := GetEmailSubject(PostedDocNo, EmailDocName, ReportUsage);
            TempEmailItem.FS_RF_AttachIncomingDocuments(PostedDocNo);
        end;
        TempEmailItem.Subject := EmailSubject;
        if HtmlBodyFilePath <> '' then begin
            TempEmailItem.Validate("Plaintext Formatted", false);
            TempEmailItem.Validate("Body File Path", HtmlBodyFilePath);
            TempEmailItem.Validate("Message Type", TempEmailItem."Message Type"::"From Email Body Template");
        end;
        if OfficeMgt.AttachAvailable() and (Attachments.Count() > 0) then begin
            Attachments.Get(1, Attachment);
            Attachment.CreateInStream(AttachmentStream);
            OfficeMgt.AttachDocument(AttachmentStream, AttachmentNames.Get(1), TempEmailItem.FS_RF_GetBodyText(), TempEmailItem.Subject);
        end
        else begin
            if OfficeMgt.AttachAvailable() then OfficeMgt.AttachDocument(TempEmailItem.FS_RF_GetBodyText(), TempEmailItem.Subject);
            if not OfficeMgt.AttachAvailable() then begin
                if Enum::"Report Selection Usage".Ordinals().Contains(ReportUsage) then EmailScenario := EmailScenarioMapping.FromReportSelectionUsage(Enum::"Report Selection Usage".FromInteger(ReportUsage));
                EmailSentSuccesfully := TempEmailItem.Send(HideDialog, EmailScenario);
                exit(EmailSentSuccesfully);
            end;
        end;
    end;

    procedure GetNextEmailAddressFromCustomReportSelection(var CustomReportSelection: Record "Custom Report Selection"; DefaultEmailAddress: Text; ReportUsage: Enum "Report Selection Usage"; SequenceText: Text): Text
    var
        SequenceInteger: Integer;
    begin
        if Evaluate(SequenceInteger, SequenceText) then begin
            CustomReportSelection.SetRange(Usage, ReportUsage);
            CustomReportSelection.SetRange(Sequence, SequenceInteger);
            if CustomReportSelection.FindFirst() then begin
                if CustomReportSelection.GetSendToEmail(true) <> '' then begin
                    exit(CustomReportSelection."Send To Email");
                end;
            end;
        end;
        exit(DefaultEmailAddress);
    end;

    procedure GetAttachmentFileName(var AttachmentFileName: Text[250]; PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer)
    var
        ReportSelections: Record "Report Selections";
    begin
        if AttachmentFileName = '' then
            if PostedDocNo = '' then begin
                if ReportUsage = ReportSelections.Usage::"P.Order".AsInteger() then
                    AttachmentFileName := StrSubstNo(PdfFileNamePluralMsg, EmailDocumentName)
                else
                    AttachmentFileName := StrSubstNo(ReportAsPdfFileNamePluralMsg, EmailDocumentName);
            end
            else
                AttachmentFileName := StrSubstNo(ReportAsPdfFileNameMsg, EmailDocumentName, PostedDocNo)
    end;

    procedure GetEmailSubject(PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer) Subject: Text[250]
    var
        EmailParameter: Record "Email Parameter";
        CompanyInformation: Record "Company Information";
    begin
        if EmailParameter.GetParameterWithReportUsage(PostedDocNo, "Report Selection Usage".FromInteger(ReportUsage), EmailParameter."Parameter Type"::Subject) then exit(CopyStr(EmailParameter.GetParameterValue(), 1, 250));
        CompanyInformation.Get();
        if PostedDocNo = '' then
            Subject := CopyStr(StrSubstNo(EmailSubjectPluralCapTxt, CompanyInformation.Name, EmailDocumentName), 1, MaxStrLen(Subject))
        else
            Subject := CopyStr(StrSubstNo(EmailSubjectCapTxt, CompanyInformation.Name, EmailDocumentName, PostedDocNo), 1, MaxStrLen(Subject))
    end;

    procedure PurchDocFromSalesDoc_CreatePurchaseInvoice(SalesHeader: Record "Sales Header"; var SelectedSalesLine: Record "Sales Line")
    var
        Vendor: Record Vendor;
        PurchaseHeader: Record "Purchase Header";
        SalesLine: Record "Sales Line";
        OptionNumber: Integer;
        CreatePurchInvOptionQst: Label 'All Lines,Selected Lines';
        CreatePurchInvInstructionTxt: Label 'A purchase invoice will be created. Select which sales invoice lines to use.';
    begin
        OptionNumber := Dialog.StrMenu(CreatePurchInvOptionQst, 1, CreatePurchInvInstructionTxt);
        if OptionNumber = 0 then exit;
        case OptionNumber of
            0:
                exit;
            1:
                begin
                    SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                    SalesLine.SetRange("Document No.", SalesHeader."No.");
                end;
            2:
                SalesLine.Copy(SelectedSalesLine);
        end;
        if SelectVendor(Vendor, SalesHeader) then begin
            OnBeforeCreatePurchaseInvoice(SalesHeader, SalesLine);
            CreatePurchaseHeader(PurchaseHeader, SalesHeader, Vendor);
            CopySalesLinesToPurchaseLines(PurchaseHeader, SalesLine);
            Page.Run(Page::"Purchase Invoice", PurchaseHeader);
        end;
    end;

    local procedure SelectVendor(var Vendor: Record Vendor; SalesHeader: Record "Sales Header"): Boolean
    var
        VendorNo: Code[20];
    begin
        VendorNo := SalesHeader.FS_RF_ServiceProvider;
        if Vendor.Get(VendorNo) then exit(true);
        exit(false);
    end;

    local procedure CreatePurchaseHeader(var PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header"; Vendor: Record Vendor)
    begin
        PurchaseHeader.Init();
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::Order] then
            PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Invoice)
        else
            Error(TypeNotSupportedErr, Format(SalesHeader."Document Type"));
        PurchaseHeader.InitRecord();
        PurchaseHeader.Validate("Buy-from Vendor No.", Vendor."No.");
        OnCreatePurchaseHeaderOnBeforeInsert(PurchaseHeader, SalesHeader, Vendor);
        PurchaseHeader.Insert(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", 'OnCreatePurchaseHeaderOnBeforeInsert', '', true, true)]
    local procedure OnCreatePurchaseHeaderOnBeforeInsert(var PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header"; Vendor: Record Vendor)
    begin
        PurchaseHeader.Validate(FS_RF_SourceType, Database::"Sales Header");
        PurchaseHeader.Validate(FS_RF_SourceSubType, SalesHeader."Document Type");
        PurchaseHeader.Validate(FS_RF_LinkedOrder, SalesHeader."No.");
        PurchaseHeader."Your Reference" := SalesHeader."Your Reference";
    end;

    local procedure CopySalesLinesToPurchaseLines(PurchaseHeader: Record "Purchase Header"; var SalesLine: Record "Sales Line")
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLineNo: Integer;
        IsHandled: Boolean;
    begin
        PurchaseLineNo := 0;
        if SalesLine.Find('-') then
            repeat
                Clear(PurchaseLine);
                PurchaseLine.Init();
                PurchaseLine."Document No." := PurchaseHeader."No.";
                PurchaseLine."Document Type" := PurchaseHeader."Document Type";
                PurchaseLineNo := PurchaseLineNo + 10000;
                PurchaseLine."Line No." := PurchaseLineNo;
                case SalesLine.Type of
                    SalesLine.Type::" ":
                        PurchaseLine.Type := PurchaseLine.Type::" ";
                    SalesLine.Type::Item:
                        PurchaseLine.Type := PurchaseLine.Type::Item;
                    SalesLine.Type::Resource:
                        PurchaseLine.Type := PurchaseLine.Type::Resource; //
                    else begin
                        IsHandled := false;
                        if not IsHandled then Error(TypeNotSupportedErr, Format(SalesLine.Type));
                    end
                end;
                PurchaseLine.Validate("No.", SalesLine."No.");
                PurchaseLine.Description := SalesLine.Description;
                if PurchaseLine."No." <> '' then begin
                    PurchaseLine.Validate("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
                    PurchaseLine.Validate("Pay-to Vendor No.", PurchaseHeader."Pay-to Vendor No.");
                    PurchaseLine.Validate(Quantity, SalesLine.Quantity);
                    PurchaseLine.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
                    PurchaseLine.Validate("Direct Unit Cost", SalesLine.FS_RF_ContractorUnitCost);
                end;
                OnCopySalesLinesToPurchaseLinesOnBeforeInsert(PurchaseLine, SalesLine);
                PurchaseLine.Insert(true);
            until SalesLine.Next() = 0;
    end;

    // Copy Attachments
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", 'OnCopySalesLinesToPurchaseLinesOnBeforeInsert', '', true, true)]
    local procedure OnCopySalesLinesToPurchaseLinesOnBeforeInsert(var PurchaseLine: Record "Purchase Line"; SalesLine: Record "Sales Line")
    var
        lRec_DocumentAttachment: Record "Document Attachment";
        lRec_DocumentAttachment2: Record "Document Attachment";
        lID: Integer;
        FileName: Text;
    begin
        lRec_DocumentAttachment.SetRange("Table ID", Database::"Sales Header");
        lRec_DocumentAttachment.SetRange("No.", SalesLine."Document No.");
        lRec_DocumentAttachment.SetRange("Document Type", SalesLine."Document Type");
        if lRec_DocumentAttachment.FindSet() then
            repeat
                Clear(FileName);
                lRec_DocumentAttachment2.Reset();
                lRec_DocumentAttachment2.SetCurrentKey(ID);
                lRec_DocumentAttachment2.Ascending(false);
                if lRec_DocumentAttachment2.FindFirst() then lID := lRec_DocumentAttachment2.ID + 1;
                lRec_DocumentAttachment2.Init();
                lRec_DocumentAttachment2 := lRec_DocumentAttachment;
                lRec_DocumentAttachment2.ID := lID;
                lRec_DocumentAttachment2."Table ID" := Database::"Purchase Header";
                lRec_DocumentAttachment2."No." := PurchaseLine."Document No.";
                lRec_DocumentAttachment2."Document Type" := PurchaseLine."Document Type";
                lRec_DocumentAttachment2.Insert();
                Commit();
            until lRec_DocumentAttachment.Next() = 0;
    end;

    procedure PrintDeliveryDocket(SalesHeader: Record "Sales Header")
    var
        ReportSelection: Record "Report Selections";
        ReportUsage: Enum "Report Selection Usage";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then exit;
        ReportUsage := ReportUsage::FS_RF_DeliveryDocket;
        SalesHeader.SetRecFilter();
        ReportSelection.PrintWithDialogForCust(ReportUsage, SalesHeader, GuiAllowed, SalesHeader.FieldNo("Sell-to Customer No."));
    end;

    procedure CalculateShipToOptions(var ShipToOptions: Option "Default (Service provider Address)","Alternate Shipping Address","Custom Address"; var SalesHeader: Record "Sales Header")
    var
        ShipToNameEqualsSellToName: Boolean;
    begin
        ShipToNameEqualsSellToName := (SalesHeader.FS_RF_ShipToName = SalesHeader."Sell-to Customer Name") and (SalesHeader.FS_RF_ShipToName2 = SalesHeader."Sell-to Customer Name 2");
        case true of
            (SalesHeader.FS_RF_ShipToCode = '') and ShipToNameEqualsSellToName and SalesHeader.FS_RF_ShipToAddressEqualsSellToAddress():
                ShipToOptions := ShipToOptions::"Default (Service provider Address)";
            (SalesHeader.FS_RF_ShipToCode = '') and (not ShipToNameEqualsSellToName or not SalesHeader.FS_RF_ShipToAddressEqualsSellToAddress()):
                ShipToOptions := ShipToOptions::"Custom Address";
            SalesHeader.FS_RF_ShipToCode <> '':
                ShipToOptions := ShipToOptions::"Alternate Shipping Address";
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreatePurchaseInvoice(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    procedure GetCostForSalesLine(var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer)
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        LineNo: Integer;
        CostIncGST: Boolean;
    begin
        if not (SalesLine."Document Type" in [SalesLine."Document Type"::Order, SalesLine."Document Type"::Quote, SalesLine."Document Type"::Invoice]) then exit;
        if SalesLine."No." = '' then exit;
        if not (SalesLine.Type in [SalesLine.Type::Item, SalesLine.Type::"G/L Account", SalesLine.Type::Resource]) then exit;
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        if SalesHeader.FS_RF_ServiceProvider = '' then exit;
        if (CalledByFieldNo = SalesLine.FieldNo(Quantity)) and (SalesLine.FS_RF_ContractorUnitCost <> 0) then begin
            CostIncGST := SalesLine.FS_RF_ContractorCostAmount = SalesLine.FS_RF_ContractorAmountInclGST;
            SalesLine.FS_RF_ContractorCostAmount := SalesLine.FS_RF_ContractorUnitCost * SalesLine.Quantity;
            if CostIncGST then begin
                SalesLine.FS_RF_ContractorAmountInclGST := SalesLine.FS_RF_ContractorCostAmount;
            end
            else
                SalesLine.FS_RF_ContractorAmountInclGST := SalesLine.FS_RF_ContractorCostAmount * (1 + SalesLine.FS_RF_ContractorGSTPercent / 100);
        end
        else begin
            if not PurchHeader.Get(PurchHeader."Document Type"::Quote, 'PRICEDUMMY') then begin
                PurchHeader.Init();
                PurchHeader.SetHideValidationDialog(true);
                PurchHeader.Validate("Document Type", PurchHeader."Document Type"::Quote);
                PurchHeader."No." := 'PRICEDUMMY';
                PurchHeader."Your Reference" := 'Do Not Use';
                PurchHeader.Validate("Buy-from Vendor No.", SalesHeader.FS_RF_ServiceProvider);
                PurchHeader.Insert();
            end;
            PurchHeader.SetHideValidationDialog(true);
            PurchHeader."Posting Date" := WorkDate();
            PurchHeader."Order Date" := WorkDate();
            PurchHeader."Document Date" := WorkDate();
            if PurchHeader."Buy-from Vendor No." <> SalesHeader.FS_RF_ServiceProvider then PurchHeader.Validate("Buy-from Vendor No.", SalesHeader.FS_RF_ServiceProvider);
            PurchHeader.Modify();
            Clear(PurchLine);
            PurchLine.Init();
            PurchLine.SetRange("Document Type", PurchHeader."Document Type");
            PurchLine.SetRange("Document No.", PurchHeader."No.");
            if PurchLine.FindLast() then LineNo := PurchLine."Line No.";
            PurchLine."Document No." := PurchHeader."No.";
            PurchLine."Document Type" := PurchHeader."Document Type";
            PurchLine."Line No." := LineNo + 10000;
            case SalesLine.Type of
                SalesLine.Type::Item:
                    PurchLine.Validate(Type, PurchLine.Type::Item);
                SalesLine.Type::Resource:
                    PurchLine.Validate(Type, PurchLine.Type::Resource); //
            end;
            if SalesLine."No." <> '' then begin
                PurchLine.Validate("Buy-from Vendor No.", SalesHeader.FS_RF_ServiceProvider);
                PurchLine.Validate("Pay-to Vendor No.", PurchHeader."Pay-to Vendor No.");
                PurchLine.Validate("No.", SalesLine."No.");
                PurchLine.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
                PurchLine.Description := SalesLine.Description;
                PurchLine.Validate(Quantity, SalesLine.Quantity);
                SalesLine.FS_RF_ContractorUnitCost := PurchLine."Direct Unit Cost";
                SalesLine.FS_RF_ContractorCostAmount := PurchLine.Amount;
                SalesLine.FS_RF_ContractorGSTPercent := PurchLine."VAT %";
                SalesLine.FS_RF_ContractorAmountInclGST := PurchLine.Amount * (1 + PurchLine."VAT %" / 100);
            end;
            PurchHeader.Delete(true);
        end;
    end;
}
