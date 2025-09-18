pageextension 78001 SalesOrderExt extends "Sales Order"
{
    actions
    {
        addlast("&Print")
        {
            action(PrintMyReport)
            {
                ApplicationArea = All;
                Caption = 'Print JW-DeliveryDocket';
                Image = Print;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(78002, true, true, SalesHeader);
                end;
            }
        }
    }
}


pageextension 78002 "Sales Lines Extension" extends "Sales Lines"
{
    layout
    {
        addafter("Outstanding Quantity")
        {
            field("Qty Invoiced"; Rec."Qty. Invoiced (Base)")
            {
                ApplicationArea = All;
                Caption = 'Qty Invoiced';
                ToolTip = 'Quantity invoiced for this sales line.';
            }
            field("BSO No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                Caption = 'BSO No.';
                ToolTip = 'Link to BSO No.';
            }
            field("Doc Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Caption = 'Doc Line No.';
                ToolTip = 'Line No.';
            }
            field(ExtNo; HiddenExtDocNo)
            {
                ApplicationArea = All;
                Caption = 'External Document No. in line';
                ToolTip = 'External Document No. in line';

            }
        }
    }

    actions
    {

    }


    var
        HiddenExtDocNo: Code[50];

    trigger OnAfterGetRecord()
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        HiddenExtDocNo := '';
        RecRef.GetTable(Rec);
        FldRef := RecRef.Field(50005);
        HiddenExtDocNo := FldRef.Value();
    end;


}
