tableextension 50028 FS_RF_PaymentRegistrationSetup extends "Payment Registration Setup"
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
