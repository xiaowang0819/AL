pageextension 50012 FS_RF_CustomerCardExt extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(FS_RF_OurAccountNo; Rec."Our Account No.")
            {
                ApplicationArea = All;
            }
            field(FS_RF_FreightZone; Rec.FS_RF_FreightZone)
            {
                ApplicationArea = All;
            }
        }
    }
}