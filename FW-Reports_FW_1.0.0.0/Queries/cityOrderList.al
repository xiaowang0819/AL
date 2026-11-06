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
            SalesHeader."WSB Date 1" := WorkDate();
            SalesHeader.Modify(true);
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
            column(PO_received_date; "WSB Date 2") { }
            // 🌟 新增自定义列 ym：利用 SQL 表达式直接将日期转为 YYYYMM 文本格式
            column(postingYear; "Posting Date")
            {
                Method = Year;
            }

            // 🌟 提取月份（变成纯数字整数）
            column(postingMonth; "Posting Date")
            {
                Method = Month;
            }

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
        StartDate := CalcDate('<-13M>', Today);

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
        SalesInvoiceHeader.SetFilter("Sell-to Customer No.", 'C00001');

        if SalesInvoiceHeader.FindSet() then begin
            repeat
                if MailSubject.Contains(SalesInvoiceHeader."No.") then begin
                    if SalesInvoiceHeader."WSB Checkbox 2" = true then
                        Error('This is a Fast Order invoice. Donnot send the individual invoice. Weekly invoice will be sent on Sunday night autometically.');
                    break;
                end;
            until SalesInvoiceHeader.Next() = 0;
        end;
    end;
}

table 78018 "CityFM_Technician_List"
{
    Caption = 'CityFM Technician List';
    DataClassification = CustomerContent;

    fields
    {
        field(1; EmpNo; Text[30])
        {
            Caption = 'Emp No';
            DataClassification = CustomerContent;
        }
        field(2; Brand; Text[50])
        {
            Caption = 'Brand';
            DataClassification = CustomerContent;
        }
        field(3; State; Text[30])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(4; EmpName; Text[100])
        {
            Caption = 'Emp Name';
            DataClassification = CustomerContent;
        }
        field(5; EmpCode; Text[50])
        {
            Caption = 'Emp Code';
            DataClassification = CustomerContent;
        }
        field(6; MobileNo; Text[30])
        {
            Caption = 'Mobile No';
            DataClassification = CustomerContent;
        }
        field(7; Email; Text[100])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; EmpNo)
        {
            Clustered = true;
        }
    }

    // 设置在 Lookup 弹出框中默认显示的字段，并允许通过名字和电话搜素
    fieldgroups
    {
        fieldgroup(DropDown; EmpName, MobileNo, EmpCode, EmpNo) { }
        fieldgroup(Brick; EmpName, MobileNo, EmpCode) { }
    }
}
page 78023 "CityFM_Technicians"
{
    ApplicationArea = All;
    Caption = 'CityFM Technicians';
    PageType = List;
    SourceTable = "CityFM_Technician_List";
    UsageCategory = Lists;
    Editable = false;
    Permissions = tabledata "CityFM_Technician_List" = r;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(EmpNo; Rec.EmpNo)
                {
                    ToolTip = 'Specifies the Employee Number.';
                }
                field(EmpName; Rec.EmpName)
                {
                    ToolTip = 'Specifies the Employee Name.';
                }
                field(MobileNo; Rec.MobileNo)
                {
                    ToolTip = 'Specifies the Mobile Number.';
                }
                field(EmpCode; Rec.EmpCode)
                {
                    ToolTip = 'Specifies the Employee Code.';
                }
                // field(Brand; Rec.Brand)
                // {
                //     ToolTip = 'Specifies the Brand.';
                // }
                // field(State; Rec.State)
                // {
                //     ToolTip = 'Specifies the State.';
                // }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the Email Address.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ImportData)
            {
                ApplicationArea = All;
                Caption = 'Import / Update Data';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Paste data from Excel to insert or update technicians.';

                trigger OnAction()
                var
                    ImportPage: Page "CityFM_Tech_Import";
                begin
                    // 1. 打开弹窗
                    ImportPage.RunModal();

                    // 2. 导入完成后刷新当前 List 页面，立刻看到最新数据
                    CurrPage.Update(false);
                end;
            }
        }
    }
}

permissionset 78016 "CityFM_Permissions"
{
    Assignable = true;
    Caption = 'CityFM Permissions';
    Permissions = tabledata "CityFM_Technician_List" = RIMD;
}

pageextension 78024 "SalesOrder_CityFM_Ext" extends "Sales Order"
{
    layout
    {
        modify("Ship-to Contact")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                TechList: Record "CityFM_Technician_List";
                TechPage: Page "CityFM_Technicians";
            begin
                TechPage.LookupMode(true);

                if TechPage.RunModal() = ACTION::LookupOK then begin
                    TechPage.GetRecord(TechList);
                    Rec.Validate("Ship-to Contact", TechList.EmpCode);
                    Rec.Validate(FSG_GLD_ShipToEmail, TechList.Email);
                    rec.Validate("Ship-to Phone No.", TechList.MobileNo);
                    rec.Validate(FSG_GLD_DeliveryInstructions, 'Attn City FM ' + TechList.EmpName);
                end;
            end;
        }
    }
}

pageextension 78027 "SalesQuote_CityFM_Ext" extends "Sales Quote"
{
    layout
    {
        modify("Ship-to Contact")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                TechList: Record "CityFM_Technician_List";
                TechPage: Page "CityFM_Technicians";
            begin
                TechPage.LookupMode(true);

                if TechPage.RunModal() = ACTION::LookupOK then begin
                    TechPage.GetRecord(TechList);
                    Rec.Validate("Ship-to Contact", TechList.EmpCode);
                    Rec.Validate(FSG_GLD_ShipToEmail, TechList.Email);
                    rec.Validate("Ship-to Phone No.", TechList.MobileNo);
                    rec.Validate(FSG_GLD_DeliveryInstructions, 'Attn City FM ' + TechList.EmpName);
                end;
            end;
        }
    }
}


pageextension 78025 "ShipToAddress_CityFM_Ext" extends "Ship-to Address"
{
    layout
    {
        modify(Contact)
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                TechList: Record "CityFM_Technician_List";
                TechPage: Page "CityFM_Technicians";
            begin
                TechPage.LookupMode(true);

                if TechPage.RunModal() = ACTION::LookupOK then begin
                    TechPage.GetRecord(TechList);
                    Rec.Validate(Contact, TechList.EmpCode);
                    Rec.Validate("E-Mail", TechList.Email);
                    Rec.Validate("Phone No.", TechList.MobileNo);
                    rec.Validate(FSG_GLD_DeliveryInstructions, 'Attn City FM ' + TechList.EmpName);
                end;
            end;
        }
    }
}

page 78026 "CityFM_Tech_Import"
{
    PageType = StandardDialog;
    Caption = 'Import / Update Technicians';
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Instructions)
            {
                Caption = 'Instructions';
                field(Info; 'Copy from Excel (columns: Tech_No, Name, Phone, Email)')
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }

                field(Info2; 'Donnot inclue header, copy data only')
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(DataGroup)
            {
                Caption = 'Paste Excel Data Here';
                field(RawData; RawText)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Paste your 4-column technician Excel lines here. by sequence "Technician Numer","Name","Phone number","Email". Donnot copy header';
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::OK then begin
            if RawText <> '' then
                ProcessImport(RawText);
        end;
    end;

    var
        RawText: Text;

    procedure ProcessImport(InputText: Text)
    var
        Lines: List of [Text];
        Fields: List of [Text];
        LineText: Text;
        TechRec: Record "CityFM_Technician_List";
        EmpNoVal: Text[30];
        InsertedCount: Integer;
        UpdatedCount: Integer;
        TabChar: Text[1];
    begin
        TabChar[1] := 9; // \t (Tab)

        // 1. 兼容性更强的方式拆分换行符：统一将 \r\n 或 \r 替换为 \n 再 Split
        InputText := InputText.Replace(Format(Char(13)) + Format(Char(10)), Format(Char(10)));
        InputText := InputText.Replace(Format(Char(13)), Format(Char(10)));
        Lines := InputText.Split(Format(Char(10)));

        foreach LineText in Lines do begin
            // 过滤空行
            if LineText.Trim() <> '' then begin
                // 2. 按 Tab 拆分列
                Fields := LineText.Split(TabChar);

                if Fields.Count >= 1 then begin
                    EmpNoVal := CopyStr(Fields.Get(1).Trim(), 1, MaxStrLen(TechRec.EmpNo));

                    if EmpNoVal <> '' then begin
                        if TechRec.Get(EmpNoVal) then begin
                            // 已存在 -> 执行 Update
                            PopulateFields(TechRec, Fields);
                            TechRec.Modify(true);
                            UpdatedCount += 1;
                        end else begin
                            // 不存在 -> 执行 Insert
                            TechRec.Init();
                            TechRec.EmpNo := EmpNoVal;
                            PopulateFields(TechRec, Fields);
                            TechRec.Insert(true);
                            InsertedCount += 1;
                        end;
                    end;
                end;
            end;
        end;

        Message('Insert %1 new records，update %2 existing records.', InsertedCount, UpdatedCount);
    end;

    local procedure PopulateFields(var Rec: Record "CityFM_Technician_List"; Fields: List of [Text])
    var
        EmpNameVal: Text[100];
    begin
        // 第 2 列：EmpName
        if Fields.Count >= 2 then begin
            EmpNameVal := Fields.Get(2).Trim();
            Rec.EmpName := CopyStr(EmpNameVal, 1, MaxStrLen(Rec.EmpName));
        end;

        // 自动拼接 EmpCode = EmpNo + "," + EmpName
        Rec.EmpCode := CopyStr(Rec.EmpNo + ',' + Rec.EmpName, 1, MaxStrLen(Rec.EmpCode));

        // 第 3 列：MobileNo
        if Fields.Count >= 3 then
            Rec.MobileNo := CopyStr(Fields.Get(3).Trim(), 1, MaxStrLen(Rec.MobileNo));

        // 第 4 列：Email
        if Fields.Count >= 4 then
            Rec.Email := CopyStr(Fields.Get(4).Trim(), 1, MaxStrLen(Rec.Email));
    end;

    local procedure Char(Code: Integer): Char
    var
        c: Char;
    begin
        c := Code;
        exit(c);
    end;
}