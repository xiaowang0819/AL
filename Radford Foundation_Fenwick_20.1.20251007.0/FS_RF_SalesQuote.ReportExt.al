reportextension 50006 FS_RF_SalesQuote extends FSG_GLD_SalesQuote
{
    dataset
    {
        add("Sales Header")
        {
            column(FS_RF_ForeignCustomer; ForeignCustomer)
            {
            }
            column(FS_RF_YourReference; "Your Reference")
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
                ForeignCustomer:=true;
            end;
        end;
        }
    }
    rendering
    {
        layout(FS_RF_SalesQuote)
        {
            Type = RDLC;
            LayoutFile = './layouts/SalesQuote.rdlc';
        }
    }
    labels
    {
    FS_RF_AmountCaption='Amount';
    FS_RF_YourReferenceCaption='Your Reference';
    }
    var ForeignCustomer: Boolean;
}
