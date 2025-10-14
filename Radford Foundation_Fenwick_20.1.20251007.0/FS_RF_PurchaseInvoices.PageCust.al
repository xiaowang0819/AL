pagecustomization FS_RF_PurchaseInvoices customizes "Purchase Invoices"
{
    views
    {
        addfirst
        {
            view(FS_RF_SRVLinkedPurchInv)
            {
                Caption = 'SRV Linked Purch Inv';
                Filters = where("Document Type"=const(Invoice), FS_RF_LinkedOrder=filter('<>'''''));
            }
        }
    }
}
