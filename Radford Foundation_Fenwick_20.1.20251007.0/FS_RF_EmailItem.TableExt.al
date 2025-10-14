tableextension 50005 FS_RF_EmailItem extends "Email Item"
{
    fields
    {
    }
    procedure FS_RF_GetBodyText()Value: Text var
        BodyText: BigText;
        DataStream: InStream;
    begin
        // Note this is intended only to get the body in memory - not from the database.
        Value:='';
        if "Plaintext Formatted" then begin
            Body.CreateInStream(DataStream, TextEncoding::UTF8);
            BodyText.Read(DataStream);
            BodyText.GetSubText(Value, 1);
        end
        else
        begin
            Body.CreateInStream(DataStream, TextEncoding::UTF8);
            DataStream.Read(Value);
        end;
        exit(Value);
    end;
    procedure FS_RF_AttachIncomingDocuments(SalesInvoiceNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        IncomingDocument: Record "Incoming Document";
        IncomingDocumentAttachment: Record "Incoming Document Attachment";
        InStr: InStream;
        IsPostedDocument: Boolean;
        CorrectAttachment: Boolean;
    begin
        if SalesInvoiceNo = '' then exit;
        IsPostedDocument:=true;
        if not SalesInvoiceHeader.Get(SalesInvoiceNo)then begin
            SalesHeader.SetFilter("Document Type", '%1|%2', SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Invoice);
            SalesHeader.SetRange("No.", SalesInvoiceNo);
            if not SalesHeader.FindFirst()then exit;
            if SalesHeader."Incoming Document Entry No." = 0 then exit;
            IsPostedDocument:=false;
        end;
        if IsPostedDocument then begin
            IncomingDocumentAttachment.SetRange("Document No.", SalesInvoiceNo);
            IncomingDocumentAttachment.SetRange("Posting Date", SalesInvoiceHeader."Posting Date");
        end
        else
            IncomingDocumentAttachment.SetRange("Incoming Document Entry No.", SalesHeader."Incoming Document Entry No.");
        IncomingDocumentAttachment.SetAutoCalcFields(Content);
        if IncomingDocumentAttachment.FindSet()then repeat CorrectAttachment:=true;
                if IsPostedDocument then begin
                    CorrectAttachment:=false;
                    if IncomingDocument.Get(IncomingDocumentAttachment."Incoming Document Entry No.")then if(IncomingDocument."Document Type" = IncomingDocument."Document Type"::"Sales Invoice") and IncomingDocument.Posted then CorrectAttachment:=true;
                end;
                if CorrectAttachment then if IncomingDocumentAttachment.Content.HasValue()then begin
                        IncomingDocumentAttachment.Content.CreateInStream(InStr);
                        // To ensure that Attachment file name has . followed by extension in the email item
                        Rec.AddAttachment(InStr, StrSubstNo('%1.%2', IncomingDocumentAttachment.Name, IncomingDocumentAttachment."File Extension"));
                    end;
            until IncomingDocumentAttachment.Next() = 0;
    end;
}
