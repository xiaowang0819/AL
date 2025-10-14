pagecustomization FS_RF_SalesOrderList customizes "Sales Order List"
{
    views
    {
        addfirst
        {
            view(FS_RF_SRVOrderInitialized)
            {
                Caption = 'SRV Order Initialized';
                Filters = where(FS_RF_DocumentEmailSent = const(false), "Document Type" = const(Order), "No." = filter('SERV*'));
            }
            view(FS_RF_SRVSentWaitingRelease)
            {
                Caption = 'SRV Sent Waiting Release';
                Filters = where(FS_RF_DocumentEmailSent = const(true), "Document Type" = const(Order), "No." = filter('SERV*'), FS_RF_ReadyForShipping = const(false));
            }
            view(FS_RF_SRVOrderReleased)
            {
                Caption = 'SRV Order Released';
                Filters = where("Completely Shipped" = const(false), "Document Type" = const(Order), "No." = filter('SERV*'), FS_RF_ReadyForShipping = const(true));
            }
            view(FS_RF_SRVOrderShipped)
            {
                Caption = 'SRV Order Shipped';
                Filters = where("Document Type" = const(Order), "No." = filter('SERV*'), FS_RF_Shipped = const(true));
            }
            view(FS_RF_SRVOrderContInvoiced)
            {
                Caption = 'SRV Order Cont Invoiced';
                Filters = where("Document Type" = const(Order), "No." = filter('SERV*'), FS_RF_LinkedPI = filter('<>'''''));
            }
            view(FS_RF_SRVOrderReadyCustInv)
            {
                Caption = 'SRV Order Ready Cust Inv';
                Filters = where(FS_RF_ApprForCustInvoice = const(true), "Document Type" = const(Order), "No." = filter('SERV*'));
            }
        }
    }
}