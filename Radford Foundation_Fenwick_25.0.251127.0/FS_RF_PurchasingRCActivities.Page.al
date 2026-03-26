page 50606 FS_RF_PurchasingRCActivities
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
            cuegroup("Purchase Order")
            {
                Caption = 'Purchase Order';

                field("To Send or Confirm"; Rec.FS_RF_POWaitingRelease)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'To Send or Confirm';
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies the number of documents to send or confirm that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Upcoming Orders"; Rec.FS_RF_POUpcomingOrders)
                {
                    ApplicationArea = Suite;
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies the number of upcoming orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';
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
                    Rec."Last Date/Time Modified":=0DT;
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
        if not Rec.Get()then begin
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
    var CuesAndKpis: Codeunit "Cues And KPIs";
    ShowDataIntegrationCues: Boolean;
    TaskIdCalculateCue: Integer;
    procedure CalculateCueFieldValues()
    begin
        if(TaskIdCalculateCue <> 0)then CurrPage.CancelBackgroundTask(TaskIdCalculateCue);
        CurrPage.EnqueueBackgroundTask(TaskIdCalculateCue, Codeunit::"O365 Activities Dictionary");
    end;
}
