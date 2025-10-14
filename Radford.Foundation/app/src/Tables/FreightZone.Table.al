table 50001 FS_RF_FreightZone
{
    DataClassification = ToBeClassified;
    Caption = 'Freight Zone';
    LookupPageId = FS_RF_FreightZones;
    DrillDownPageId = FS_RF_FreightZones;
    fields
    {
        field(1; FS_RF_Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; FS_RF_Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; FS_RF_LoadingFactor; Decimal)
        {
            Caption = 'Loading Factor';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; FS_RF_Code)
        {
            Clustered = true;
        }
    }
}