pageextension 78001 SalesOrderExt extends "Sales Order"
{
    actions
    {
        addlast("&Print")
        {
            action(PrintMyReport)
            {
                ApplicationArea = All;
                Caption = 'Print JW-DeliveryDocket';
                Image = Print;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(78002, true, true, SalesHeader);
                end;
            }
        }
    }
}
