tableextension 50025 FS_RF_BankAccRecLine extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; FS_RF_CampaignNo; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = CustomerContent;
            TableRelation = Campaign;
        }
    }
}
