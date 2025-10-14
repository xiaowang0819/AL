pageextension 78222 "Sales Line extss" extends "Sales Lines"
{
    layout
    {
        addafter(Quantity)
        {
            field(FS_RF_ContractorUnitCost; Rec.FS_RF_ContractorUnitCost)
            {

            }
        }
    }
}