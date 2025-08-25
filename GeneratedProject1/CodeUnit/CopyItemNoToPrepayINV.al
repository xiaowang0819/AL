
codeunit 77101 "CopyOriginalItemNumHandler"
{
    Permissions = tabledata "Sales Invoice Line" = RMID;

    [EventSubscriber(ObjectType::Codeunit,
                     Codeunit::"Sales-Post",
                     'OnAfterSalesInvLineInsert',
                     '', false, false)]
    local procedure SetOriginalItemNum(
        var SalesInvLine: Record "Sales Invoice Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line")
    begin
        if SalesInvLine."No." <> '4345' then
            exit;
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice then
            exit;

        if IsNullOrEmpty(SalesLine."OriginalItemNum") or IsNullOrEmpty(SalesLine."OriginalItemNum") then
            Error('Stop posting, G/L account 4345 must have Original Item No. and Original line type');
        SalesInvLine."OriginalItemNum" := SalesLine."OriginalItemNum";
        SalesInvLine.OriginalType := Format(SalesLine.OriginalType);
        SalesInvLine.Modify();
    end;

    local procedure IsNullOrEmpty(Value: Text[50]): Boolean
    begin
        exit(DelChr(Value, '') = '');
    end;
}


codeunit 77102 "CopyItemNumToPrepmt"
{
    SingleInstance = true;
    Permissions =
        TableData "Sales Line" = rimd,
        TableData "Sales Invoice Line" = rimd;

    var
        PrepmtCache: Record "Prepmt Cache Buffer";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterFillInvLineBuffer', '', false, false)]
    local procedure OnAfterFillInvLineBuffer(
        var PrepmtInvLineBuf: Record "Prepayment Inv. Line Buffer";
        SalesLine: Record "Sales Line";
        CommitIsSuppressed: Boolean;
        SalesHeader: Record "Sales Header")
    var
        mykey: Text;
    begin
        // mykey := StrSubstNo('%1|%2', SalesLine."Description", Format(SalesLine."Unit Cost (LCY)"));
        mykey := SalesLine.Description;
        if not PrepmtCache.Get(mykey) then begin
            PrepmtCache.Init();
            PrepmtCache."Entry Key" := mykey;
            PrepmtCache."Item No." := SalesLine."No.";
            PrepmtCache.Price := SalesLine."Unit Price";
            PrepmtCache."Quantity" := SalesLine.Quantity;
            PrepmtCache.OriginalType := format(SalesLine.Type);
            PrepmtCache.Insert();
        end;
        Message('✅ Cache LineNo: %1, ItemNo: %2, Quantity: %3', mykey, PrepmtCache."Item No.", PrepmtCache.Quantity);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterPostPrepayments', '', false, false)]
    local procedure OnAfterPostPrepayments(
        var SalesHeader: Record "Sales Header";
        DocumentType: Option Invoice,"Credit Memo";
        CommitIsSuppressed: Boolean;
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        SalesInvLine: Record "Sales Invoice Line";
        OriginalItemNum: Code[20];
        mykey: Text;
    begin
        SalesInvLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        if SalesInvLine.FindSet() then
            repeat
                // mykey := StrSubstNo('%1|%2', SalesInvLine."Description", Format(SalesInvLine."Unit Cost (LCY)"));
                mykey := SalesInvLine.Description;
                if PrepmtCache.Get(mykey) then begin
                    SalesInvLine.OriginalType := PrepmtCache.OriginalType;
                    SalesInvLine.OriginalItemNum := PrepmtCache."Item No.";
                    SalesInvLine."Unit Price" := PrepmtCache.Price;
                    if not (PrepmtCache.Price = 0) then
                        SalesInvLine.Quantity := Round(SalesInvLine.Amount / PrepmtCache.Price, 1, '=');
                    SalesInvLine.Modify();
                end;
                Message('✅ Added LineNo: %1, ItemNo: %2, Quantity: %3', mykey, SalesInvLine."OriginalItemNum", SalesInvLine.Quantity);
            until SalesInvLine.Next() = 0;
        PrepmtCache.DeleteAll();

    end;
}




