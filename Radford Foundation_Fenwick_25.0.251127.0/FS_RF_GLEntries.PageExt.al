pageextension 50041 FS_RF_GLEntries extends "General Ledger Entries"
{
    layout
    {
        addbefore("Source Currency Code")
        {
            field(FS_RF_CampaignNo; Rec.FS_RF_CampaignNo)
            {
                ApplicationArea = All;
            }
        }
    }
}
