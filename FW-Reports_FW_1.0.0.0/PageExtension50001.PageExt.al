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
    }
}
