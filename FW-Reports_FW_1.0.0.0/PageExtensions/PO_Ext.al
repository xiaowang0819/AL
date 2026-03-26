pageextension 78013 POExt extends "Purchase Order Subform"
{
    layout
    {
        modify("Requested Receipt Date")
        {
            Caption = 'Supplier Dispatch Date';
        }
        modify("Planned Receipt Date")
        {
            ApplicationArea = All;
            Visible = false;
        }
        addafter("Requested Receipt Date")
        {
            field("For_customer"; Rec."For_customer") { ApplicationArea = All; }
            field("Courierer_promise_arrival_Date"; Rec."Courierer_promise_arrival_Date") { ApplicationArea = All; }
            field("Shipment_No."; Rec."Shipment_No.") { ApplicationArea = All; }
            field("Comment"; Rec."Comment") { ApplicationArea = All; }
        }
    }

}

tableextension 78104 POLinesTableExt extends "Purchase line"
{
    fields
    {
        field(78001; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            FieldClass = FlowField;
            Editable = false;

            CalcFormula = lookup(
                "Purchase Header"."Shipment Method Code"
                where(
                    "Document Type" = field("Document Type"),
                    "No." = field("Document No.")
                )
            );
        }
        field(78002; "For_customer"; Text[100]) { Caption = 'For Customer'; DataClassification = CustomerContent; }
        field(78003; "Courierer_promise_arrival_Date"; Date) { Caption = 'Courier Promise Arrival Date'; DataClassification = CustomerContent; }
        field(78004; "Shipment_No."; Code[20]) { Caption = 'Shipment No.'; DataClassification = CustomerContent; }
        field(78005; "Comment"; Text[250]) { Caption = 'Comment'; DataClassification = CustomerContent; }
    }
}

pageextension 78014 POLineseExt extends "Purchase Lines"
{
    layout
    {
        addafter("Expected Receipt Date")
        {
            field("Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                ApplicationArea = All;
                Caption = 'Supplier Dispatch Date';
            }
            field("Shipment Method Code"; Rec."Shipment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Shipment Method Code';
            }
            field("For_customer"; Rec."For_customer") { ApplicationArea = All; }
            field("Courierer_promise_arrival_Date"; Rec."Courierer_promise_arrival_Date") { ApplicationArea = All; }
            field("Shipment_No."; Rec."Shipment_No.") { ApplicationArea = All; }
            field("Comment"; Rec."Comment") { ApplicationArea = All; }
        }
    }
}