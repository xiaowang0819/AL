pageextension 50027 FS_RF_SalesOrderSubform extends "Sales Order Subform"
{
    layout
    {
        addafter("Unit Price")
        {
            field(FS_RF_FreightPrice; Rec.FS_RF_FreightPrice)
            {
                ApplicationArea = All;
            }
            field(FS_RF_ContractorUnitCost; Rec.FS_RF_ContractorUnitCost)
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. Assigned")
        {
            field(FS_RF_ExternalDocumentNo; Rec.FS_RF_ExternalDocumentNo)
            {
                ApplicationArea = All;
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.FS_RF_FreightPrice:=Rec.FS_RF_UpdateFreightPrice();
                CurrPage.Update(false);
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                Rec.FS_RF_FreightPrice:=Rec.FS_RF_UpdateFreightPrice();
                CurrPage.Update(false);
            end;
        }
    }
}
