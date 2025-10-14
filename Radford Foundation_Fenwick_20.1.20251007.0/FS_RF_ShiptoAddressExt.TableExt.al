tableextension 50019 FS_RF_ShiptoAddressExt extends "Ship-to Address"
{
    fields
    {
        field(50000; FS_RF_FreightZone; Code[20])
        {
            Caption = 'Freight Zone';
            TableRelation = FS_RF_FreightZone;
            DataClassification = CustomerContent;
        }
    }
}
