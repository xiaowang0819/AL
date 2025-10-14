pageextension 50046 FS_RF_SalesLines extends "Sales Lines"
{
    layout
    {
        addafter(Quantity)
        {
            field(FS_RF_RemainingQuantity; RemainingQuantity)
            {
                ApplicationArea = All;
                Caption = 'Qty Remaining on Blanket Sales Order';
                ToolTip = 'Qty remaining not yet shipped or on a Sales Order';
                BlankZero = true;
                DecimalPlaces = 0: 5;
                Editable = false;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then begin
            Rec.CalcFields(FS_RF_TotalOrderOutstandingQuantity);
            RemainingQuantity:=Rec.Quantity - (Rec.FS_RF_TotalOrderOutstandingQuantity + Rec."Quantity Shipped");
        end;
    end;
    var RemainingQuantity: Decimal;
}
