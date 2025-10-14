codeunit 50008 FS_RF_AttachmentMgt
{
    procedure TableIsDocument(TableID: Integer)IsDocument: Boolean begin
        IsDocument:=TableID in[Database::"Sales Header", Database::"Sales Line", Database::"Purchase Header", Database::"Purchase Line", Database::"Sales Invoice Header", Database::"Sales Cr.Memo Header", Database::"Purch. Inv. Header", Database::"Purch. Cr. Memo Hdr.", Database::"Sales Invoice Line", Database::"Sales Cr.Memo Line", Database::"Purch. Inv. Line", Database::"Purch. Cr. Memo Line"];
    end;
    procedure TableHasNumberFieldPrimayKey(TableNo: Integer; var FieldNo: Integer): Boolean var
        Result: Boolean;
    begin
        case TableNo of Database::Customer, Database::Vendor, Database::Item, Database::Employee, Database::"Fixed Asset", Database::Job, Database::Resource, Database::"VAT Report Header": begin
            FieldNo:=1;
            exit(true);
        end;
        Database::"Sales Header", Database::"Sales Line", Database::"Purchase Header", Database::"Purchase Line", Database::"Sales Invoice Header", Database::"Sales Cr.Memo Header", Database::"Purch. Inv. Header", Database::"Purch. Cr. Memo Hdr.", Database::"Sales Invoice Line", Database::"Sales Cr.Memo Line", Database::"Purch. Inv. Line", Database::"Purch. Cr. Memo Line": begin
            FieldNo:=3;
            exit(true);
        end;
        end;
        Result:=false;
        exit(Result);
    end;
    procedure TableHasDocTypePrimaryKey(TableNo: Integer; var FieldNo: Integer): Boolean var
        Result: Boolean;
    begin
        case TableNo of Database::"Sales Header", Database::"Sales Line", Database::"Purchase Header", Database::"Purchase Line": begin
            FieldNo:=1;
            exit(true);
        end;
        end;
        Result:=false;
        exit(Result);
    end;
    procedure TableHasLineNumberPrimaryKey(TableNo: Integer; var FieldNo: Integer): Boolean var
        Result: Boolean;
    begin
        case TableNo of Database::"Sales Line", Database::"Purchase Line", Database::"Sales Invoice Line", Database::"Sales Cr.Memo Line", Database::"Purch. Inv. Line", Database::"Purch. Cr. Memo Line": begin
            FieldNo:=4;
            exit(true);
        end;
        end;
        Result:=false;
        exit(Result);
    end;
    procedure TableHasVATReportConfigCodePrimaryKey(TableNo: Integer; var FieldNo: Integer): Boolean begin
        if TableNo in[Database::"VAT Report Header"]then begin
            FieldNo:=2;
            exit(true);
        end;
        exit(false);
    end;
}
