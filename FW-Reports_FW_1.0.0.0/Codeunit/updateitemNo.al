// 1. 自定义映射临时表，用于接收配置包数据
table 78015 "Item No. Mapping"
{
    DataClassification = CustomerContent;
    Caption = 'Item No. Mapping';

    fields
    {
        field(1; "Original Item No."; Code[20])
        {
            Caption = 'Original Item No.';
            // TableRelation = Item;
        }
        field(2; "New Item Number"; Code[20])
        {
            Caption = 'New Item Number';
        }
        // 新增：状态字段
        field(3; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Success,Error;
            OptionCaption = 'Pending,Success,Error';
        }
        // 附赠：错误信息记录，方便你排雷
        field(4; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
    }

    keys
    {
        key(PK; "Original Item No.")
        {
            Clustered = true;
        }
    }
}

codeunit 78405 "Do Item Rename Worker"
{
    TableNo = "Item No. Mapping";

    trigger OnRun()
    var
        Item: Record Item;
    begin
        // 防呆拦截：自己改自己直接抛错，别去底层碰瓷
        if Rec."Original Item No." = Rec."New Item Number" then
            Error('Original and New Item numbers are the same.');

        if Rec."New Item Number" = '' then
            Error('New Item Number cannot be blank.');

        // 如果旧物料找不到，直接报错让外层抓取
        Item.Get(Rec."Original Item No.");
        Item.Rename(Rec."New Item Number");
    end;
}

// 2. Job Queue 调用的 Codeunit
codeunit 78402 "Batch Rename Items Job"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        UpdateItemNumbers();
    end;

    local procedure UpdateItemNumbers()
    var
        ItemMapping: Record "Item No. Mapping";
        DoRenameWorker: Codeunit "Do Item Rename Worker";
    begin
        // 只找还没处理过的
        ItemMapping.SetRange(Status, ItemMapping.Status::Pending);
        if ItemMapping.FindSet() then begin
            repeat
                // 清理上一次可能的残留报错
                ClearLastError();

                // if Codeunit.Run() 就是隔离异常的魔法
                if DoRenameWorker.Run(ItemMapping) then begin
                    // 成功
                    ItemMapping.Status := ItemMapping.Status::Success;
                    ItemMapping."Error Message" := '';
                    ItemMapping.Modify();
                end else begin
                    // 失败被拦截
                    ItemMapping.Status := ItemMapping.Status::Error;
                    ItemMapping."Error Message" := CopyStr(GetLastErrorText(), 1, 250); // 把错误信息扒下来
                    ItemMapping.Modify();
                end;

                // 强制提交事务：极其关键！
                // 保证每一条的成功或失败状态都能立刻写入数据库，不被后续可能引发的死锁拖累。
                Commit();

            until ItemMapping.Next() = 0;
        end;
    end;
}

codeunit 78403 "Item List Default Filter"
{
    // 订阅标准 Item List 页面打开时的事件
    [EventSubscriber(ObjectType::Page, Page::"Item List", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenPage_ItemListDefaultFilter(var Rec: Record Item)
    begin
        // 如果用户在打开页面时没有主动对 Blocked 字段设置其他筛选，我们就加上默认过滤
        if Rec.GetFilter(Blocked) = '' then begin
            // 过滤掉 Blocked = true，也就是只显示未被锁定的物料（Blocked = false）
            Rec.SetRange(Blocked, false);
        end;
    end;
}

permissionset 78015 "Itemmapping_Permi"
{
    Assignable = true;
    Caption = 'FW Reports Permissions';

    Permissions =
        // 赋予你自定义的新表 78015 完整的增删改查和执行权限
        tabledata "Item No. Mapping" = RIMD,
        table "Item No. Mapping" = X,

        // 赋予你的 Codeunit 执行权限
        codeunit "Batch Rename Items Job" = X,
        codeunit "Item List Default Filter" = X;
}