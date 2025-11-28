report 78003 "JW Batch Invoice Combined"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Batch Invoice';

    DefaultLayout = Word;
    WordLayout = './Layouts/JW_BatchInvoices.docx';

    dataset
    {
        dataitem(Company; "Company Information")
        {
            column(CompanyPic; "Picture") { }
            column(CompanyName; "Name") { }
            column(CompanyAdd; Address) { }
            column(CompanyCity; City) { }
            column(ABN; ABN) { }
            column(County; County) { }
            column(Country_Region_Code; "Country/Region Code") { }
            column(CompanyEmail; "E-mail") { }
            column(CompanyWeb; "Home Page") { }
            column(CompanyPhone; "Phone No.") { }
        }
        dataitem(SIH; "Sales Invoice Header")
        {
            RequestFilterFields = "Sell-to Customer No.", "Posting Date";

            column(InvoiceNo; "No.") { }
            column(ExternalDoc; "External Document No.") { }
            column(Reference; "Your Reference") { }
            column(Amount; Amount) { }
            column(GST; "Amount Including VAT" - Amount) { }
            column(AmountIncl; "Amount Including VAT") { }
            column(CustomerName; "Sell-to Customer Name") { }
            column(CustomerNo; "Sell-to Customer No.") { }
            column(SalesPerson; "Salesperson Code") { }
            column(PostingDate; "Posting Date") { }

            trigger OnPreDataItem()
            begin
                FilterPostingDate := GetFilter("Posting Date");
                FilterCustomerNo := GetFilter("Sell-to Customer No.");
                if (FilterPostingDate = '') or (FilterCustomerNo = '') then
                    Error('You must set filter value for both Posting Date and Sell-to Customer No.');
            end;


            trigger OnAfterGetRecord()
            begin
                TotalExGST += Amount;
                TotalIncGST += "Amount Including VAT";
            end;
        }

        dataitem(Totals; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            column(TotalExGSTCol; TotalExGST) { }
            column(TotalIncGSTCol; TotalIncGST) { }
            column(TotalGSTCol; TotalIncGST - TotalExGST) { }
            column(DateFilter; FilterPostingDate) { }
            column(CustomerFilter; FilterCustomerNo) { }

        }
    }


    var
        TotalExGST: Decimal;
        TotalIncGST: Decimal;
        SIHRec: Record "Sales Invoice Header";
        FilterPostingDate: Text;
        FilterCustomerNo: Text;

    trigger OnPreReport()
    begin
        TotalExGST := 0;
        TotalIncGST := 0;
    end;

    trigger OnPostReport()
    var
        PrintSIH: Record "Sales Invoice Header";
    begin
        PrintSIH.Reset();
        if FilterPostingDate <> '' then
            PrintSIH.SetFilter("Posting Date", FilterPostingDate);

        if FilterCustomerNo <> '' then
            PrintSIH.SetFilter("Sell-to Customer No.", FilterCustomerNo);

        if PrintSIH.FindSet() then begin
            // repeat
            Report.RunModal(16037491, true, false, PrintSIH);
            // 或 Report::"Posted Sales Invoice - Test" / 206 / 1306 看你用哪个
            // until PrintSIH.Next() = 0;
        end;
    end;

}


pageextension 78011 JW_PostedSalesInvoiceExt extends "Posted Sales Invoices"
{
    actions
    {
        addlast("&Invoice")
        {
            action(FW_BatchInvoices)
            {
                Caption = 'FW Batch Invoices';
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                var
                    SIH: Record "Sales Invoice Header";
                begin
                    Report.RunModal(Report::"JW Batch Invoice Combined", true, false, SIH);
                end;
            }
        }
    }
}
