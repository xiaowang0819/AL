tableextension 50023 FS_RF_ReturnReceiptLine extends "Return Receipt Line"
{
    fields
    {
        field(50005; FS_RF_ExternalDocumentNo; Code[50])
        {
            Caption = 'External Document No.';
            DataClassification = AccountData;
        }
        field(50007; FS_RF_CampaignNo; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Campaign."No.";
        }
    }
}