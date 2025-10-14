pageextension 50021 FS_RF_SalesSetup extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field(FS_RF_ForeignGSTPostingGroup; Rec.FS_RF_ForeignGSTPostingGroup)
            {
                ApplicationArea = All;
            }
            field(FS_RF_DefaultFreightCode; Rec.FS_RF_DefaultFreightCode)
            {
                ApplicationArea = All;
            }
            field(FS_RF_HideDialogShipOnly; Rec.FS_RF_HideDialogShipOnly)
            {
                ApplicationArea = All;
            }
            field(FS_RF_DisableSalesOrderTempl; Rec.FS_RF_DisableSalesOrderTempl)
            {
                ApplicationArea = All;
            }
            field(FS_RF_DisableServiceProvider; Rec.FS_RF_DisableServiceProvider)
            {
                ApplicationArea = All;
            }
            field(FS_RF_DisableMultipleAttach; Rec.FS_RF_DisableMultipleAttach)
            {
                ApplicationArea = All;
            }
            field(FS_RF_DefContrShipToAddr; Rec.FS_RF_DefContrShipToAddr)
            {
                ApplicationArea = All;
            }
        }
        addlast("Number Series")
        {
            field(FS_RF_ServiceOrderNos; Rec.FS_RF_ServiceOrderNos)
            {
                ApplicationArea = All;
            }
            field(FS_RF_ProjectOrderNos; Rec.FS_RF_ProjectOrderNos)
            {
                ApplicationArea = All;
            }
        }
    }
}