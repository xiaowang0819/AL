page 50607 FS_RF_FinanceMgrRCActivities
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Activities Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Service Order Status")
            {
                Caption = 'Service Order Status';
                field("SRV Order Sent"; Rec.FS_RF_SRVOrderSent)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Sent Waiting Release';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that the document has been sent to email waiting for Released orders.';
                }
                field("SRV Order Cont Invoiced"; Rec.FS_RF_SRVOrderContInvoiced)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Order Cont Invoiced';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that are linked to Purchase Invoice.';
                }
                field("SRV Order Shipped"; Rec.FS_RF_ServOrderShipped)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Order Shipped';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that has been shipped.';
                }
                field("SRV Order Ready Cust Inv"; Rec.FS_RF_SRVOrderReadyCustInv)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Order Ready Cust Inv';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that has been approved for customer invoice.';
                }
            }
            cuegroup("Sales Order Status")
            {
                field("ERP_Waiting for Released"; Rec.FS_RF_SOWaitingForReleased)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SO Waiting Release';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Waiting for Released orders';
                }
                field("ERP_Order Released"; Rec.FS_RF_SalesOrderReleased)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Released Sales Orders';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Released orders';
                }
                field("Erx Order Shipped"; Rec.FS_RF_SalesOrderShippedBasic)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order Shipped';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies sales orders that has been shipped.';
                }
                field(FS_RF_SalesOrdersReadyForInv; Rec.FS_RF_SalesOrdersReadyForInv)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
            }
            cuegroup("SRV Linked Purchase Invoices")
            {
                Caption = 'SRV Linked Purchase Invoices';
                field("SRV Linked Purch Inv"; Rec.FS_RF_SRVLinkedPurchInv)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Linked Purch Inv';
                    DrillDownPageId = "Purchase Invoices";
                    ToolTip = 'Specifies Pucrhase invoices that are linked to order.';
                }
            }
            cuegroup("Purchase Orders Pending Prepayment")
            {
                Caption = 'Purchase Orders Pending Prepayment';
                field("Pending Prepayment"; Rec.FS_RF_POPendingPrepayment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Prepayment';
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies the purchase orders that are status is pending prepayment';
                }
            }
            cuegroup("Sales Orders Pending Prepayment")
            {
                Caption = 'Sales Orders Pending Prepayment';
                field("SO Pending Prepayment"; Rec.FS_RF_SOPendingPrepayment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Prepayment';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies the purchase orders that are status is pending prepayment';
                }
            }
            cuegroup("Purchase Orders - Authorize for Payment")
            {
                Caption = 'Purchase Orders - Authorize for Payment';
                field(NotInvoiced; Rec.FS_RF_PONotInvoiced)
                {
                    ApplicationArea = Suite;
                    Caption = 'Received, Not Invoiced';
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies received orders that are not invoiced. The orders are displayed in the Purchase Cue on the Purchasing Agent role center, and filtered by today''s date.';

                    trigger OnDrillDown()
                    begin
                        Rec.FS_RF_ShowOrders(Rec.FieldNo(FS_RF_PONotInvoiced));
                    end;
                }
                field(PartiallyInvoiced; Rec.FS_RF_POPartiallyInvoiced)
                {
                    ApplicationArea = Suite;
                    Caption = 'Partially Invoiced';
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies the number of partially invoiced orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';

                    trigger OnDrillDown()
                    begin
                        Rec.FS_RF_ShowOrders(Rec.FieldNo(FS_RF_POPartiallyInvoiced));
                    end;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(RefreshData)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh Data';
                Image = Refresh;
                ToolTip = 'Refreshes the data needed to make complex calculations.';

                trigger OnAction()
                begin
                    Rec."Last Date/Time Modified" := 0DT;
                    Rec.Modify();

                    Codeunit.Run(Codeunit::"Activities Mgt.");
                    CurrPage.Update(false);
                end;
            }
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        IntegrationSynchJobErrors: Record "Integration Synch. Job Errors";
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
        ConfPersonalizationMgt: Codeunit "Conf./Personalization Mgt.";
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
        end;

        Rec.SetFilter("Due Next Week Filter", '%1..%2', CalcDate('<1D>', WorkDate()), CalcDate('<1W>', WorkDate()));

        IntegrationSynchJobErrors.SetDataIntegrationUIElementsVisible(ShowDataIntegrationCues);
        RoleCenterNotificationMgt.ShowNotifications();
        ConfPersonalizationMgt.RaiseOnOpenRoleCenterEvent();

        CalculateCueFieldValues();
    end;

    var
        CuesAndKpis: Codeunit "Cues And KPIs";
        ShowDataIntegrationCues: Boolean;
        TaskIdCalculateCue: Integer;

    procedure CalculateCueFieldValues()
    begin
        if (TaskIdCalculateCue <> 0) then
            CurrPage.CancelBackgroundTask(TaskIdCalculateCue);
        CurrPage.EnqueueBackgroundTask(TaskIdCalculateCue, Codeunit::"O365 Activities Dictionary");
    end;
}

