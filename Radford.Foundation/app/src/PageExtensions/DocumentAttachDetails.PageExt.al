pageextension 50014 FS_RF_DocumentAttachDetails extends "Document Attachment Details"
{
    layout
    {
        addlast(Group)
        {
            field(FS_RF_AttachEmail; Rec.FS_RF_AttachEmail)
            {
                ApplicationArea = All;
                Visible = false;
                Enabled = false;
            }
        }
    }
}