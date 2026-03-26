tableextension 50010 FS_RF_PrepmtInvLineBufferExt extends "Prepayment Inv. Line Buffer"
{
    fields
    {
        field(50000; FS_RF_OrderNo; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
        }
        field(50001; FS_RF_OrderLineNo; Integer)
        {
            Caption = 'Order Line No.';
            DataClassification = CustomerContent;
        }
    }
}
