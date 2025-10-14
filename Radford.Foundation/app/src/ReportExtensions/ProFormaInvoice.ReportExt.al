reportextension 50010 FS_RF_ProFormaInvoice extends FSG_GLD_ProFormaInvoice
{
    dataset
    {
        add("Sales Header")
        {
            column(FS_RF_ForeignCustomer; ForeignCustomer)
            {
            }
        }
        modify("Sales Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                Customer: Record Customer;
            begin
                SalesSetup.Get();
                Customer.Get("Sales Header"."Bill-to Customer No.");
                if Customer."VAT Bus. Posting Group" = SalesSetup.FS_RF_ForeignGSTPostingGroup then begin
                    ForeignCustomer := true;
                end;
            end;
        }
    }
    rendering
    {
        layout(FS_RF_ProFormaInvoice)
        {
            Type = RDLC;
            LayoutFile = './layouts/ProFormaInvoice.rdlc';
        }
    }
    labels
    {
        FS_RF_AmountCaption = 'Amount';
    }
    var
        ForeignCustomer: Boolean;
}