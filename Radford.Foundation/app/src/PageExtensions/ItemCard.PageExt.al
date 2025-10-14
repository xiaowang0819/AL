pageextension 50028 FS_RF_ItemCard extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field(FS_RF_FreightPrice; Rec.FS_RF_FreightPrice)
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. on Sales Order")
        {
            field(FS_RF_QtyonBlanketSO; Rec.FS_RF_QtyonBlanketSO)
            {
                ApplicationArea = All;
                ToolTip = 'Qty remaining not yet shipped or on a Sales Order';
            }
        }
    }
}