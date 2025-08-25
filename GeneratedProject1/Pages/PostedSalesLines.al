page 77401 "Sales Invoice Line List"
{

    ApplicationArea = All;
    Caption = 'Sales Invoice Line List';
    PageType = List;
    SourceTable = "Sales Invoice Line";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Line"; Rec."Prepayment Line")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }

                field("Item Reference No."; Rec."Item Reference No.")
                {
                    ApplicationArea = All;
                }

                field("Amount Including VAT (ACY)"; Rec."Amount Including VAT (ACY)")
                {
                    ApplicationArea = All;
                }
                field("Amount (ACY)"; Rec."Amount (ACY)")
                {
                    ApplicationArea = All;
                }

                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                }
                field("OriginalType"; Rec.OriginalType)
                {
                    ApplicationArea = All;
                }
                field("OriginalItemNum"; Rec."OriginalItemNum")
                {
                    ApplicationArea = All;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     Campaign: Code[20];

    // trigger OnAfterGetRecord()
    // begin
    //     if SalesInvoiceHeader.Get(Rec."Document No.") then
    //         Campaign := SalesInvoiceHeader."Campaign No."
    //     else
    //         Campaign := '';
    // end;
}
