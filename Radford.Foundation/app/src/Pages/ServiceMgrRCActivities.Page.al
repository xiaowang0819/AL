page 50604 FS_RF_ServiceMgrRCActivities
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
                field("SRV Order Initialized"; Rec.FS_RF_SRVOrderInitialized)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Order Initialized';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that the document has not been sent to email.';
                    Visible = true;
                }
                field("SRV Order Sent"; Rec.FS_RF_SRVOrderSent)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Sent Waiting Release';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that the document has been sent to email waiting for Released orders.';
                }
                field("SRV Order Released"; Rec.FS_RF_SRVOrderReleased)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Order Released';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that are status is released.';
                }
                field("SRV Order Shipped"; Rec.FS_RF_ServOrderShipped)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Order Shipped';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that has been shipped.';
                }

                field("SRV Order Cont Invoiced"; Rec.FS_RF_SRVOrderContInvoiced)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Order Cont Invoiced';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that are linked to Purchase Invoice.';
                }
                field("SRV Order Ready Cust Inv"; Rec.FS_RF_SRVOrderReadyCustInv)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Order Ready Cust Inv';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that has been approved for customer invoice.';
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
                    Visible = true;
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

