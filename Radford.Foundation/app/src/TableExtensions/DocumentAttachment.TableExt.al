tableextension 50003 FS_RF_DocumentAttachment extends "Document Attachment"
{
    fields
    {
        field(50000; FS_RF_AttachEmail; Boolean)
        {
            Caption = 'Attach to Email';
            DataClassification = CustomerContent;
        }
    }
}
