page 50605 FS_RF_WarehouseRCActivities
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
            cuegroup("Released Orders")
            {
                Caption = 'Released Orders';
                field("SRV Order Sent"; Rec.FS_RF_SRVOrderSent)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Sent Waiting Release';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies SRV orders that the document has been sent to email waiting for Released orders.';
                }
                field("SRV Released Orders"; Rec.FS_RF_SRVReleasedOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SRV Released Orders';
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
                field("ERP_Waiting for Released"; Rec.FS_RF_SOWaitingForReleased)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SO Waiting Release';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Waiting for Released orders';
                    Visible = false;
                }
                field("Erx Order Shipped"; Rec.FS_RF_SalesOrderShippedBasic)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order Shipped';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies sales orders that has been shipped.';
                    Visible = false;
                }

                field("ERP_PROJ for Released"; Rec.FS_RF_ProjWaitingForReleased)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Project Order Waiting Release';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Waiting for released project orders';
                    Visible = false;
                }
                field("PROJ Released Orders"; Rec.FS_RF_ProjReleased)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Project Released Orders';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies project orders that are status is released.';
                    Visible = false;
                }

                field("Erx PROJ Order Shipped"; Rec.FS_RF_ProjOrderShipped)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Project Order Shipped';
                    DrillDownPageId = "Sales Order List";
                    ToolTip = 'Specifies project orders that has been shipped.';
                    Visible = false;
                }
                field(FS_RF_SOWaitingRelease; Rec.FS_RF_SOWaitingRelease)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
                field(FS_RF_SOReleasedOrders; Rec.FS_RF_SOReleasedOrders)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
                field(FS_RF_SalesOrderShipped; Rec.FS_RF_SalesOrderShipped)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
                field(FS_RF_ProjectOrderWaitingRelease; Rec.FS_RF_ProjectOrderWaitingRelease)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
                field(FS_RF_ProjectOrderReleasedOrders; Rec.FS_RF_ProjectOrderReleasedOrders)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
                field(FS_RF_ProjectOrderShipped; Rec.FS_RF_ProjectOrderShipped)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
            }
            cuegroup("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                field("PO Waiting Release"; Rec.FS_RF_POWaitingRelease)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PO Waiting Release';
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies purchase orders that are status is open.';
                }
                field("PO Released"; Rec.FS_RF_POReleased)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PO Released';
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies purchase orders that are status is released and not been fully received.';
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

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(FS_RF_SalesOrderNos);
    end;

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

