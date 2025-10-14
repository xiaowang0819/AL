tableextension 50000 FS_RF_UserSetup extends "User Setup"
{
    fields
    {
        field(50000; FS_RF_ShipOnly; Boolean)
        {
            Caption = 'Ship Only';
            DataClassification = CustomerContent;
        }
    }
}
