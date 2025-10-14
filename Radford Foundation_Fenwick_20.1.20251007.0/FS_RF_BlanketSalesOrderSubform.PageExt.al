pageextension 50032 FS_RF_BlanketSalesOrderSubform extends "Blanket Sales Order Subform"
{
    layout
    {
        addafter("Shipment Date")
        {
            field(FS_RF_ExternalDocumentNo; Rec.FS_RF_ExternalDocumentNo)
            {
                ApplicationArea = All;
            }
        }
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
        Rec.CalcFields(FS_RF_TotalOrderOutstandingQuantity);
        RemainingQuantity:=Rec.Quantity - (Rec.FS_RF_TotalOrderOutstandingQuantity + Rec."Quantity Shipped");
    end;
    var RemainingQuantity: Decimal;
}
