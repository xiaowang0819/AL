pageextension 50039 FS_RF_PaymentRecJnl extends "Payment Reconciliation Journal"
{
    layout
    {
        addafter(GetAppliedToDocumentNo)
        {
            field(FS_RF_CampaignNo; Rec.FS_RF_CampaignNo)
            {
                ApplicationArea = All;
            }
        }
    }
}
