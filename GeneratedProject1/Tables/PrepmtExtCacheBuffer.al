table 77201 "Prepmt Cache Buffer"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Entry Key"; Code[60]) { Caption = 'Entry Key'; }
        field(2; "Item No."; Code[20]) { Caption = 'Item No.'; }
        field(3; Quantity; Integer) { Caption = 'Quantity'; }
        field(4; Price; Decimal) { Caption = 'Price'; }
        field(5; "OriginalType"; code[20]) { Caption = 'OriginalType'; }
    }

    keys
    {
        key(PK; "Entry Key") { Clustered = true; }
    }
}