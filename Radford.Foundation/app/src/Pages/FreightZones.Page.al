page 50009 FS_RF_FreightZones
{
    PageType = List;
    SourceTable = FS_RF_FreightZone;
    Caption = 'Freight Zones';
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(FS_RF_FreightZones)
            {
                field(FS_RF_Code; Rec.FS_RF_Code)
                {
                    ApplicationArea = All;
                }
                field(FS_RF_Description; Rec.FS_RF_Description)
                {
                    ApplicationArea = All;
                }
                field(FS_RF_LoadingFactor; Rec.FS_RF_LoadingFactor)
                {
                    ApplicationArea = All;

                }
            }
        }

    }
}