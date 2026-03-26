pageextension 50016 FS_RF_SalesOrderList extends "Sales Order List"
{
    layout
    {
        addafter("External Document No.")
        {
            field(FS_RF_CampaignNo; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Completely Shipped")
        {
            field(FS_RF_Completed; Rec.FS_RF_Completed)
            {
                ApplicationArea = All;
            }
            field(FS_RF_InvoiceSubmitted; Rec.FS_RF_InvoiceSubmitted)
            {
                ApplicationArea = All;
            }
            field(FS_RF_ApprovedToPay; Rec.FS_RF_ApprovedToPay)
            {
                ApplicationArea = All;
            }
        }
        addbefore("No.")
        {
            field(FS_RF_OrderDate; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field(FS_RF_LinkedPI; Rec.FS_RF_LinkedPI)
            {
                ApplicationArea = All;
                Editable = false;

                trigger OnAssistEdit()
                begin
                    Rec.FS_RF_LookupPurchaseInvPage();
                end;
            }
            field(FS_RF_ApprForCustInvoice; Rec.FS_RF_ApprForCustInvoice)
            {
                ApplicationArea = All;
            }
            field(FS_RF_DocumentEmailSent; Rec.FS_RF_DocumentEmailSent)
            {
                ApplicationArea = All;
            }
        }
        addfirst(Control1)
        {
            field(FS_RF_RequestedDeliveryDate; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field(FS_RF_ReadyForShipping; Rec.FS_RF_ReadyForShipping)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(FS_RF_CalculateFreight)
            {
                Caption = 'Calculate Freight';
                ApplicationArea = All;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    TotalFreightPrice: Decimal;
                begin
                    Rec.FS_RF_CreateFreightSalesLine(TotalFreightPrice, SalesLine);
                end;
            }
        }
        addafter("Print Confirmation")
        {
            action(FS_RF_SendEmailServiceRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Service Request Email Confirmation';
                Ellipsis = true;
                Image = Email;
                Promoted = true;
                PromotedCategory = Category8;
                ToolTip = 'Send an Service Request confirmation by email. The Send Email window opens prefilled for the customer so you can add or change information before you send the email.';

                trigger OnAction()
                var
                    Utilities: Codeunit FS_RF_Utilities;
                begin
                    Utilities.EmailSalesHeaderServiceRequest(Rec);
                end;
            }
        }
    }
}
