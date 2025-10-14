pageextension 50026 FS_RF_ShiptoAddressExt extends "Ship-to Address"
{
    layout
    {
        addafter("Service Zone Code")
        {
            field(FS_RF_FreightZone; Rec.FS_RF_FreightZone)
            {
                ApplicationArea = All;
            }
        }
    }
}
