pageextension 50051 FS_RF_AttachItGroups extends FSG_AIT_Groups
{
    actions
    {
        addlast(Processing)
        {
            action(FS_RF_MigrateAttachments)
            {
                ApplicationArea = All;
                Caption = 'Migrate Standard Attachments';
                Image = Export;
                ToolTip = 'Migrates all standard attachments to relevant Attach-It groups.';

                trigger OnAction()
                var
                    AttachmentMigration: Report FS_RF_AttachmentMigration;
                begin
                    AttachmentMigration.RunModal();
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(FS_RF_MigrateAttachments_Promoted; FS_RF_MigrateAttachments)
            {
            }
        }
    }
}
