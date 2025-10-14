report 50006 FS_RF_AttachmentMigration
{
    Caption = 'Attachment Migration';
    UsageCategory = None;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Group; FSG_AIT_Group)
        {
            RequestFilterFields = Code, TableId, StorageType;
            CalcFields = TableView;

            trigger OnAfterGetRecord()
            var
                DocAttachment: Record "Document Attachment";
                DocAttachForDel: Record "Document Attachment";
                RecRef: RecordRef;
                Window: Dialog;
                Progress: Integer;
                Total: Integer;
                LastUpdateDatetime: DateTime;
                StartDatetime: DateTime;
                AvgBatchDuration: Duration;
                ProgressMsg: Label @'
Migrating attachments... 
Group #1 
Table #2 
Progress: #3 
Total: #4', Comment = '#1 = Group Code, #2 = Table Name, #3 = Progress, #4 = Total';
                FindingMsg: Label 'Finding attachments to migrate...';
                StartLogMsg: Label 'Starting attachment migration for group %1, table %2, batch size %3, for a total of %4 attachments.', Comment = '%1 = Group Code, %2 = Table Name, %3 = Batch Size, %4 = Total Attachments';
                BatchLogMsg: Label 'Migration batch complete, average batch time: %1, progress total: %2, delete attachments: %3.', Comment = '%1 = Average Batch Time, %2 = Progress Total, %3 = Delete Attachments';
                TimeOutLogMsg: Label 'Migration stopped due to job queue timeout, average batch time: %1, progress total: %2, delete attachments: %3.', Comment = '%1 = Average Batch Time, %2 = Progress Total, %3 = Delete Attachments';
                CompleteLogMsg: Label 'Attachment migration complete for group %1, table %2.', Comment = '%1 = Group Code, %2 = Table Name';
            begin
                Group.TestField(TableId);
                if Group.StorageType = Group.StorageType::Attachment then begin
                    Group.FieldError(StorageType);
                end;
                RecRef.Open(Group.TableId);
                WindowOpen(Window, ProgressMsg);
                WindowUpdate(Window, 1, Group.Code);
                WindowUpdate(Window, 2, RecRef.Caption());
                WindowUpdate(Window, 3, FindingMsg);
                DocAttachment.SetRange("Table ID", Group.TableId);
                Total:=FilterDocAttachmentByGroup(DocAttachment, Group);
                WindowUpdate(Window, 4, Total);
                CreateJobQueueLogEntryCommit(StrSubstNo(StartLogMsg, Group.Code, RecRef.Caption(), BatchSize, Total));
                if not DocAttachment.FindSet()then begin
                    CurrReport.Skip();
                end;
                StartDatetime:=CurrentDateTime();
                LastUpdateDatetime:=CurrentDateTime();
                repeat if MigrationDocAttach(Group, DocAttachment)then begin
                        DocAttachForDel:=DocAttachment;
                        DocAttachForDel.Mark(true);
                    end;
                    Progress+=1;
                    AvgBatchDuration:=(CurrentDateTime() - StartDatetime) div Progress * BatchSize;
                    if Progress mod BatchSize = 0 then begin
                        DeleteMarkedDocAttachCommit(DocAttachForDel);
                        if(CurrentDateTime() - StartDatetime) + AvgBatchDuration * 2 >= JobQueueEntry."Job Timeout" then begin
                            CreateJobQueueLogEntryCommit(StrSubstNo(TimeOutLogMsg, AvgBatchDuration, Progress, DeleteAttachments));
                            WindowClose(Window, StrSubstNo(TimeOutLogMsg, AvgBatchDuration, Progress, DeleteAttachments));
                            CurrReport.Break();
                        end
                        else
                        begin
                            CreateJobQueueLogEntryCommit(StrSubstNo(BatchLogMsg, AvgBatchDuration, Progress, DeleteAttachments));
                        end;
                    end;
                    if CurrentDateTime() - LastUpdateDatetime > 1000 then begin
                        LastUpdateDatetime:=CurrentDateTime();
                        WindowUpdate(Window, 3, Progress);
                    end;
                until DocAttachment.Next() = 0;
                DeleteMarkedDocAttachCommit(DocAttachForDel);
                CreateJobQueueLogEntryCommit(StrSubstNo(BatchLogMsg, AvgBatchDuration, Progress, DeleteAttachments));
                CreateJobQueueLogEntryCommit(StrSubstNo(CompleteLogMsg, Group.Code, RecRef.Caption()));
                WindowClose(Window, StrSubstNo(CompleteLogMsg, Group.Code, RecRef.Caption()));
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
                    InstructionalText = @'
This report migrates Documents Attachments for records in each Attach-It Group to the storage type specified on the group.

We recommend running this report via a recurring Job Queue Entry outside of business hours if you have a large number of attachments to migrate.';

                    field(BatchSizeField; BatchSize)
                    {
                        Caption = 'Batch size';
                        ToolTip = 'Specifies the number of attachments per batch. After each batch changes are committed to the database.';
                        MinValue = 1;
                        ApplicationArea = All;
                    }
                    field(DeleteAttachmentsField; DeleteAttachments)
                    {
                        Caption = 'Delete migrated attachments';
                        ToolTip = 'Specifies if attachments that are migrated will be deleted after each batch.';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var JobQueueEntry: Record "Job Queue Entry";
    FileMgt: Codeunit "File Management";
    BatchSize: Integer;
    DeleteAttachments: Boolean;
    trigger OnInitReport()
    begin
        DeleteAttachments:=true;
        BatchSize:=500;
    end;
    trigger OnPreReport()
    begin
        CreateJobQueueEntry();
    end;
    local procedure CreateJobQueueEntry()
    var
        DescTxt: Label 'Attachment Migration for Attach-It';
    begin
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", Report::FS_RF_AttachmentMigration);
        JobQueueEntry.SetRange(Status, JobQueueEntry.Status::"In Process");
        JobQueueEntry.SetCurrentKey(SystemCreatedAt); // Try to get the temporarily created entry if ran in foreground 
        if JobQueueEntry.FindLast()then begin
            exit;
        end
        else
        begin
            JobQueueEntry.SetRange(Status);
            if JobQueueEntry.FindLast()then begin
                exit;
            end;
        end;
        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run":=JobQueueEntry."Object Type to Run"::Report;
        JobQueueEntry."Object ID to Run":=Report::FS_RF_AttachmentMigration;
        JobQueueEntry.Description:=DescTxt;
        JobQueueEntry."Job Timeout":=1000 * 60 * 60 * 4;
        JobQueueEntry.Insert(true);
    end;
    local procedure CreateJobQueueLogEntryCommit(Message: Text)
    var
        JobQueueLogEntry: Record "Job Queue Log Entry";
    begin
        JobQueueEntry.InsertLogEntry(JobQueueLogEntry);
        JobQueueLogEntry.Status:=JobQueueLogEntry.Status::Success;
        JobQueueLogEntry."Error Message":=CopyStr(Message, 1, MaxStrLen(JobQueueEntry."Error Message"));
        JobQueueLogEntry."Start Date/Time":=CurrentDateTime();
        JobQueueLogEntry.Modify();
        Commit();
    end;
    local procedure FilterDocAttachmentByGroup(var DocAttachment: Record "Document Attachment"; Group: Record FSG_AIT_Group)Count: Integer var
        RecRef: RecordRef;
    begin
        if Group.TableView.HasValue()then begin
            if DocAttachment.FindSet()then begin
                repeat Clear(RecRef);
                    if GetRefTable(RecRef, DocAttachment)then begin
                        if IsWithinGroupFilter(RecRef, Group)then begin
                            DocAttachment.Mark(true);
                            Count+=1;
                        end;
                    end;
                until DocAttachment.Next() = 0;
            end;
            DocAttachment.MarkedOnly(true);
        end
        else
        begin
            Count:=DocAttachment.Count();
        end;
    end;
    procedure IsWithinGroupFilter(RecRef: RecordRef; Group: Record FSG_AIT_Group): Boolean var
        TempRecRef: RecordRef;
    begin
        if Group.TableView.HasValue()then begin
            TempRecRef.Open(RecRef.Number(), true);
            TempRecRef.Copy(RecRef);
            TempRecRef.Insert();
            TempRecRef.Reset();
            TempRecRef.SetView(Group.GetTableView(false));
            exit(not TempRecRef.IsEmpty());
        end;
        exit(true);
    end;
    local procedure MigrationDocAttach(Group: Record FSG_AIT_Group; DocAttachment: Record "Document Attachment"): Boolean var
        GroupAddress: Codeunit FSG_AIT_GroupAddress;
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        WriteStream: OutStream;
        ReadStream: InStream;
        FileName: Text;
    begin
        if GetRefTable(RecRef, DocAttachment)then begin
            TempBlob.CreateOutStream(WriteStream);
            DocAttachment.ExportToStream(WriteStream);
            TempBlob.CreateInStream(ReadStream);
            FileName:=StrSubstNo('%1 (%2).%3', DocAttachment."File Name", DocAttachment.ID, DocAttachment."File Extension");
            FileName:=FileName.Replace('#', '');
            FileName:=FileMgt.GetSafeFileName(FileName);
            GroupAddress.StoreFileToGroup(Group, RecRef, FileName, ReadStream);
            exit(true);
        end;
    end;
    local procedure DeleteMarkedDocAttachCommit(var DocAttachment: Record "Document Attachment")
    begin
        if DeleteAttachments then begin
            DocAttachment.MarkedOnly(true);
            DocAttachment.DeleteAll(true);
            DocAttachment.Reset();
        end;
        Commit();
    end;
    // In 27 we can probably use DocAttachment.GetRefTable
    local procedure GetRefTable(var RecRef: RecordRef; DocumentAttachment: Record "Document Attachment"): Boolean var
        FieldRef: FieldRef;
        FieldNo: Integer;
    begin
        RecRef.Open(DocumentAttachment."Table ID");
        if TableHasNumberFieldPrimaryKey(RecRef.Number(), FieldNo)then begin
            FieldRef:=RecRef.Field(FieldNo);
            FieldRef.SetRange(DocumentAttachment."No.");
        end;
        if TableHasDocTypePrimaryKey(RecRef.Number(), FieldNo)then begin
            FieldRef:=RecRef.Field(FieldNo);
            FieldRef.SetRange(DocumentAttachment."Document Type");
        end;
        if TableHasLineNumberPrimaryKey(RecRef.Number(), FieldNo)then begin
            FieldRef:=RecRef.Field(FieldNo);
            FieldRef.SetRange(DocumentAttachment."Line No.");
        end;
        if TableHasVATReportConfigCodePrimaryKey(RecRef.Number(), FieldNo)then begin
            FieldRef:=RecRef.Field(FieldNo);
            FieldRef.SetRange(DocumentAttachment."VAT Report Config. Code");
        end;
        exit(RecRef.FindFirst());
    end;
    local procedure TableHasNumberFieldPrimaryKey(TableNo: Integer; var FieldNo: Integer): Boolean var
        Result: Boolean;
    begin
        case TableNo of Database::Customer, Database::Vendor, Database::Item, Database::Employee, Database::"Fixed Asset", Database::Job, Database::Resource, Database::"VAT Report Header": begin
            FieldNo:=1;
            exit(true);
        end;
        Database::"Sales Header", Database::"Sales Line", Database::"Purchase Header", Database::"Purchase Line", Database::"Sales Invoice Header", Database::"Sales Invoice Line", Database::"Sales Cr.Memo Header", Database::"Sales Cr.Memo Line", Database::"Purch. Inv. Header", Database::"Purch. Inv. Line", Database::"Purch. Cr. Memo Hdr.", Database::"Purch. Cr. Memo Line": begin
            FieldNo:=3;
            exit(true);
        end;
        end;
        Result:=false;
        exit(Result);
    end;
    local procedure TableHasDocTypePrimaryKey(TableNo: Integer; var FieldNo: Integer): Boolean var
        Result: Boolean;
    begin
        case TableNo of Database::"Sales Header", Database::"Sales Line", Database::"Purchase Header", Database::"Purchase Line": begin
            FieldNo:=1;
            exit(true);
        end;
        end;
        Result:=false;
        exit(Result);
    end;
    local procedure TableHasLineNumberPrimaryKey(TableNo: Integer; var FieldNo: Integer): Boolean var
        Result: Boolean;
    begin
        case TableNo of Database::"Sales Line", Database::"Sales Invoice Line", Database::"Sales Cr.Memo Line", Database::"Purchase Line", Database::"Purch. Inv. Line", Database::"Purch. Cr. Memo Line": begin
            FieldNo:=4;
            exit(true);
        end;
        end;
        Result:=false;
        exit(Result);
    end;
    local procedure TableHasVATReportConfigCodePrimaryKey(TableNo: Integer; var FieldNo: Integer): Boolean begin
        if TableNo = Database::"VAT Report Header" then begin
            FieldNo:=2;
            exit(true);
        end;
        exit(false);
    end;
    local procedure WindowOpen(var Window: Dialog; Message: Text)
    var
    begin
        if not GuiAllowed()then begin
            exit;
        end;
        Window.Open(Message);
    end;
    local procedure WindowUpdate(var Window: Dialog; Number: Integer; Value: Variant)
    begin
        if not GuiAllowed()then begin
            exit;
        end;
        Window.Update(Number, Value);
    end;
    local procedure WindowClose(var Window: Dialog; Message: Text)
    var
        JobQueueLogEntry: Record "Job Queue Log Entry";
    begin
        if not GuiAllowed()then begin
            exit;
        end;
        Window.Close();
        JobQueueLogEntry.SetRange(ID, JobQueueEntry.ID);
        Page.Run(Page::"Job Queue Log Entries", JobQueueLogEntry);
        Message(Message);
    end;
}
