pageextension 50045 FS_RF_PaymentRegistrationSetup extends "Payment Registration Setup"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            field(FS_RF_CampaignNo; Rec.FS_RF_CampaignNo)
            {
                ApplicationArea = All;
            }
        }
    }
}
