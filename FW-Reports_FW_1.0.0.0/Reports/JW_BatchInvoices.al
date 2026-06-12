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
            RequestFilterFields = "Sell-to Customer No.", "Posting Date", Amount, "WSB Code 2";

            column(InvoiceNo; "No.") { }
            column(ExternalDoc; "External Document No.") { }
            column(Reference; "Your Reference") { }
            column(CityReference; "WSB Code 2") { }
            column(Amount; Amount) { }
            column(GST; "Amount Including VAT" - Amount) { }
            column(AmountIncl; "Amount Including VAT") { }
            column(CustomerName; "Sell-to Customer Name") { }
            column(CustomerNo; "Sell-to Customer No.") { }
            column(SalesPerson; "Salesperson Code") { }
            column(PostingDate; "Posting Date") { }
            column(Order_Date; "Order Date") { }
            column(supplierPO; "WSB Code 2") { }
            column(EmployeeNO; "Ship-to Contact") { }

            dataitem(SIL; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(LineNo; "Line No.") { }
                column(ItemNo; "No.") { }
                column(SupplierPONo; SIH."WSB Code 2") { }
                column(Posting_Date; "Posting Date") { }
                column(EmployeeNum; SIH."Ship-to Contact") { }
                column(ReferenceNum; SIH."Your Reference") { }
                column(Job_No_; "Job No.") { }
                column(Jobnum2; SIH."External Document No.") { }
                column(Document_No_; "Document No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(UnitPrice; "Unit Price") { }
                column(LineAmount; Amount) { }
                column(LineAmountInclVAT; "Amount Including VAT") { }
            }

            trigger OnPreDataItem()
            begin
                FilterPostingDate := Format(Today);
                TaxRefNo := Format(Today, 0, '<Year4><Month,2><Day,2>');
                FilterCustomerNo := GetFilter("Sell-to Customer No.");


            end;


            trigger OnAfterGetRecord()
            begin
                TotalExGST += Amount;
                TotalIncGST += "Amount Including VAT";
                if InvoiceNoFilter = '' then
                    InvoiceNoFilter := "No."
                else
                    InvoiceNoFilter += '|' + "No.";
            end;


        }

        dataitem(Totals; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            column(TotalExGSTCol; TotalExGST) { }
            column(TotalIncGSTCol; TotalIncGST) { }
            column(TotalGSTCol; TotalIncGST - TotalExGST) { }
            column(DateFilter; FilterPostingDate) { }
            column(TaxRef; TaxRefNo) { }
            column(CustomerFilter; FilterCustomerNo) { }

        }
    }
    requestpage
    {
        trigger OnOpenPage()
        begin
            // 默认日期：最近7天 (Today 往前推6天，加上今天正好7天)
            if SIH.GetFilter("Posting Date") = '' then
                SIH.SetRange("Posting Date", CalcDate('<-6D>', Today), Today);

            // 默认客户
            if SIH.GetFilter("Sell-to Customer No.") = '' then
                SIH.SetFilter("Sell-to Customer No.", 'C00001');

            // 默认金额
            if SIH.GetFilter(Amount) = '' then
                SIH.SetFilter(Amount, '<=750');
            if SIH.GetFilter("WSB Code 2") = '' then
                SIH.SetFilter("WSB Code 2", '<>""');
        end;
    }


    var
        TotalExGST: Decimal;
        TotalIncGST: Decimal;
        SIHRec: Record "Sales Invoice Header";
        FilterPostingDate: Text;
        FilterCustomerNo: Text;
        InvoiceNoFilter: Text;
        TaxRefNo: Text;

    trigger OnPreReport()
    begin
        TotalExGST := 0;
        TotalIncGST := 0;
        InvoiceNoFilter := '';
    end;

    trigger OnPostReport()

    var
        Printer: Codeunit "JW_BatchPrinter";
    begin
        if InvoiceNoFilter <> '' then
            Printer.PrintDocs(InvoiceNoFilter);
    end;

}


pageextension 78011 JW_PostedSalesInvoiceExt extends "Posted Sales Invoices"
{
    layout
    {
        moveafter("Due Date"; "Shipment Date")
        moveafter("Due Date"; "WSB Date 3")
        moveafter(FS_RF_OrderDate; "WSB Date 2")



    }
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
                // var
                //     SIH: Record "Sales Invoice Header";
                begin
                    Report.RunModal(Report::"JW Batch Invoice Combined", true, false);
                end;
            }
        }
    }
}


codeunit 78000 JW_BatchPrinter
{
    procedure PrintDocs(InvoiceNos: Text)
    var
        SIH: Record "Sales Invoice Header";
    begin
        if InvoiceNos = '' then
            exit;

        // 直接用收集到的 Invoice Numbers 进行过滤
        SIH.SetFilter("No.", InvoiceNos);
        if SIH.FindSet() then
            // 第二个参数 ReqWindow = false，直接静默跳过请求页面
            Report.RunModal(16037491, true, false, SIH);
    end;
}
