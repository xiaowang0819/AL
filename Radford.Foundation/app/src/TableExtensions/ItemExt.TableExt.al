tableextension 50017 FS_RF_ItemExt extends Item
{
    fields
    {
        field(50000; FS_RF_FreightPrice; Decimal)
        {
            Caption = 'Freight Price';
            DataClassification = CustomerContent;
        }

        field(50001; FS_RF_QtyonBlanketSO; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = sum("Sales Line".FS_RF_OutstandingQty where("Document Type" = const("Blanket Order"),
                                                                            Type = const(Item),
                                                                            "No." = field("No."),
                                                                            "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                            "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                            "Location Code" = field("Location Filter"),
                                                                            "Drop Shipment" = field("Drop Shipment Filter"),
                                                                            "Variant Code" = field("Variant Filter"),
                                                                            "Shipment Date" = field("Date Filter"),
                                                                            "Unit of Measure Code" = field("Unit of Measure Filter")));
            Caption = 'Qty. on Blanket Sales Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
    }
}