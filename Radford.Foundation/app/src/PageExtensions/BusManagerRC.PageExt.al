pageextension 50023 FS_RF_BusManagerRC extends "Business Manager Role Center"
{
    layout
    {
        addafter(Control16)
        {
            part(FS_RF_CustomActivities; FS_RF_CustomBusManager)
            {
                ApplicationArea = All;
                Caption = 'Custom Activities';
            }
        }
    }
}