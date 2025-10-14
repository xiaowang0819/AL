codeunit 50007 FS_RF_UpdateEmailField
{
    trigger OnRun()
    var
        DocAttachment: Record "Document Attachment";
        Window: Dialog;
        Progress: Integer;
        UpdateConfLbl: Label 'Do you also want to update the Exclude from Email based on Attach to Email for all existing document attachments?';
        ProgressMsg: Label 'Updating Document Attachments...\Progress: #1\Total: #2';
    begin
        if not Confirm(UpdateConfLbl) then begin
            exit;
        end;

        Window.Open(ProgressMsg);

        DocAttachment.SetRange(FS_RF_AttachEmail, true);
        if DocAttachment.FindSet(true, true) then begin
            Window.Update(2, DocAttachment.Count());
            repeat
                DocAttachment.FSG_GLD_ExcludeFromEmail := false;
                DocAttachment.Modify();
                Progress += 1;

                if Progress mod 1000 = 0 then begin
                    Window.Update(1, Progress);
                end;
            until DocAttachment.Next() = 0;
        end;
    end;
}