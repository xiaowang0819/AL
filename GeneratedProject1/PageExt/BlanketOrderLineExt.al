pageextension 77501 BlanketOrderLinesExt extends "Blanket Sales Order Subform"
{
    layout
    {
        addafter("Quantity")
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how many units on the order line have not yet been shipped.';
            }
        }
    }
}

pageextension 77511 "SalesInvLineExtPage" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("OriginalType"; rec.OriginalType)
            {
                ApplicationArea = All;
                ToolTip = 'Display the original line type from the Sales order';
            }
            field("OriginalItemNum"; Rec."OriginalItemNum")
            {
                ApplicationArea = All;
                ToolTip = 'Displays the original item number from the Sales Order, even for prepayment lines.';
            }
            field("Campaign No."; Rec."Campaign No.")
            {
                ApplicationArea = All;
                ToolTip = 'Campaign associated with the posted sales invoice.';
            }
        }
    }
}

pageextension 77521 "SalesInvoiceLineExtPage" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("OriginalType"; rec.OriginalType)
            {
                ApplicationArea = All;
                ToolTip = 'Copy original line type to here, before change to prepayment GL account';
            }
            field("OriginalItemNum"; Rec."OriginalItemNum")
            {
                ApplicationArea = All;
                ToolTip = 'Copy original item nunmber to here, before change to prepayment GL account.';
            }
        }
    }
}

pageextension 77531 "ItemListAvailableQtyExt" extends "Item List"
{
    layout
    {
        addlast(Control1)
        {
            field("Available Qty (Net)"; Rec."Available Qty (Net)")
            {
                ApplicationArea = All;
                ToolTip = 'Inventory minus SO outstanding minus Blanket SO remaining.';
            }

            field("Qty on SO"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
                ToolTip = 'SO outstanding Qty.';
            }

            field("Qty on BSO"; Rec."Qty on BSO")
            {
                ApplicationArea = All;
                ToolTip = 'BSO remaining Qty (exclude related SO qty).';
            }

        }
    }
}
pageextension 77541 "Sales Lines Extension" extends "Sales Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Blanket Order';
            }
        }
    }
    
    actions
    {
        
    }
}


