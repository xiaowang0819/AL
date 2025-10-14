pageextension 50503 FS_RF_VendorList extends "Vendor List"
{
    actions
    {
        addafter("Bank Accounts")
        {
            action(FS_RF_ShipToAddresses)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Contractor Ship-&to Addresses';
                Image = ShipAddress;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = page FS_RF_ContractorShipToList;
                RunPageLink = FS_RF_VendorNo = field("No.");
                ToolTip = 'View or edit alternate shipping addresses where the contractor wants items delivered if different from the regular address.';
            }
        }
    }
}