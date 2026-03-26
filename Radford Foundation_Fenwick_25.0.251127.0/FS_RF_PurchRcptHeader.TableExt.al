tableextension 50014 FS_RF_PurchRcptHeader extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50003; FS_RF_ExternalDocumentNo; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
    }
}
