pageextension 50504 FS_RF_PostedSalesInvUpdate extends "Posted Sales Inv. - Update"
{
    layout
    {
        addlast(Payment)
        {
            field(FS_RF_ExternalDocNo; Rec."External Document No.")
            {
                ApplicationArea = All;
                Editable = true;
                Visible = true;
            }
        }
    }
}

