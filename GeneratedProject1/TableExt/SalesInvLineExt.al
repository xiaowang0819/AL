

tableextension 77301 "SalesInvLineExt" extends "Sales Invoice Line"
{
    fields
    {
        field(77301; "OriginalItemNum"; Code[20])
        {
            Caption = 'Original Item Num';
            DataClassification = CustomerContent;
        }
        field(77302; "Campaign No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Campaign No." where("No." = field("Document No.")));
        }
        field(77303; "OriginalType"; Code[20])
        {
            Caption = 'OriginalType';
            DataClassification = CustomerContent;
        }
    }
}

enum 77312 "Original Type Enum"
{
    Extensible = true;
    value(1; Item) { Caption = 'Item'; }
    value(2; Resource) { Caption = 'Resource'; }
}


tableextension 77311 "Sales Line Extension" extends "Sales Line"
{
    fields
    {
        field(77312; "OriginalType"; Enum "Original Type Enum")
        {
            Caption = 'Original Type';
            DataClassification = CustomerContent;
        }

        field(77311; "OriginalItemNum"; Code[20])
        {
            Caption = 'Original Item Num';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                GLAcc: Record "G/L Account";
                ItemRec: Record Item;
                ResRec: Record Resource;
                SelectedCode: Code[20];
            begin
                case Rec."OriginalType" of
                    "Original Type Enum"::Item:
                        if Page.RunModal(Page::"Item List", ItemRec) = Action::LookupOK then
                            Rec."OriginalItemNum" := ItemRec."No.";

                    "Original Type Enum"::Resource:
                        if Page.RunModal(Page::"Resource List", ResRec) = Action::LookupOK then
                            Rec."OriginalItemNum" := ResRec."No.";
                end;
            end;
        }
        // field(77311; "OriginalItemNum"; Code[20])
        // {
        //     Caption = 'Original Item Num';
        //     DataClassification = CustomerContent;
        //     TableRelation = Item;
        // }
        // field(77312; "OriginalType"; Code[20])
        // {
        //     Caption = 'Originaltype';
        //     DataClassification = CustomerContent;
        //     TableRelation = Item;
        // }
    }
}
tableextension 77321 "Item Extension" extends Item
{
    fields
    {
        field(77321; "Available Qty (Net)"; Decimal)
        {
            Caption = 'Available Qty (Net)';
            DataClassification = CustomerContent;
        }
        field(77322; "Qty on BSO"; Decimal)
        {
            Caption = 'Qty on BSO';
            DataClassification = CustomerContent;
        }
    }
}