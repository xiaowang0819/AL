pageextension 78000 PageExtension50001 extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Outstanding Quantity95000"; Rec."Outstanding Quantity")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("No.")
        {
            field("Vendor Item No."; Rec."Vendor Item No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
