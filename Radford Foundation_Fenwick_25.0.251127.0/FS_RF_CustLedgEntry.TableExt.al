tableextension 50027 FS_RF_CustLedgEntry extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; FS_RF_CampaignNo; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = CustomerContent;
            TableRelation = Campaign;
            Editable = false;
        }
    }
}
