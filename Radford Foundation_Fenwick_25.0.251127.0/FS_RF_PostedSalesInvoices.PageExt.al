pageextension 50022 FS_RF_PostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        addafter("No.")
        {
            field(FS_RF_YourReference; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("External Document No.")
        {
            field(FS_RF_OrderDate; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Currency Code")
        {
            field(FS_RF_CampaignNo; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(FS_RF_YourReference)
        {
            field("FS_RF_Package_Tracking_No."; Rec."Package Tracking No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
