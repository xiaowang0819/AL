tableextension 50018 FS_RF_CustomerExt extends Customer
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
