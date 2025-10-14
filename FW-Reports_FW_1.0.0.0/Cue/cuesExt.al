tableextension 78400 "Activities Cue Extension" extends "Activities Cue"
{
    fields
    {
        field(78401; "Non-SRV Released SO"; Integer)
        {
            Caption = 'Non-SRV Released SO';
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header"
                WHERE(
                    "Document Type" = CONST(Order),
                    "Completely Shipped" = CONST(false),
                    "FS_RF_ReadyForShipping" = CONST(true),
                    "No." = FILTER('<>SERV*')
                )
            );
        }
    }
}


pageextension 78401 "Add Non-SRV SO Tile" extends FS_RF_WarehouseRCActivities
{
    layout
    {
        addafter(FS_RF_SOWaitingRelease)
        {
            field("Non-SRV Released SO"; Rec."Non-SRV Released SO")
            {
                ApplicationArea = All;
                Caption = 'Non-SRV Released SO';
                DrillDownPageId = "Sales Order List";
                ToolTip = 'Sales orders ready to ship, not shipped, and not starting with SERV.';
            }
        }

        modify(FS_RF_SOReleasedOrders)
        {
            Visible = false;
        }
    }
}