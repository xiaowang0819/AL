pageextension 78009 SalesQuoteExt extends "Sales Quote"
{
    layout
    {
        addafter(Status)
        {
            field("Opportunity"; Rec."Opportunity")
            {
                ApplicationArea = All;
                Caption = 'Opportunity';
                ToolTip = 'Indicates the current opportunity status (Hot, Medium).';
            }
        }
    }
}

pageextension 78010 SalesQuotesListExt extends "Sales Quotes"
{
    layout
    {
        addafter("No.")
        {
            field("Opportunity"; Rec."Opportunity")
            {
                ApplicationArea = All;
                Caption = 'Opportunity';
                ToolTip = 'Indicates the current opportunity status (Hot, Medium).';
                Editable = true;
            }
        }
    }
}

// pageextension 78015 QuoteDownLoad extends "Sales Quote"
// {
//     actions
//     {
//         addlast("&Quote")
//         {
//             action(DownLoadQuote)
//             {
//                 ApplicationArea = All;
//                 Caption = 'DownLoad Quote - FW';
//                 Image = Download;

//                 trigger OnAction()
//                 var
//                     SalesHeader: Record "Sales Header";
//                     FileName: Text;
//                     TempBlob: Codeunit "Temp Blob";
//                     OutStr: OutStream;
//                     InStr: InStream;
//                     RecRef: RecordRef;
//                 begin
//                     FileName := StrSubstNo('Quote-%1.pdf', Rec."No.");
//                     // SalesHeader.SetRange("No.", Rec."No.");
//                     SalesHeader := Rec;
//                     RecRef.GetTable(SalesHeader);
//                     TempBlob.CreateOutStream(OutStr);
//                     // Report.RunModal(78002, true, true, SalesHeader);
//                     // Report.SaveAsPdf(16037489,FileName,SalesHeader);
//                     Report.SaveAs(16037489, '', ReportFormat::Pdf, OutStr, RecRef);
//                     TempBlob.CreateInStream(InStr);
//                     DownloadFromStream(InStr, 'Download Report', '', '', FileName);
//                 end;
//             }
//         }
//     }
// }
