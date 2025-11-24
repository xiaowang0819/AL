pageextension 78009 SalesQuoteExt extends "Sales Quote"
{
    layout
    {
        addafter(Status)
        {
            field("Opportunity"; Rec."Opportunity")
            {
                ApplicationArea = All;
                Caption = 'Opportunity';
                ToolTip = 'Indicates the current opportunity status (Hot, Medium).';
            }
        }
    }
}

pageextension 78010 SalesQuotesListExt extends "Sales Quotes"
{
    layout
    {
        addafter("No.")
        {
            field("Opportunity"; Rec."Opportunity")
            {
                ApplicationArea = All;
                Caption = 'Opportunity';
                ToolTip = 'Indicates the current opportunity status (Hot, Medium).';
                Editable = true;
            }
        }
    }
}
