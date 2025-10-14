codeunit 50005 FS_RF_EventHandler
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure SalesPostPrepayments_OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        SalesInvHeader."Order No." := SalesHeader."No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterFillInvLineBuffer', '', false, false)]
    local procedure SalesPost_OnAfterFillInvLineBuffer(var PrepmtInvLineBuf: Record "Prepayment Inv. Line Buffer"; SalesLine: Record "Sales Line")
    begin
        PrepmtInvLineBuf.FS_RF_OrderNo := SalesLine."Document No.";
        PrepmtInvLineBuf.FS_RF_OrderLineNo := SalesLine."Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure SalesPostPrepayments_OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean)
    begin
        SalesInvLine."Order No." := PrepmtInvLineBuffer.FS_RF_OrderNo;
        SalesInvLine."Order Line No." := PrepmtInvLineBuffer.FS_RF_OrderLineNo;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeTempPrepmtSalesLineInsert', '', false, false)]
    local procedure SalesPost_OnBeforeTempPrepmtSalesLineInsert(var TempPrepmtSalesLine: Record "Sales Line" temporary; var TempSalesLine: Record "Sales Line" temporary; SalesHeader: Record "Sales Header"; CompleteFunctionality: Boolean)
    begin
        TempPrepmtSalesLine."Prepayment Line" := true;
        TempPrepmtSalesLine."VAT Prod. Posting Group" := TempSalesLine."VAT Prod. Posting Group";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure SalesPost_OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean)
    begin
        if SalesLine."Document Type" = SalesLine."Document Type"::Order then begin
            SalesInvLine."Order No." := SalesLine."Document No.";
            SalesInvLine."Order Line No." := SalesLine."Line No.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sent Email", 'OnAfterInsertEvent', '', false, false)]
    local procedure SentEmail_OnAfterInsertEvent(var Rec: Record "Sent Email"; RunTrigger: Boolean)
    begin
        Mgt.UpdatedSalesHeaderAfterSentEmail(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sent Email", 'OnAfterModifyEvent', '', false, false)]
    local procedure SentEmail_OnAfterModifyEvent(var Rec: Record "Sent Email"; var xRec: Record "Sent Email"; RunTrigger: Boolean)
    begin
        Mgt.UpdatedSalesHeaderAfterSentEmail(Rec);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforeDoPrintSalesHeader', '', false, false)]
    local procedure DocumentPrint_OnBeforeDoPrintSalesHeader(var SalesHeader: Record "Sales Header"; ReportUsage: Integer; SendAsEmail: Boolean; var IsPrinted: Boolean)
    var
        ReportSelections: Record "Report Selections";
    begin
        if ReportUsage = Enum::"Report Selection Usage"::FS_RF_ServiceRequest.AsInteger() then begin
            if SendAsEmail then begin
                ReportSelections.SendEmailToVendor(ReportUsage, SalesHeader, SalesHeader."No.", SalesHeader.GetDocTypeTxt(), true, SalesHeader.FS_RF_ServiceProvider);
                IsPrinted := true;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckShipmentDateBeforeWorkDate', '', false, false)]
    local procedure Salesline_OnBeforeCheckShipmentDateBeforeWorkDate(sender: Record "Sales Line"; var IsHandled: Boolean; var HasBeenShown: Boolean; var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    begin
        HasBeenShown := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeManualReleaseSalesDoc', '', false, false)]
    local procedure ReleaseSalesDocument_OnBeforeManualReleaseSalesDoc(PreviewMode: Boolean; var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        FreightSalesLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        TotalFreightPrice: Decimal;
        ReleasewithoutFreightLineQst: Label 'The Freight line has not been calculated, Do you want to continue?';
        FreightAmountMatchQst: Label 'The freight amount on the Freight line does not equal to the sum of all Item lines freight prices, Do you want to update the amount on the existing freight line?';
    begin
        if not (SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Quote]) then begin
            exit;
        end;

        SalesSetup.Get();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, FreightSalesLine.Type::Item);
        SalesLine.SetFilter(FS_RF_FreightPrice, '<>%1', 0);
        if SalesLine.FindSet() then begin
            SalesSetup.TestField(FS_RF_DefaultFreightCode);
            FreightSalesLine.SetRange("Document Type", SalesHeader."Document Type");
            FreightSalesLine.SetRange("Document No.", SalesHeader."No.");
            FreightSalesLine.SetRange(Type, FreightSalesLine.Type::Resource);
            FreightSalesLine.SetRange("No.", SalesSetup.FS_RF_DefaultFreightCode);
            if FreightSalesLine.IsEmpty then begin
                if not Confirm(ReleasewithoutFreightLineQst, false) then begin
                    Error('');
                end;
            end;
            repeat
                TotalFreightPrice += SalesLine.FS_RF_FreightPrice;
            until SalesLine.Next() = 0;
            if FreightSalesLine.FindFirst() then begin
                if TotalFreightPrice <> FreightSalesLine."Amount Including VAT" then begin
                    if Confirm(FreightAmountMatchQst, false) then begin
                        FreightSalesLine.Validate("Unit Price", TotalFreightPrice);
                        FreightSalesLine.Modify();
                    end else begin
                        Error('');
                    end;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]
    local procedure OnBeforeConfirmPost_CheckOnlyShipOption(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        Selection: Integer;
        ShipQst: Label '&Ship';
        IsHideDialog: Boolean;
    begin
        if UserSetup.Get(UserId) and UserSetup.FS_RF_ShipOnly then begin
            case SalesHeader."Document Type" of
                SalesHeader."Document Type"::Order:
                    begin
                        SalesSetup.Get();
                        IsHideDialog := SalesSetup.FS_RF_HideDialogShipOnly;
                        IsHandled := true;
                        DefaultOption := 1;
                        Selection := 1;
                        if not IsHideDialog then Selection := StrMenu(ShipQst, DefaultOption);
                        SalesHeader.Ship := Selection = 1;
                        if Selection = 0 then begin
                            Result := false;
                            exit;
                        end;
                        Result := true;
                        SalesHeader."Print Posted Documents" := false;
                    end;
            end;
        end;
    end;

    //SendEmailServiceRequest
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", 'OnSetUsageFilterOnAfterSetFiltersByReportUsage', '', true, true)]
    local procedure ReportSelectionSales_OnSetUsageFilterOnAfterSetFiltersByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Option)
    begin
        if ReportUsage2 = "Report Selection Usage Sales"::FS_RF_ServiceRequest.AsInteger() then Rec.SetRange(Usage, "Report Selection Usage Sales"::FS_RF_ServiceRequest);
        if ReportUsage2 = "Report Selection Usage Sales"::FS_RF_DeliveryDocket.AsInteger() then Rec.SetRange(Usage, "Report Selection Usage Sales"::FS_RF_DeliveryDocket);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", 'OnInitUsageFilterOnElseCase', '', true, true)]
    local procedure ReportSelectionSales_OnInitUsageFilterOnElseCase(ReportUsage: Enum "Report Selection Usage"; var ReportUsage2: Enum "Report Selection Usage Sales")
    begin
        if ReportUsage = ReportUsage::FS_RF_ServiceRequest then ReportUsage2 := "Report Selection Usage Sales"::FS_RF_ServiceRequest;
        if ReportUsage = ReportUsage::FS_RF_DeliveryDocket then ReportUsage2 := "Report Selection Usage Sales"::FS_RF_DeliveryDocket;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforeGetSalesDocTypeUsage', '', true, true)]
    local procedure DocumentPrint_OnBeforeGetSalesDocTypeUsage(SalesHeader: Record "Sales Header"; var ReportSelectionUsage: Enum "Report Selection Usage"; var IsHandled: Boolean)
    begin
        if SalesHeader.FS_RF_ServiceRequestFlag and (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then begin
            IsHandled := true;
            ReportSelectionUsage := ReportSelectionUsage::FS_RF_ServiceRequest;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", 'OnCopySalesLinesToPurchaseLinesOnLineTypeValidate', '', true, true)]
    local procedure OnCopySalesLinesToPurchaseLinesOnLineTypeValidate(var PurchaseLine: Record "Purchase Line"; SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
        case SalesLine.Type of
            SalesLine.Type::" ":
                PurchaseLine.Type := PurchaseLine.Type::" ";
            SalesLine.Type::Item:
                PurchaseLine.Type := PurchaseLine.Type::Item;
            SalesLine.Type::Resource:
                PurchaseLine.Type := PurchaseLine.Type::Resource;
            else begin
                IsHandled := false;
                exit;
            end
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforeSendEmailDirectly', '', true, true)]
    local procedure ReportSelections_OnBeforeSendEmailDirectly(var ReportSelections: Record "Report Selections"; ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; var DocNo: Code[20]; var DocName: Text[150]; FoundBody: Boolean; FoundAttachment: Boolean; ServerEmailBodyFilePath: Text[250]; var DefaultEmailAddress: Text[250]; ShowDialog: Boolean; var TempAttachReportSelections: Record "Report Selections" temporary; var CustomReportSelection: Record "Custom Report Selection"; var AllEmailsWereSuccessful: Boolean; var IsHandled: Boolean)
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        Reminder: Record "Issued Reminder Header";
        ReminderLines: Record "Issued Reminder Line";
        SalesInvoice: Record "Sales Invoice Header";
        TempBlob: Codeunit "Temp Blob";
        OfficeAttachmentManager: Codeunit "Office Attachment Manager";
        DataTypeManagement: Codeunit "Data Type Management";
        DocumentRecord: RecordRef;
        FieldRef: FieldRef;
        EmailAddress: Text[250];
        SourceTableIDs, SourceRelationTypes : List of [Integer];
        SourceIDs: List of [Guid];
        AttachmentStream: array[25] of InStream;
        AttachmentName: array[25] of Text;
        TableId: Integer;
        countFileAttachment: Integer;
        RecRef: RecordRef;
        TableNumber: Integer;
        DocumentAttachment: Record "Document Attachment";
        FieldRef2: FieldRef;
        SalesHeader: Record "Sales Header";
        FieldRefServiceProviderFlag: FieldRef;
        FieldRefServiceProvider: FieldRef;
        ServiceProviderFlagValue: Boolean;
        OutStream: array[25] of OutStream;
        TempEmailItem: Record "Email Item" temporary;
    begin
        SalesSetup.Get();
        if not SalesSetup.FS_RF_DisableMultipleAttach then begin
            Utilities.SelectAttachmentFile(RecordVariant);
        end;

        RecRef.GetTable(RecordVariant);
        TableNumber := RecRef.Number;
        if (not (TableNumber in [Database::"Sales Header", Database::"Sales Invoice Header"])) or SalesSetup.FS_RF_DisableMultipleAttach then begin
            exit;
        end;
        DocumentRecord.GetTable(RecordVariant);
        // Primary Source - Document being sent by email
        SourceTableIDs.Add(DocumentRecord.Number());
        SourceIDs.Add(DocumentRecord.Field(DocumentRecord.SystemIdNo).Value());
        SourceRelationTypes.Add(Enum::"Email Relation Type"::"Primary Source".AsInteger());
        // Add any invoice in the reminder lines as a related source
        if DocumentRecord.Number() = Database::"Issued Reminder Header" then
            if Reminder.GetBySystemId(DocumentRecord.Field(DocumentRecord.SystemIdNo).Value()) then begin
                ReminderLines.SetFilter("Reminder No.", Reminder."No.");
                if ReminderLines.FindSet() then
                    repeat
                        if ReminderLines."Document Type" = ReminderLines."Document Type"::Invoice then
                            if SalesInvoice.Get(ReminderLines."Document No.") then begin
                                SourceTableIDs.Add(Database::"Sales Invoice Header");
                                SourceIDs.Add(SalesInvoice.SystemId);
                                SourceRelationTypes.Add(Enum::"Email Relation Type"::"Related Entity".AsInteger());
                            end;
                    until ReminderLines.Next() = 0;
            end;
        // Related Source - Customer or vendor receiving the document
        TableId := Utilities.GetAccountTableId(DocumentRecord.Number());
        if TableId = Database::Customer then
            if DataTypeManagement.FindFieldByName(DocumentRecord, FieldRef, 'Sell-to Customer No.') and Customer.Get(FieldRef.Value()) then begin
                SourceTableIDs.Add(Database::Customer);
                SourceIDs.Add(Customer.SystemId);
                SourceRelationTypes.Add(Enum::"Email Relation Type"::"Related Entity".AsInteger());
            end;
        if TableId = Database::Vendor then
            if DataTypeManagement.FindFieldByName(DocumentRecord, FieldRef, 'Buy-from Vendor No.') and Vendor.Get(FieldRef.Value()) then begin
                SourceTableIDs.Add(Database::Vendor);
                SourceIDs.Add(Vendor.SystemId);
                SourceRelationTypes.Add(Enum::"Email Relation Type"::"Related Entity".AsInteger());
            end;
        IsHandled := true;
        AllEmailsWereSuccessful := true;
        ReportSelections.ShowNoBodyNoAttachmentError(ReportUsage, FoundBody, FoundAttachment);
        TempEmailItem.SetSourceDocuments(SourceTableIDs, SourceIDs, SourceRelationTypes);

        FieldRefServiceProviderFlag := RecRef.Field(SalesHeader.FieldNo(FS_RF_ServiceRequestFlag));
        FieldRefServiceProvider := RecRef.Field(SalesHeader.FieldNo(FS_RF_ServiceProvider));
        ServiceProviderFlagValue := FieldRefServiceProviderFlag.Value;
        if ServiceProviderFlagValue then begin
            DefaultEmailAddress := ReportSelections.GetEmailAddressForVend(FieldRefServiceProvider.Value, RecordVariant, ReportUsage);
            CustomReportSelection.SetRange("Source Type", Database::Vendor);
            CustomReportSelection.SetRange("Source No.", FieldRefServiceProvider.Value);
        end;

        if FoundBody and not FoundAttachment then begin
            countFileAttachment := 1;
            TempBlob.CreateInStream(AttachmentStream[countFileAttachment]);
            TempEmailItem.AddAttachment(AttachmentStream[countFileAttachment], '');
            EmailAddress := CopyStr(Utilities.GetNextEmailAddressFromCustomReportSelection(CustomReportSelection, DefaultEmailAddress, ReportSelections.Usage, ReportSelections.Sequence), 1, MaxStrLen(EmailAddress));
            AllEmailsWereSuccessful := Utilities.EmailFileWithMultiAttachments(TempEmailItem, countFileAttachment, AttachmentStream, AttachmentName, ServerEmailBodyFilePath, DocNo, EmailAddress, DocName, not ShowDialog, ReportUsage.AsInteger(), SourceTableIDs, SourceIDs, SourceRelationTypes);
        end;
        if FoundAttachment then begin
            if ReportUsage = ReportSelections.Usage::JQ then begin
                ReportSelections.Usage := ReportUsage;
                CustomReportSelection.SetFilter(Usage, ReportSelections.GetFilter(Usage));
                if CustomReportSelection.FindFirst() then if CustomReportSelection.GetSendToEmail(true) <> '' then DefaultEmailAddress := CustomReportSelection."Send To Email";
            end;
            OfficeAttachmentManager.IncrementCount(TempAttachReportSelections.Count - 1);
            repeat
                EmailAddress := CopyStr(Utilities.GetNextEmailAddressFromCustomReportSelection(CustomReportSelection, DefaultEmailAddress, TempAttachReportSelections.Usage, TempAttachReportSelections.Sequence), 1, MaxStrLen(EmailAddress));
                Clear(TempBlob);
                countFileAttachment := 1;
                TempAttachReportSelections.SaveReportAsPDFInTempBlob(TempBlob, TempAttachReportSelections."Report ID", DocumentRecord, TempAttachReportSelections."Custom Report Layout Code", ReportUsage);
                TempBlob.CreateInStream(AttachmentStream[1]);
                TempEmailItem.AddAttachment(AttachmentStream[1], '');
                DocumentRecord.GetTable(RecordVariant);
                TableNumber := DocumentRecord.Number;
                FieldRef2 := DocumentRecord.Field(SalesHeader.FieldNo("No."));
                if TableNumber in [Database::"Sales Header", Database::"Sales Invoice Header"] then begin
                    DocumentAttachment.Reset();
                    DocumentAttachment.SetRange("Table ID", TableNumber);
                    DocumentAttachment.SetRange("No.", FieldRef2.Value);
                    DocumentAttachment.SetRange(FS_RF_AttachEmail, true);
                    if DocumentAttachment.FindSet() then
                        repeat
                            if DocumentAttachment."Document Reference ID".HasValue then begin
                                countFileAttachment += 1;
                                Clear(TempBlob);
                                Clear(OutStream[countFileAttachment]);
                                Clear(AttachmentStream[countFileAttachment]);
                                TempBlob.CreateOutStream(OutStream[countFileAttachment]);
                                DocumentAttachment."Document Reference ID".ExportStream(OutStream[countFileAttachment]);
                                if TempBlob.HasValue() then TempBlob.CreateInStream(AttachmentStream[countFileAttachment]);
                                AttachmentName[countFileAttachment] := DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension";
                                TempEmailItem.AddAttachment(AttachmentStream[countFileAttachment], AttachmentName[countFileAttachment]);
                            end;
                        until DocumentAttachment.Next() = 0;
                end;
                AllEmailsWereSuccessful := AllEmailsWereSuccessful and Utilities.EmailFileWithMultiAttachments(TempEmailItem, countFileAttachment, AttachmentStream, AttachmentName, ServerEmailBodyFilePath, DocNo, EmailAddress, DocName, not ShowDialog, ReportUsage.AsInteger(), SourceTableIDs, SourceIDs, SourceRelationTypes);
            until TempAttachReportSelections.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateUnitPrice', '', true, true)]
    local procedure OnAfterUpdateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer)
    begin
        Utilities.GetCostForSalesLine(SalesLine, CalledByFieldNo);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnAfterQuantityOnAfterValidate', '', false, false)]
    local procedure OnAfterQuantityOnAfterValidate(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; sender: Page "Sales Order Subform")
    begin
        if SalesLine.Type = SalesLine.Type::Resource then begin
            sender.SaveRecord();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderHeader', '', true, true)]
    local procedure OnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; var SalesQuoteHeader: Record "Sales Header")
    var
        SalesOrderTempl: Record FS_RF_SalesOrderTemplate;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesOrderTemplates: Page FS_RF_SalesOrderTemplateList;
    begin
        if not (SalesSetup.Get() and SalesSetup.FS_RF_DisableSalesOrderTempl) then begin
            Commit();
            SalesOrderTemplates.LookupMode := true;
            SalesOrderTemplates.Editable := false;
            if SalesOrderTemplates.RunModal() = Action::LookupOK then begin
                SalesOrderTemplates.GetRecord(SalesOrderTempl);
                SalesOrderTempl.TestField(FS_RF_NoSeries);
                NoSeriesMgt.InitSeries(NoSeriesMgt.GetNoSeriesWithCheck(SalesOrderTempl.FS_RF_NoSeries, false, SalesOrderHeader."No. Series"), SalesOrderHeader."No. Series", SalesOrderHeader."Posting Date", SalesOrderHeader."No.", SalesOrderHeader."No. Series");
            end
            else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeConfirmDownloadShipment', '', true, true)]
    local procedure OnBeforeConfirmDownloadShipment(var SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
    begin
        Result := false;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnCopyToTempLinesOnAfterSetFilters', '', true, true)]
    local procedure OnCopyToTempLinesOnAfterSetFilters(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        UserSetup: Record "User Setup";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then exit;
        if UserSetup.Get(UserId) and UserSetup.FS_RF_ShipOnly then begin
            SalesLine.SetFilter(Type, '%1|%2', SalesLine.Type::" ", SalesLine.Type::Item);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnAfterSendEmailDirectly', '', true, true)]
    local procedure OnAfterSendEmailDirectly(ReportUsage: Integer; RecordVariant: Variant; var AllEmailsWereSuccessful: Boolean)
    var
        SalesHeader: Record "Sales Header";
        RecRef: RecordRef;
        TableNumber: Integer;
    begin
        RecRef.GetTable(RecordVariant);
        TableNumber := RecRef.Number;
        if not AllEmailsWereSuccessful then
            exit;
        if TableNumber = Database::"Sales Header" then begin
            SalesHeader := RecordVariant;
            if not SalesHeader.FS_RF_DocumentEmailSent then begin
                SalesHeader.FS_RF_DocumentEmailSent := true;
                SalesHeader.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforeSendEmailDirectly', '', true, true)]

    local procedure OnBeforeSendEmailDirectly(var ReportSelections: Record "Report Selections"; ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; var DocNo: Code[20]; var DocName: Text[150]; FoundBody: Boolean; FoundAttachment: Boolean; ServerEmailBodyFilePath: Text[250]; var DefaultEmailAddress: Text[250]; ShowDialog: Boolean; var TempAttachReportSelections: Record "Report Selections" temporary; var CustomReportSelection: Record "Custom Report Selection"; var AllEmailsWereSuccessful: Boolean; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        RecRef: RecordRef;
        TableNumber: Integer;
    begin
        RecRef.GetTable(RecordVariant);
        TableNumber := RecRef.Number;
        if not AllEmailsWereSuccessful then
            exit;
        if TableNumber = Database::"Sales Header" then begin
            if SalesHeader.Get(SalesHeader."Document Type"::Order, DocNo) then begin
                if not SalesHeader.FS_RF_DocumentEmailSent then begin
                    SalesHeader.FS_RF_DocumentEmailSent := true;
                    SalesHeader.Modify();
                end;
            end
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'onAfterInsertEvent', '', false, false)]
    local procedure OnCreatePurchaseHeaderOnBeforeInsert(var rec: Record "Purchase Header")
    var
        SalesHeader: Record "Sales Header";
    begin
        if rec."Document Type" <> rec."Document Type"::Invoice then
            exit;
        if rec.FS_RF_LinkedOrder = '' then
            exit;
        if rec.FS_RF_SourceType <> Database::"Sales Header" then
            exit;
        if SalesHeader.Get(SalesHeader."Document Type"::Order, rec.FS_RF_LinkedOrder) then begin
            SalesHeader.FS_RF_LinkedPI := rec."No.";
            SalesHeader.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'onAfterInsertEvent', '', false, false)]
    local procedure OnCreatePurreInsert(var rec: Record "Sales Header")
    begin
        if rec."Document Type" <> rec."Document Type"::Order then
            exit;
        rec.SetHideValidationDialog(true);
        if rec."Requested Delivery Date" = 0D then begin
            rec.Validate("Requested Delivery Date", WorkDate());

        end;
        rec."Compress Prepayment" := false;
        rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'FS_RF_ServiceProvider', false, false)]
    local procedure MyProcedure(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        ContractorShiptoAddress: Record FS_RF_ContractorShipToAddress;
        Vendor: Record Vendor;
        VendorRead: Boolean;
    begin
        if Rec.FS_RF_ServiceProvider = '' then begin
            ClearServiceProviderAddress(Rec);
            exit;
        end;

        if Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order] then begin
            if Vendor.Get(Rec.FS_RF_ServiceProvider) then begin
                VendorRead := true;
                Rec.FS_RF_PhoneNo := Vendor."Phone No.";
            end;
        end;

        if not (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order]) then
            exit;
        GetSalesSetup();
        SalesSetup.TestField(FS_RF_DefContrShipToAddr);
        if ContractorShiptoAddress.Get(Rec.FS_RF_ServiceProvider, SalesSetup.FS_RF_DefContrShipToAddr) then
            Rec.Validate(FS_RF_ContractorShipTo, ContractorShiptoAddress.FS_RF_Code)
        else begin
            if not VendorRead then
                Vendor.Get(Rec.FS_RF_ServiceProvider);
            Rec.Validate("Ship-to Address", Vendor.Address);
            Rec.Validate("Ship-to Address 2", Vendor."Address 2");
            Rec.Validate("Ship-to City", Vendor.City);
            Rec.Validate("Ship-to Contact", Vendor.Contact);
            Rec.Validate("Ship-to Country/Region Code", Vendor."Country/Region Code");
            Rec.Validate("Ship-to County", Vendor.County);
            Rec.Validate("Ship-to Name", Vendor.Name);
            Rec.Validate("Ship-to Name 2", Vendor."Name 2");
            Rec.Validate("Ship-to Post Code", Vendor."Post Code");
        end;
        ClearServiceProviderAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePosting', '', false, false)]
    local procedure OnAfterFinalizePosting(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    var
        SalesOrder: Record "Sales Header";
    begin

        if not PurchInvHeader.IsEmpty then begin
            if PurchInvHeader.FS_RF_LinkedOrder = '' then
                exit;
            if SalesOrder.Get(1, PurchInvHeader.FS_RF_LinkedOrder) then begin
                SalesOrder.FS_RF_ApprForCustInvoice := true;
                SalesOrder.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeValidatePostingAndDocumentDate', '', false, false)]
    local procedure OnBeforeValidatePostingAndDocumentDate(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;
        SalesHeader.TestField("Package Tracking No.");
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Inv. - Update", 'OnAfterRecordChanged', '', false, false)]

    local procedure OnAfterRecordChanged(var SalesInvoiceHeader: Record "Sales Invoice Header"; xSalesInvoiceHeader: Record "Sales Invoice Header"; var IsChanged: Boolean)
    begin
        if not IsChanged then
            IsChanged := SalesInvoiceHeader."External Document No." <> xSalesInvoiceHeader."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Inv. Header - Edit", 'OnOnRunOnBeforeTestFieldNo', '', false, false)]
    local procedure OnOnRunOnBeforeTestFieldNo(var SalesInvoiceHeader: Record "Sales Invoice Header"; SalesInvoiceHeaderRec: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader."External Document No." := SalesInvoiceHeaderRec."External Document No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Availability Forms Mgt", 'OnAfterCalculateNeed', '', false, false)]
    local procedure ItemAvailabilityFormsMgt_OnAfterCalculateNeed(var Item: Record Item; var GrossRequirement: Decimal; var PlannedOrderReceipt: Decimal; var ScheduledReceipt: Decimal)
    begin
        Item.CalcFields(FS_RF_QtyonBlanketSO);
        GrossRequirement += Item.FS_RF_QtyonBlanketSO;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Availability Forms Mgt", 'OnAfterCalcItemPlanningFields', '', false, false)]
    local procedure ItemAvailabilityFormsMgt_OnAfterCalcItemPlanningFields(var Item: Record Item)
    begin
        Item.CalcFields(FS_RF_QtyonBlanketSO);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Availability Line List", 'OnItemCalcFields', '', false, false)]
    local procedure ItemAvailabilityLineList_OnItemCalcFields(var Item: Record Item)
    begin
        Item.CalcFields(FS_RF_QtyonBlanketSO);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Availability Line List", 'OnAfterMakeEntries', '', false, false)]
    local procedure ItemAvailabilityLineList_OnAfterMakeEntries(var Item: Record Item; var ItemAvailabilityLine: Record "Item Availability Line"; AvailabilityType: Option; Sign: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        case AvailabilityType of
            0:
                begin
                    if Item.FS_RF_QtyonBlanketSO = 0 then
                        exit;
                    ItemAvailabilityLine."Table No." := Database::"Sales Line";
                    ItemAvailabilityLine.QuerySource := Item.FieldNo(FS_RF_QtyonBlanketSO);
                    ItemAvailabilityLine.Name := CopyStr(SalesLine.TableCaption(), 1, MaxStrLen(ItemAvailabilityLine.Name));
                    ItemAvailabilityLine.Quantity := Item.FS_RF_QtyonBlanketSO * Sign;
                    ItemAvailabilityLine.Insert();
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Availability Line List", 'OnBeforeLookupEntries', '', false, false)]
    local procedure ItemAvailabilityLineList_OnBeforeLookupEntries(ItemAvailabilityLine: Record "Item Availability Line"; var Item: Record Item; var IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin
        case ItemAvailabilityLine."Table No." of
            Database::"Sales Line":
                begin
                    if ItemAvailabilityLine.QuerySource = Item.FieldNo(FS_RF_QtyonBlanketSO) then begin
                        SalesLine.FindLinesWithItemToPlan(Item, SalesLine."Document Type"::"Blanket Order");
                        SalesLine.SetRange("Drop Shipment", false);
                        PAGE.RunModal(0, SalesLine);
                        IsHandled := true;
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Available to Promise", 'OnAfterCalcGrossRequirement', '', false, false)]
    local procedure AvailabletoPromise_OnAfterCalcGrossRequirement(var Item: Record Item; var GrossRequirement: Decimal)
    begin
        Item.CalcFields(FS_RF_QtyonBlanketSO);
        GrossRequirement += Item.FS_RF_QtyonBlanketSO;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', false, false)]
    local procedure GenJnlPostLine_OnBeforeCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    begin
        CustLedgerEntry.Validate(FS_RF_CampaignNo, GenJournalLine."Campaign No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, false)]
    local procedure GenJnlPostLine_OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register")
    begin
        GLEntry.Validate(FS_RF_CampaignNo, GenJournalLine."Campaign No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Payment Registration Mgt.", 'OnBeforeGenJnlLineInsert', '', false, false)]
    local procedure PaymentRegistrationMgt_OnBeforeGenJnlLineInsert(var GenJournalLine: Record "Gen. Journal Line"; TempPaymentRegistrationBuffer: Record "Payment Registration Buffer" temporary)
    var
        PaymentRegistrationSetup: Record "Payment Registration Setup";
    begin
        PaymentRegistrationSetup.Get(UserId);
        GenJournalLine.Validate("Campaign No.", PaymentRegistrationSetup.FS_RF_CampaignNo);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnInsertOnAfterCheckInventoryConflict', '', false, false)]
    local procedure SalesLine_OnInsertOnAfterCheckInventoryConflict(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var SalesLine2: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then begin
            SalesLine.Validate(FS_RF_CampaignNo, SalesHeader."Campaign No.");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInitOutstandingQty', '', false, false)]
    local procedure SalesLine_OnAfterInitOutstandingQty(var SalesLine: Record "Sales Line")
    var
        OrderSalesLine: Record "Sales Line";
        OrderQuantity: Decimal;
    begin
        if not SalesLine.IsCreditDocType() then begin
            if SalesLine."Document Type" = SalesLine."Document Type"::"Blanket Order" then begin
                OrderSalesLine.SetRange("Document Type", OrderSalesLine."Document Type"::Order);
                OrderSalesLine.SetRange("Blanket Order No.", SalesLine."Document No.");
                OrderSalesLine.SetRange("Blanket Order Line No.", SalesLine."Line No.");
                if OrderSalesLine.FindSet() then begin
                    repeat
                        OrderQuantity += OrderSalesLine."Quantity (Base)";
                    until OrderSalesLine.Next() = 0;
                end;
                SalesLine.FS_RF_OutstandingQty := SalesLine."Quantity (Base)" - OrderQuantity;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnRunOnBeforeValidateBlanketOrderSalesLineQtytoShip', '', false, false)]
    local procedure OnRunOnBeforeValidateBlanketOrderSalesLineQtytoShip(var BlanketOrderSalesLine: Record "Sales Line"; SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        BlanketOrderSalesLine.FS_RF_OutstandingQty := BlanketOrderSalesLine."Outstanding Qty. (Base)" - SalesOrderLine."Quantity (Base)";
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        Mgt: Codeunit FS_RF_Management;
        Utilities: Codeunit FS_RF_Utilities;
        SalesSetupRead: Boolean;

    procedure ClearServiceProviderAddress(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.Validate(FS_RF_ShipToAddress, '');
        SalesHeader.Validate(FS_RF_ShipToAddress2, '');
        SalesHeader.Validate(FS_RF_ShipToCity, '');
        SalesHeader.Validate(FS_RF_ShipToContact, '');
        SalesHeader.Validate(FS_RF_ShipToCounty, '');
        SalesHeader.Validate(FS_RF_ShipToName, '');
        SalesHeader.Validate(FS_RF_ShipToName2, '');
        SalesHeader.Validate(FS_RF_ShipToPostCode, '');
    end;

    procedure GetSalesSetup()
    begin
        if not SalesSetupRead then begin
            SalesSetup.Get();
            SalesSetupRead := true;
        end;
    end;
}