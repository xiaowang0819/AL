page 50000 FS_RF_SalesOrderTemplateList
{
    Caption = 'Sales Order Templates';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FS_RF_SalesOrderTemplate;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(FS_RF_Code; Rec.FS_RF_Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code of the template.';
                }
                field(FS_RF_Description; Rec.FS_RF_Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the description of the template.';
                }
                field(FS_RF_NoSeries; Rec.FS_RF_NoSeries)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
