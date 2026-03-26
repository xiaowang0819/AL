tableextension 50026 FS_RF_GLEntry extends "G/L Entry"
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
