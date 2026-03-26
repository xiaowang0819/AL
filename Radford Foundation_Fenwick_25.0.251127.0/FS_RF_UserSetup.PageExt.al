pageextension 50000 FS_RF_UserSetup extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field(FS_RF_ShipOnly; Rec.FS_RF_ShipOnly)
            {
                ApplicationArea = All;
            }
        }
    }
}
