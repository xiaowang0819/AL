tableextension 50022 FS_RF_SalesCrMemoLine extends "Sales Cr.Memo Line"
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