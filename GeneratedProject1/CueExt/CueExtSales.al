tableextension 77701 ExtendSalesCueTable extends "Sales Cue"
{
    fields
    {
        field(77701; testCue; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header"
                WHERE("Document Type" = FILTER(Order),
                      Status = FILTER(Released),
                      "Completely Shipped" = FILTER(false)));
        }
    }
}

pageextension 77402 ExtendSOProcessorActivities extends "SO Processor Activities"
{
    layout
    {
        addlast(content)
        {
            cuegroup("TestCueGroup")
            {

                field(testCue;
                Rec.testCue)
                {
                    ApplicationArea = All;
                    Caption = 'Test Cue Caption';
                    ToolTip = 'Number of released sales orders that are not yet shipped.';
                    DrillDownPageId = "Sales Order List";
                    // StyleExpr = ;
                }

            }
        }
    }
}