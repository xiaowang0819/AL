codeunit 50006 FS_RF_Management
{
    procedure UpdatedSalesHeaderAfterSentEmail(SentEmail: Record "Sent Email")
    var
        ReportSelection: Record "Report Selections";
        SalesHeader: Record "Sales Header";
        RecRef: RecordRef;
    begin
        ReportSelection.SetRange("Report ID", SentEmail.FSG_GLD_ReportID);
        ReportSelection.SetRange(Usage, ReportSelection.Usage::FS_RF_ServiceRequest);
        if ReportSelection.IsEmpty() then begin
            exit;
        end;

        if RecRef.Get(SentEmail.FSG_GLD_SourceRecordId) then begin
            if RecRef.Number() = Database::"Sales Header" then begin
                RecRef.SetTable(SalesHeader);
                if SalesHeader.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
                    if not SalesHeader.FS_RF_DocumentEmailSent then begin
                        SalesHeader.Validate(FS_RF_DocumentEmailSent, true);
                        SalesHeader.Modify();
                    end;
                end;
            end;
        end;
    end;
}