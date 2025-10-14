report 50005 FS_RF_ImportGenJournal
{
    ApplicationArea = All;
    Caption = 'Import General Journal';
    UsageCategory = Administration;
    ProcessingOnly = true;
    UseRequestPage = false;

    trigger OnPostReport()
    begin
        Xmlport.Run(Xmlport::FS_RF_ImportGenJournal, false, true);
    end;
}
