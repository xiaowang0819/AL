pageextension 50044 FS_RF_CustLedgEntries extends "Customer Ledger Entries"
{
    layout
    {
        addbefore("Currency Code")
        {
            field(FS_RF_CampaignNo; Rec.FS_RF_CampaignNo)
            {
                ApplicationArea = All;
            }
        }
    }
}