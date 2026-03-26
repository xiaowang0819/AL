tableextension 50013 FS_RF_PurchInvHeader extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; FS_RF_LinkedOrder; Code[20])
        {
            Caption = 'Linked Order';
            DataClassification = CustomerContent;
        }
        field(50001; FS_RF_SourceType; Integer)
        {
            Caption = 'Source Type';
            DataClassification = CustomerContent;
        }
        field(50002; FS_RF_SourceSubtype; Option)
        {
            Caption = 'Source Subtype';
            DataClassification = CustomerContent;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10";
        }
        field(50003; FS_RF_ExternalDocumentNo; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
    }
    procedure FS_RF_LookupSourcePage()
    var
        SalesHeader: Record "Sales Header";
    begin
        case FS_RF_SourceType of Database::"Sales Header": begin
            case FS_RF_SourceSubtype of SalesHeader."Document Type"::Order.AsInteger(): begin
                if SalesHeader.Get(FS_RF_SourceSubtype, FS_RF_LinkedOrder)then begin
                    Page.Run(Page::"Sales Order", SalesHeader);
                end;
            end;
            end;
        end;
        end;
    end;
}
