page 50001 FS_RF_SalesActivities
{
    //Copied from "O365 Activities"
    Caption = 'Sales Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Activities Cue";

    layout
    {
        area(Content)
        {
            cuegroup(Control54)
            {
                CuegroupLayout = Wide;
                ShowCaption = false;
                field("Sales This Month"; Rec."Sales This Month")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Sales Invoice List";
                    ToolTip = 'Specifies the sum of sales in the current month excluding taxes.';

                    trigger OnDrillDown()
                    begin
                        ActivitiesMgt.DrillDownSalesThisMonth();
                    end;
                }
                field("Overdue Sales Invoice Amount"; Rec."Overdue Sales Invoice Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of overdue payments from customers.';

                    trigger OnDrillDown()
                    begin
                        ActivitiesMgt.DrillDownCalcOverdueSalesInvoiceAmount();
                    end;
                }
                field("Overdue Purch. Invoice Amount"; Rec."Overdue Purch. Invoice Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of your overdue payments to vendors.';

                    trigger OnDrillDown()
                    begin
                        ActivitiesMgt.DrillDownOverduePurchaseInvoiceAmount();
                    end;
                }
            }
        }
    }

    var
        ActivitiesMgt: Codeunit "Activities Mgt.";
}