page 50002 FS_RF_CustomBusManager
{
    Caption = 'Custom Activities';
    PageType = CardPart;
    SourceTable = "Activities Cue";

    layout
    {
        area(Content)
        {
            cuegroup(FS_RF_SalesCueGroup)
            {
                Caption = 'Sales';

                field(FS_RF_ServiceOrders; Rec.FS_RF_ServiceOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Service Orders';
                    ToolTip = 'Specifies the service orders that have not been shipped or posted yet.';

                    trigger OnDrillDown()
                    begin
                        SalesSetup.Get();
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("No. Series", SalesSetup.FS_RF_ServiceOrderNos);
                        SalesHeader.SetRange(Shipped, false);
                        Page.Run(Page::"Sales Order List", SalesHeader);
                    end;
                }
                field(FS_RF_SalesOrders; Rec.FS_RF_SalesOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders';
                    ToolTip = 'Specifies the sales orders that have not been shipped or posted yet.';

                    trigger OnDrillDown()
                    begin
                        SalesSetup.Get();
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("No. Series", SalesSetup."Order Nos.");
                        SalesHeader.SetRange(Shipped, false);
                        Page.Run(Page::"Sales Order List", SalesHeader);
                    end;
                }
                field(FS_RF_ProjectOrders; Rec.FS_RF_ProjectOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Project Orders';
                    ToolTip = 'Specifies the project orders that have not been shipped or posted yet.';

                    trigger OnDrillDown()
                    begin
                        SalesSetup.Get();
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("No. Series", SalesSetup.FS_RF_ProjectOrderNos);
                        SalesHeader.SetRange(Shipped, false);
                        Page.Run(Page::"Sales Order List", SalesHeader);
                    end;
                }
                field(FS_RF_SalesOrdersShipped; Rec.FS_RF_SalesOrdersShipped)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders Shipped';
                    ToolTip = 'Specifies the service, sales & project orders that have been shipped but not posted yet.';

                    trigger OnDrillDown()
                    begin
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange(Shipped, true);
                        Page.Run(Page::"Sales Order List", SalesHeader);
                    end;
                }
                field(FS_RF_PostedSalesInvoices; Rec.FS_RF_PostedSalesInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    ToolTip = 'Specifies all posted sales invoices.';

                    trigger OnDrillDown()
                    begin
                        SalesInvoiceHeader.Reset();
                        Page.Run(Page::"Posted Sales Invoices", SalesInvoiceHeader);
                    end;
                }
                field(FS_RF_OutstandingSalesInvoices; Rec.FS_RF_OutstandingSalesInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Outstanding Sales Invoices';
                    ToolTip = 'Specifies all outstanding sales invoices.';

                    trigger OnDrillDown()
                    begin
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SetFilter("Remaining Amount", '>%1', 0);
                        Page.Run(Page::"Posted Sales Invoices", SalesInvoiceHeader);
                    end;
                }
            }
            cuegroup(FS_RF_PurchasesCueGroup)
            {
                Caption = 'Purchases';

                field(FS_RF_PurchaseOrders; Rec.FS_RF_PurchaseOrders)
                {
                    ApplicationArea = All;
                    Caption = 'New Purchase Order';
                    ToolTip = 'Specifies the purchase orders that have not been received or posted yet.';

                    trigger OnDrillDown()
                    begin
                        PurchHeader.Reset();
                        PurchHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        PurchHeader.SetRange(FS_RF_Received, false);
                        Page.Run(Page::"Purchase Order List", PurchHeader);
                    end;
                }
                field(FS_RF_PurchaseOrdersReceipted; Rec.FS_RF_PurchaseOrdersReceipted)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order Receipted';
                    ToolTip = 'Specifies the purchase orders that have been received but not posted yet.';

                    trigger OnDrillDown()
                    begin
                        PurchHeader.Reset();
                        PurchHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        PurchHeader.SetRange(FS_RF_Received, true);
                        Page.Run(Page::"Purchase Order List", PurchHeader);
                    end;
                }
            }
        }
    }
    var SalesHeader: Record "Sales Header";
    PurchHeader: Record "Purchase Header";
    SalesInvoiceHeader: Record "Sales Invoice Header";
    SalesSetup: Record "Sales & Receivables Setup";
}
