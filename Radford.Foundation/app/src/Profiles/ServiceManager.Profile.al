profile FS_RF_ServiceManager
{
    Caption = 'Service Manager Profile';
    Customizations = FS_RF_SalesOrderList, FS_RF_PurchaseInvoices;
    Enabled = true;
    Promoted = true;
    ProfileDescription = 'Service Manager';
    RoleCenter = FS_RF_ServiceMgrRoleCenter;
}
profile FS_RF_Warehouse
{
    Caption = 'Warehouse';
    ProfileDescription = 'Warehouse';
    RoleCenter = FS_RF_WarehouseRoleCenter;
    Enabled = true;
    Promoted = true;
}
profile FS_RF_Purchasing
{
    Caption = 'Purchasing';
    ProfileDescription = 'Purchasing';
    RoleCenter = FS_RF_PurchasingRoleCenter;
    Enabled = true;
    Promoted = true;
}
profile FS_RF_FinanceManager
{
    Caption = 'Finance Manager';
    ProfileDescription = 'Finance Manager';
    RoleCenter = FS_RF_FinanceMgrRoleCenter;
    Enabled = true;
    Promoted = true;
}