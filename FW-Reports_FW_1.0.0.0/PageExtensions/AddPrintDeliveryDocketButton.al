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

tableextension 78002 "Sales line table Ext" extends "Sales Line"
{

    fields
    {
        field(78002; "Status"; Enum "Sales Document Status")
        {
            Caption = 'Status';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header".Status
                                 where("No." = field("Document No.")));
        }
        field(78003; "SO level ExtDocNo."; text[50])
        {
            Caption = 'SO Level ExtDocNo.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."External Document No."
                                 where("No." = field("Document No.")));
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
            field("Doc_Line_No"; Rec."Line No.")
            {
                ApplicationArea = All;
                Caption = 'Line No.';
                ToolTip = 'Line No.';
            }
            field("BSO No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                Caption = 'BSO No.';
                ToolTip = 'Link to BSO No.';
            }
            field("BSO Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = All;
                Caption = 'BSO Line No.';
                ToolTip = 'BSO Line No.';
            }
            field("SO Level ExtDocNo"; Rec."SO level ExtDocNo.")
            {
                ApplicationArea = All;
                Caption = 'SO Level ExtDocNo';
                ToolTip = 'SO Level ExtDocNo';

            }
            field("Prepmt. Amount Inv. (LCY)"; Rec."Prepmt. Amount Inv. (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Prepaid Amount';
                ToolTip = 'Prepayment billed amount';
            }
            field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
            {
                ApplicationArea = All;
                Caption = 'Prepayment Deducted';
                ToolTip = 'Prepayment Deducted';
            }
            field("Line level ExtDocNo"; Rec.FS_RF_ExternalDocumentNo)
            {
                ApplicationArea = All;
                Caption = 'Line level ExtDocNo';
                ToolTip = 'Line level ExtDocNo';

            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                Caption = 'Order Status';
                ToolTip = 'Order Status';

            }
            field("Prepayment %"; Rec."Prepayment %")
            {
                ApplicationArea = All;
                Caption = 'Prepayment %';
                ToolTip = 'Prepayment %';
            }
        }
    }

    actions
    {

    }


    // var
    //     HiddenExtDocNo: Code[50];

    // trigger OnAfterGetRecord()
    // var
    //     RecRef: RecordRef;
    //     FldRef: FieldRef;
    // begin
    //     HiddenExtDocNo := '';
    //     RecRef.GetTable(Rec);
    //     FldRef := RecRef.Field(50005);
    //     HiddenExtDocNo := FldRef.Value();
    // end;


}

tableextension 78201 PostedSalesInvoiceLineExt extends "Sales Invoice Line"
{
    fields
    {
        field(78201; "Your Reference"; Text[50])
        {
            Caption = 'Your Reference';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Your Reference"
                                 where("No." = field("Document No.")));
        }
        field(78202; "SO Ext Doc No."; Text[50])
        {
            Caption = 'SO Level Ext Doc No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."External Document No."
                                 where("No." = field("Document No.")));
        }
        field(78203; "Ship to Code"; Text[50])
        {
            Caption = 'Ship to Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Ship-to Code"
                                 where("No." = field("Document No.")));
        }
        field(78204; "BSOExtDoc"; text[50])
        {
            Caption = 'BSO Ext Doc';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Line".FS_RF_ExternalDocumentNo
            where("Document Type" = const("Blanket Order"),
                    "Document No." = field("Blanket Order No."),
                    "Line No." = field("Blanket Order Line No.")));
        }
        field(78205; "Cost Amount"; Decimal)
        {
            Caption = 'Cost Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)"
                            where("Document Type" = const("Sales Invoice"),
                                    "Document No." = field("Document No."),
                                    "Document Line No." = field("Line No.")));
        }
    }
}


pageextension 78003 "Posted Sales Invoice Lines" extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter("Quantity")
        {
            field("BSO No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                Caption = 'BSO No.';
                ToolTip = 'Link to BSO No.';
            }
            field("BSO Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = All;
                Caption = 'BSO Line No.';
                ToolTip = 'BSO Line No.';
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Your Reference';
                ToolTip = 'Your Reference';
            }
            field("So Level Ext Doc No."; Rec."SO Ext Doc No.")
            {
                ApplicationArea = All;
                Caption = 'SO Level Ext Doc No';
                ToolTip = 'SO Level Ext Doc No';
            }
            field("Line Level Ext Doc No."; Rec.FS_RF_ExternalDocumentNo)
            {
                ApplicationArea = All;
                Caption = 'Line Level Ext Doc No';
                ToolTip = 'Line Level Ext Doc No';
            }
            field("Ship to Code"; Rec."Ship to Code")
            {
                ApplicationArea = All;
                Caption = 'Ship to code';
                ToolTip = 'Ship to code';
            }
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = All;
                Caption = 'Shipment Date';
                ToolTip = 'Shipment Date';
            }
            field("WBS No."; CustomText2)
            {
                ApplicationArea = All;
                Caption = 'WBS No.';
                ToolTip = 'WBS No.';
            }

        }
    }

    actions
    {

    }

    var
        // HiddenExtDocNo: Code[50];
        CustomText2: Text[250];

    trigger OnAfterGetRecord()
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        FldRef2: FieldRef;
    begin
        // HiddenExtDocNo := '';
        CustomText2 := '';
        RecRef.GetTable(Rec);
        // FldRef := RecRef.Field(50005);
        // HiddenExtDocNo := FldRef.Value();
        FldRef2 := RecRef.Field(70256962);
        CustomText2 := FldRef2.Value();
    end;

}

pageextension 78004 "Posted Sales Shipment Lines" extends "Posted Sales Shipment Lines"
{
    layout
    {
        addafter("Quantity")
        {
            field("BSO No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                Caption = 'BSO No.';
                ToolTip = 'Link to BSO No.';
            }
        }
    }

    actions
    {

    }

}

tableextension 78202 PostedSalesCRLineExt extends "Sales Cr.Memo Line"
{
    fields
    {
        field(78201; "Your Reference"; Text[50])
        {
            Caption = 'Your Reference';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Your Reference"
                                 where("No." = field("Document No.")));
        }
        field(78202; "SO Ext Doc No."; Text[50])
        {
            Caption = 'SO Level Ext Doc No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."External Document No."
                                 where("No." = field("Document No.")));
        }
        field(78203; "Ship to Code"; Text[50])
        {
            Caption = 'Ship to Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Ship-to Code"
                                 where("No." = field("Document No.")));
        }

        field(78204; "BSOExtDoc"; text[50])
        {
            Caption = 'BSO Ext Doc';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Line".FS_RF_ExternalDocumentNo
            where("Document Type" = const("Blanket Order"),
                    "Document No." = field("Blanket Order No."),
                    "Line No." = field("Blanket Order Line No.")));
        }

        field(78205; "Cost Amount"; Decimal)
        {
            Caption = 'Cost Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Value Entry"."Cost Amount (Actual)"
                            where("Document Type" = const("Sales Credit Memo"),
                                    "Document No." = field("Document No."),
                                    "Document Line No." = field("Line No.")));
        }
    }
}


pageextension 78006 "Posted Sales CR Lines" extends "Posted Sales Credit Memo Lines"
{
    layout
    {
        addafter("Quantity")
        {
            field("BSO No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                Caption = 'BSO No.';
                ToolTip = 'Link to BSO No.';
            }
            field("BSO Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = All;
                Caption = 'BSO Line No.';
                ToolTip = 'BSO Line No.';
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Your Reference';
                ToolTip = 'Your Reference';
            }
            field("So Level Ext Doc No."; Rec."SO Ext Doc No.")
            {
                ApplicationArea = All;
                Caption = 'SO Level Ext Doc No';
                ToolTip = 'SO Level Ext Doc No';
            }
            field("Line Level Ext Doc No."; HiddenExtDocNo)
            {
                ApplicationArea = All;
                Caption = 'Line Level Ext Doc No';
                ToolTip = 'Line Level Ext Doc No';
            }
            field("Ship to Code"; Rec."Ship to Code")
            {
                ApplicationArea = All;
                Caption = 'Ship to code';
                ToolTip = 'Ship to code';
            }
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = All;
                Caption = 'Shipment Date';
                ToolTip = 'Shipment Date';
            }
            field("Line Level ExtDocNo."; Rec.FS_RF_ExternalDocumentNo)
            {
                ApplicationArea = All;
                Caption = 'Line Level ExtDocNo.';
                ToolTip = 'Line Level ExtDocNo.';

            }

        }
    }

    actions
    {

    }

    var
        HiddenExtDocNo: Code[50];
        CustomText2: Text[250];

    trigger OnAfterGetRecord()
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        HiddenExtDocNo := '';
        CustomText2 := '';
        RecRef.GetTable(Rec);
        FldRef := RecRef.Field(50005);
        HiddenExtDocNo := FldRef.Value();
        FldRef := RecRef.Field(70256962);
        CustomText2 := FldRef.Value();
    end;

}
