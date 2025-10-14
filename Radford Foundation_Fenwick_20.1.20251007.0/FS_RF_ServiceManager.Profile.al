profile FS_RF_ServiceManager
{
    Caption = 'Service Manager Profile';
    Customizations = FS_RF_SalesOrderList, FS_RF_PurchaseInvoices;
    Enabled = true;
    Promoted = true;
    ProfileDescription = 'Service Manager';
    RoleCenter = FS_RF_ServiceMgrRoleCenter;
}
