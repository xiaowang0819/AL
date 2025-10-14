tableextension 50015 FS_RF_SalesSetup extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; FS_RF_HideDialogShipOnly; Boolean)
        {
            Caption = 'Hide Dialog Ship Only';
            DataClassification = CustomerContent;
        }
        field(50001; FS_RF_DisableSalesOrderTempl; Boolean)
        {
            Caption = 'Disable Sales Order Template';
            DataClassification = CustomerContent;
        }
        field(50002; FS_RF_DisableServiceProvider; Boolean)
        {
            Caption = 'Disable Using Service Provider when Creating PurchInvoice';
            DataClassification = CustomerContent;
        }
        field(50003; FS_RF_DisableMultipleAttach; Boolean)
        {
            Caption = 'Disable Multiple Attach Custom';
            DataClassification = CustomerContent;
        }
        field(50004; FS_RF_DefContrShipToAddr; Code[10])
        {
            Caption = 'Default Contractor Ship-to Addrress';
            DataClassification = CustomerContent;
        }
        field(50005; FS_RF_ForeignGSTPostingGroup; Code[20])
        {
            Caption = 'Foreign GST Posting Group Code';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(50006; FS_RF_ServiceOrderNos; Code[20])
        {
            Caption = 'Service Order Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50007; FS_RF_ProjectOrderNos; Code[20])
        {
            Caption = 'Project Order Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50008; FS_RF_DefaultFreightCode; Code[20])
        {
            Caption = 'Default Freight Code';
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
    }
}
