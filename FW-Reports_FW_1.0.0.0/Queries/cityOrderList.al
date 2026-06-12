codeunit 78401 "WSB Header Post Handler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure SyncHeaderDateOnlyOnShipping(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
    var
        NoSeriesMgt: Codeunit "No. Series";
        Regex: Codeunit Regex; // 引入BC标准的正则表达式Codeunit
        IsMatch: Boolean;
        FastOrderErr: Label 'Please ensure: Amount<=750, has valid employee code, "Your reference" is blank.';
        ReferenceMissingErr: Label 'If it is not fast order, "Your reference" cannot be missing';
        ThisSunday: Date;
        ConsolidatedInvoiceCode: Text;
    begin
        if SalesHeader.IsTemporary then exit;

        if SalesHeader.Ship then begin
            SalesHeader."WSB Date 1" := SalesHeader."Posting Date";
        end;
        if SalesHeader.Invoice then begin
            SalesHeader.CalcFields(Amount);

            // 校验：是否以 7 位数字开头 (^ 代表开头，\d{7} 代表连续7个数字)
            IsMatch := Regex.IsMatch(SalesHeader."Ship-to Contact", '^\d{6}');

            // 原来的逻辑：如果是特定客户，开启了 Checkbox 1，但金额超了、或者有 Your Reference、或者 Contact 不是6位数字开头
            if (SalesHeader."WSB Checkbox 2" = true) and (SalesHeader."Sell-to Customer No." = 'C00001') then begin

                if (SalesHeader.Amount > 750) or (SalesHeader."Your Reference" <> '') or (not IsMatch) then
                    // 弹出错误提示并彻底阻断过账
                    Error(FastOrderErr);

                // 校验通过，生成单号
                ThisSunday := CalcDate('<CW>', Today);
                ConsolidatedInvoiceCode := 'FM-WK-' + DelChr(Format(ThisSunday, 0, 9), '=', '-');
                SalesHeader."Your Reference" := NoSeriesMgt.GetNextNo('CITYFMREF');
                SalesHeader."WSB Code 2" := CopyStr(ConsolidatedInvoiceCode, 1, MaxStrLen(SalesHeader."WSB Code 2"));
                SalesHeader.Modify(true);
            end;
            if (SalesHeader."WSB Checkbox 2" = false) and (SalesHeader."Sell-to Customer No." = 'C00001') and (SalesHeader."Your Reference" = '') then begin
                Error(ReferenceMissingErr);
            end;
        end;
    end;
}

pageextension 78017 "WSB Sales Quote Close Handler" extends "Sales Quote"
{
    layout
    {
        moveafter("Your Reference"; "WSB Checkbox 2")
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        Regex: Codeunit Regex;
        IsMatch: Boolean;
        FastOrderConfirmQst: Label 'CityFM order with employee code and below $750 is valid for fast order. Yes: Go back quote to process fast order. No: close this quote anyway.';
    begin
        // 仅针对特定客户生效
        if Rec."Sell-to Customer No." = 'C00001' then begin

            Rec.CalcFields(Amount);

            // 检查：Ship-to Contact 是否以 6 位数字开头
            IsMatch := Regex.IsMatch(Rec."Ship-to Contact", '^\d{6}');

            // 条件：前6位是数字，且金额 <= 750
            if IsMatch and (Rec.Amount <= 750) and (Rec."WSB Checkbox 2" = false) then begin
                // Confirm 如果选 Yes 返回 true，选 No 返回 false
                if Confirm(FastOrderConfirmQst, false) then
                    exit(false); // 用户选了 No，直接拦截，退回到 Quote 页面
            end;
        end;

        // 必须返回 true，否则页面会被卡住无法关闭
        exit(true);
    end;
}

query 78308 "weeklyCityAutoInvoices"
{
    QueryType = API;
    APIPublisher = 'FW';
    APIGroup = 'CityReport';
    APIVersion = 'v1.0';
    EntityName = 'CityInvoiceLine';
    EntitySetName = 'CityInvoiceLines';

    elements
    {
        dataitem(Sales_Invoice_Header; "Sales Invoice Header")
        {
            DataItemTableFilter = "Sell-to Customer No." = const('C00001');

            column(SupplierReference; "No.") { }
            column(Total_Amount; Amount) { }
            column(OrderedDateTime; "Order Date") { }
            column(DispatchedDateTime; "WSB Date 1") { }//need to be always same as posting date before shipment posted
            column(EstimatedDelivryDateTime; "Shipment Date") { }
            column(JobNumber; "External Document No.") { }
            column(SupplierPO; "WSB Code 2") { }
            column(Your_Reference; "Your Reference") { }
            //BuyIn
            //Backordered
            column(TechnicianName; "Ship-to Contact") { }
            // column(RequestedDateTime; "Requested Delivery Date") { }//not in invoice
            column(ShipVia; "Shipment Method Code") { }
            column(Posting_Date; "Posting Date") { }
            column(WSB_Code_2; "WSB Code 2") { }

            dataitem(Sales_Invoice_Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";

                DataItemTableFilter = Type = filter(Item | "G/L Account" | Resource);

                column(LineNo; "Line No.") { }
                column(PartNo; "No.") { }
                column(PartDescription; Description) { }
                column(QuantityOrdered; Quantity) { }
                column(QuantityInvoiced; Quantity) { }
                // column(Outstanding_Quantity; "Outstanding Quantity") { }
                column(UnitPrice; "Unit Price") { }
                column(Amount; Amount) { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
            }
        }
    }

    trigger OnBeforeOpen()
    var
        StartDate: Date;
    begin
        StartDate := CalcDate('<-CM>', Today);

        // 过滤过去 7 天内发货/过账的数据
        CurrQuery.SetFilter(Posting_Date, '%1..%2', StartDate, Today); //need to be updated to production.
        // CurrQuery.SetFilter("WSB_Code_2", '<>''''');
        // CurrQuery.SetFilter(Total_Amount, '<=%1', 750);

    end;
}

page 78017 "JW_BatchInvoiceAPI"
{
    PageType = API;
    APIPublisher = 'FW';
    APIGroup = 'CityReport';
    APIVersion = 'v1.0';
    EntityName = 'batchInvoice';
    EntitySetName = 'batchInvoices';
    SourceTable = "Sales Invoice Header";
    DelayedInsert = true;
    Caption = 'Batch Invoice API';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(no; Rec."No.") { }
            }
        }
    }

    // Power Automate 调用这个 Bound Action
    [ServiceEnabled]
    procedure GetPdfBase64(WsbCodeFilter: Text; PostingDateFilter: Text): Text
    var
        SIH: Record "Sales Invoice Header";
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        SIH.SetRange("Sell-to Customer No.", 'C00001');
        SIH.SetFilter(Amount, '<=750');

        // 2. 动态处理 Posting Date 过滤
        if PostingDateFilter <> '' then
            SIH.SetFilter("Posting Date", PostingDateFilter)
        else
            // 如果不传日期，默认保留你之前的“过去 6 天到今天”的兜底逻辑
            SIH.SetRange("Posting Date");

        // 3. 动态处理 WSB Code 2 过滤
        if WsbCodeFilter <> '' then
            SIH.SetFilter("WSB Code 2", WsbCodeFilter)
        else
            SIH.SetFilter("WSB Code 2", '<>''''');

        if SIH.IsEmpty then
            exit('');

        RecRef.GetTable(SIH);

        TempBlob.CreateOutStream(OutStream);
        if Report.SaveAs(Report::"JW Batch Invoice Combined", '', ReportFormat::Pdf, OutStream, RecRef) then begin
            TempBlob.CreateInStream(InStream);
            exit(Base64Convert.ToBase64(InStream));
        end;
    end;
}

// pageextension 78018 "MyPostedSalesInvoiceExt" extends "Posted Sales Invoice"
// {
//     actions
//     {
//         addlast(processing)
//         {
//             action(MyTestEmail)
//             {
//                 Caption = '测试发邮件';
//                 ApplicationArea = All;
//                 Image = Email;

//                 trigger OnAction()
//                 begin
//                     Message('这个绝对能弹出来！');
//                 end;
//             }
//         }
//     }
// }
// pageextension 78018 "WSB Posted Sales Inv Ext" extends "Posted Sales Invoice"
// {
//     // 🌟 在这里加一个页面打开的触发器
//     trigger OnOpenPage()
//     begin
//         // 🛑 请把红点（断点）打在下面这行 Message 上！
//         Message('调试器测试：进入了页面打开触发器！');
//     end;
// }

codeunit 78404 "SystemMailInterceptor"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Email", 'OnBeforeOpenEmailEditor', '', false, false)]
    local procedure OnBeforeOpenEmailEditor(var EmailMessage: Codeunit "Email Message"; IsNewEmail: Boolean)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        MailSubject: Text;
    begin
        MailSubject := EmailMessage.GetSubject();
        SalesInvoiceHeader.SetFilter("Sell-to Customer No.", 'C00001'); // 先给个大概范围提升效率，或者直接用下面的循环

        if SalesInvoiceHeader.FindSet() then begin
            repeat
                if MailSubject.Contains(SalesInvoiceHeader."No.") then begin
                    // 找到了匹配的发票，判断字段
                    if SalesInvoiceHeader."WSB Checkbox 2" = true then
                        Error('This is a Fast Order invoice. Donnot send the individual invoice. Weekly invoice will be sent on Sunday night autometically.');
                    break;
                end;
            until SalesInvoiceHeader.Next() = 0;
        end;
    end;
}