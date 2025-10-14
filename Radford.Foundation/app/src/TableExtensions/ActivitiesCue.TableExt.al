tableextension 50016 FS_RF_ActivitiesCue extends "Activities Cue"
{
    fields
    {
        field(50000; FS_RF_ServiceOrders; Integer)
        {
            CalcFormula = count("Sales Header" where("No. Series" = field(FS_RF_ServiceOrderNos), "Document Type" = const(Order), Shipped = const(false)));
            Caption = 'Service Orders';
            Description = 'Radford have a setup where they use Sales Orders as Service Orders. The number series can be found on the Sales Order Templates page';
            FieldClass = FlowField;
        }
        field(50001; FS_RF_SalesOrders; Integer)
        {
            CalcFormula = count("Sales Header" where("No. Series" = field(FS_RF_SalesOrderNos), "Document Type" = const(Order), Shipped = const(false)));
            Caption = 'Sales Orders';
            FieldClass = FlowField;
        }
        field(50002; FS_RF_ProjectOrders; Integer)
        {
            CalcFormula = count("Sales Header" where("No. Series" = field(FS_RF_ProjectOrderNos), "Document Type" = const(Order), Shipped = const(false)));
            Caption = 'Project Orders';
            Description = 'Radford have a setup where they use Sales Orders as Project Orders. The number series can be found on the Sales Order Templates page';
            FieldClass = FlowField;
        }
        field(50003; FS_RF_SalesOrdersShipped; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Order), Shipped = const(true)));
            Caption = 'Sales Orders Shipped';
            FieldClass = FlowField;
        }
        field(50004; FS_RF_PurchaseOrders; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order), FS_RF_Received = const(false)));
            Caption = 'Purchase Orders';
            FieldClass = FlowField;
        }
        field(50005; FS_RF_PurchaseOrdersReceipted; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order), FS_RF_Received = const(true)));
            Caption = 'Purchase Orders Receipted';
            FieldClass = FlowField;
        }
        field(50006; FS_RF_PostedSalesInvoices; Integer)
        {
            CalcFormula = count("Sales Invoice Header");
            Caption = 'Posted Sales Invoices';
            FieldClass = FlowField;
        }
        field(50007; FS_RF_OutstandingSalesInvoices; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("Remaining Amount" = filter(> 0)));
            Caption = 'Outstanding Sales Invoices';
            FieldClass = FlowField;
        }
        field(50008; FS_RF_SalesOrderNos; Code[20])
        {
            CalcFormula = lookup("Sales & Receivables Setup"."Order Nos.");
            Caption = 'Sales Order Nos.';
            FieldClass = FlowField;
        }
        field(50009; FS_RF_ServiceOrderNos; Code[20])
        {
            CalcFormula = lookup("Sales & Receivables Setup".FS_RF_ServiceOrderNos);
            Caption = 'Service Order Nos.';
            FieldClass = FlowField;
        }
        field(50010; FS_RF_ProjectOrderNos; Code[20])
        {
            CalcFormula = lookup("Sales & Receivables Setup".FS_RF_ProjectOrderNos);
            Caption = 'Project Order';
            FieldClass = FlowField;
        }
        field(50011; FS_RF_SalesOrdersReadyForInv; Integer)
        {
            Caption = 'Sales Orders Ready for Invoicing';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), "Shipped Not Invoiced" = const(true)));
            FieldClass = FlowField;
        }
        field(50012; FS_RF_SOWaitingRelease; Integer)
        {
            Caption = 'SO Waiting Release';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), "Completely Shipped" = const(false), "No. Series" = field(FS_RF_SalesOrderNos), FS_RF_ReadyForShipping = const(false), "Campaign No." = filter('')));
            FieldClass = FlowField;
        }
        field(50013; FS_RF_SOReleasedOrders; Integer)
        {
            Caption = 'SO Released Orders';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), "Completely Shipped" = const(false), "No. Series" = field(FS_RF_SalesOrderNos), FS_RF_ReadyForShipping = const(true), "Campaign No." = filter('')));
            FieldClass = FlowField;
        }
        field(50014; FS_RF_SalesOrderShipped; Integer)
        {
            Caption = 'Sales Order Shipped';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), "Completely Shipped" = const(false), "No. Series" = field(FS_RF_SalesOrderNos), FS_RF_Shipped = const(true), "Campaign No." = filter('')));
            FieldClass = FlowField;
        }
        field(50015; FS_RF_ProjectOrderWaitingRelease; Integer)
        {
            Caption = 'Project Order Waiting Release';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), "Completely Shipped" = const(false), FS_RF_ReadyForShipping = const(false), "Campaign No." = filter('CP*')));
            FieldClass = FlowField;
        }
        field(50016; FS_RF_ProjectOrderReleasedOrders; Integer)
        {
            Caption = 'Project Order Released Orders';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), "Completely Shipped" = const(false), FS_RF_ReadyForShipping = const(true), "Campaign No." = filter('CP*')));
            FieldClass = FlowField;
        }
        field(50017; FS_RF_ProjectOrderShipped; Integer)
        {
            Caption = 'Project Order Shipped';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), "Completely Shipped" = const(false), FS_RF_Shipped = const(true), "Campaign No." = filter('CP*')));
            FieldClass = FlowField;
        }
        field(50018; FS_RF_SRVOrderInitialized; Integer)
        {
            Caption = 'SRV Order Initialized';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SERV*'),
                                                        FS_RF_DocumentEmailSent = const(false)));
            FieldClass = FlowField;
        }

        field(50019; FS_RF_SRVOrderSent; Integer)
        {
            Caption = 'SRV Sent Not Released';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SERV*'),
                                                        FS_RF_ReadyForShipping = filter(false),
                                                        FS_RF_DocumentEmailSent = const(true)));
            FieldClass = FlowField;
        }
        field(50020; FS_RF_SRVOrderReleased; Integer)
        {
            Caption = 'SRV Order Released';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SERV*'),
                                                           "Completely Shipped" = filter(false),
                                                          FS_RF_ReadyForShipping = filter(true)));

            FieldClass = FlowField;
        }
        field(50021; FS_RF_SRVOrderContInvoiced; Integer)
        {
            Caption = 'SRV Order Cont Invoiced';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SERV*'),
                                                        FS_RF_LinkedPI = filter(<> '')));
            FieldClass = FlowField;
        }
        field(50022; FS_RF_SRVOrderReadyCustInv; Integer)
        {
            Caption = 'SRV Order Ready Cust Inv';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SERV*'),
                                                        FS_RF_ApprForCustInvoice = const(true)));
            FieldClass = FlowField;
        }
        field(50023; FS_RF_SRVLinkedPurchInv; Integer)
        {
            Caption = 'SRV Linked Purch Inv';
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Invoice),
                                                       FS_RF_LinkedOrder = filter(<> '')));
            FieldClass = FlowField;
        }
        field(50024; FS_RF_SRVReleasedOrders; Integer)
        {
            Caption = 'SRV Released Orders';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SERV*'),
                                                           "Completely Shipped" = filter(false),
                                                           FS_RF_ReadyForShipping = filter(true)
                                                         //Status = filter(Released)
                                                         ));
            FieldClass = FlowField;
        }
        // Replaced by field FS_RF_SOReleasedOrders
        // field(50025; "ERP_SO Released Orders"; Integer)
        // {
        //     Caption = 'SO Released Orders';
        //     CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
        //                                                 "No." = filter('SO*'),
        //                                                    "Completely Shipped" = filter(false),
        //                                                  FS_RF_ReadyForShipping = filter(true)
        //                                                 //Status = filter(Released)
        //                                                 ));
        //     FieldClass = FlowField;
        // }
        field(50026; FS_RF_POWaitingRelease; Integer)
        {
            Caption = 'PO Waiting Release';
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Order),
                                                         Status = filter(Open)));
            FieldClass = FlowField;
        }
        field(50027; FS_RF_POReleased; Integer)
        {
            Caption = 'PO Released';
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Order),
                                                        Receive = const(true),
                                                        Status = filter(Released)));
            FieldClass = FlowField;
        }
        field(50028; FS_RF_POPendingPrepayment; Integer)
        {
            Caption = 'PO Pending Prepayment';
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Order),
                                                        Status = filter("Pending Prepayment")));
            FieldClass = FlowField;
        }
        field(50029; FS_RF_POUpcomingOrders; Integer)
        {
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Order),
                                                         Status = filter(Released),
                                                         "Expected Receipt Date" = field(FS_RF_DateFilter)));
            Caption = 'Upcoming Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; FS_RF_DateFilter; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50031; FS_RF_PONotInvoiced; Integer)
        {
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Order),
                                                         "Completely Received" = filter(true),
                                                         Invoice = filter(false)));
            Caption = 'Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50032; FS_RF_POPartiallyInvoiced; Integer)
        {
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Order),
                                                         "Completely Received" = filter(true),
                                                         Invoice = filter(true)));
            Caption = 'Partially Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50033; FS_RF_SalesOrderReleased; Integer)
        {
            Caption = 'Sales Order Released';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SO*'),
                                                     //   Status = filter(Released),
                                                     FS_RF_ReadyForShipping = filter(true),
                                                        "Completely Shipped" = filter(false)));
            FieldClass = FlowField;
        }
        field(50034; FS_RF_SOWaitingForReleased; Integer)
        {
            Caption = 'SO Waiting Released';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SO*'),
                                                     //   Status = filter(Released),
                                                     FS_RF_ReadyForShipping = filter(false),
                                                        "Completely Shipped" = filter(false)));
            FieldClass = FlowField;
        }
        field(50035; FS_RF_ServWaitingForReleased; Integer)
        {
            Caption = 'Service Order Waiting for Released';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SERV*'),
                                                     //   Status = filter(Released),
                                                     FS_RF_ReadyForShipping = filter(false),
                                                        "Completely Shipped" = filter(false)));
            FieldClass = FlowField;
        }

        field(50036; FS_RF_SOPendingPrepayment; Integer)
        {
            Caption = 'SO Pending Prepayment';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        Status = filter("Pending Prepayment")));
            FieldClass = FlowField;
        }

        field(50037; FS_RF_ServOrderShipped; Integer)
        {
            Caption = 'SRV Order Shipped';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SERV*'),
                                                         FS_RF_Shipped = filter(true)));

            FieldClass = FlowField;
        }
        // Basic filters from ERPWerx Role Centre App
        field(50038; FS_RF_SalesOrderShippedBasic; Integer)
        {
            Caption = 'Sales Order Shipped';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('SO*'),
                                                        FS_RF_Shipped = filter(true)));

            FieldClass = FlowField;
        }
        field(50039; FS_RF_ProjReleased; Integer)
        {
            Caption = 'Project Order Released';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('PROJ*'),
                                                     //   Status = filter(Released),
                                                     FS_RF_ReadyForShipping = filter(true),
                                                        "Completely Shipped" = filter(false)));
            FieldClass = FlowField;
        }
        field(50040; FS_RF_ProjWaitingForReleased; Integer)
        {
            Caption = 'Project Order Waiting Released';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('PROJ*'),
                                                     //   Status = filter(Released),
                                                     FS_RF_ReadyForShipping = filter(false),
                                                        "Completely Shipped" = filter(false)));
            FieldClass = FlowField;
        }
        field(50041; FS_RF_ProjOrderShipped; Integer)
        {
            Caption = 'Project Order Shipped';
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order),
                                                        "No." = filter('PROJ*'),

                                                          FS_RF_Shipped = filter(true)));

            FieldClass = FlowField;
        }
    }

    procedure FS_RF_ShowOrders(FieldNumber: Integer)
    var
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
        case FieldNumber of
            FieldNo(FS_RF_PONotInvoiced):
                begin
                    PurchHeader.SetRange(Status);
                    PurchHeader.SetRange("Completely Received", true);
                    PurchHeader.SetRange(Invoice, false);
                end;
            FieldNo(FS_RF_POPartiallyInvoiced):
                begin
                    PurchHeader.SetRange(Status);
                    PurchHeader.SetRange("Completely Received", true);
                    PurchHeader.SetRange(Invoice, true);
                end;
        end;
        Page.Run(Page::"Purchase Order List", PurchHeader);
    end;
}