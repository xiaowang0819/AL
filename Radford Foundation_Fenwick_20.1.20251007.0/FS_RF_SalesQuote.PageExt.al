pageextension 50036 FS_RF_SalesQuote extends "Sales Quote"
{
    actions
    {
        addlast(processing)
        {
            action(FS_RF_CalculateFreight)
            {
                Caption = 'Calculate Freight';
                ApplicationArea = All;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    TotalFreightPrice: Decimal;
                begin
                    Rec.FS_RF_CreateFreightSalesLine(TotalFreightPrice, SalesLine);
                end;
            }
        }
    }
}
