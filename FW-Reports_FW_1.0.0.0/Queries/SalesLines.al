query 78301 "Sales Line with Header Info"
{
    QueryType = Normal;

    elements
    {
        dataitem(SalesLine; "Sales Line")
        {
            column(Document_No; "Document No.") { }
            column(Line_No; "Line No.") { }
            column(Sell_to_Customer_No; "Sell-to Customer No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Type; Type) { }
            column(No_; "No.") { }
            column(Description; Description) { }
            column(Description2; "Description 2") { }
            column(Quantity; Quantity) { }
            column(Amount; Amount) { }


            dataitem(SalesHeader; "Sales Header")
            {
                DataItemLink = "Document Type" = SalesLine."Document Type", "No." = SalesLine."Document No.";

                column(External_Document_No; "External Document No.") { }
            }
        }
    }
}

query 78302 "JW Invoice Lines"
{
    QueryType = Normal;

    elements
    {
        dataitem(SIL; "Sales Invoice Line")
        {
            // column(DocType; const("INvoice")) { }
            column(DocNo; "Document No.") { }
            column(LineNo; "Line No.") { }
            column(CustomerNo; "Sell-to Customer No.") { }
            column(CustomerName; "Sell-to Customer Name") { }
            column(Type; Type) { }
            column(No; "No.") { }
            column(Description; Description) { }
            column(Description2; "Description 2") { }
            column(Qty; Quantity) { }
            column(Amount; Amount) { }
            column(Cost; "Cost Amount") { }
            column(LineExtDoc; FS_RF_ExternalDocumentNo) { }
            column(BSONo; "Blanket Order No.") { }
            column(BSOLine; "Blanket Order Line No.") { }
            column(BSOExtDoc; BSOExtDoc) { }
            dataitem(SIH; "Sales Invoice Header")
            {
                DataItemLink = "No." = SIL."Document No.";
                SqlJoinType = InnerJoin;
                column(uRef; "Your Reference") { }
                column(INVExtDoc; "External Document No.") { }
                column(Campaign; "Campaign No.") { }
                column(ShipToCode; "Ship-to Code") { }

            }
        }

    }
}


query 78303 "JW CM Lines"
{
    QueryType = Normal;

    elements
    {
        dataitem(SCL; "Sales Cr.Memo Line")
        {
            // column(DocType; const("INvoice")) { }
            column(DocNo; "Document No.") { }
            column(LineNo; "Line No.") { }
            column(CustomerNo; "Sell-to Customer No.") { }
            column(CustomerName; "Sell-to Customer Name") { }
            column(Type; Type) { }
            column(No; "No.") { }
            column(Description; Description) { }
            column(Description2; "Description 2") { }
            column(Qty; Quantity) { }
            column(Amount; Amount) { }
            column(Cost; "Cost Amount") { }
            column(LineExtDoc; FS_RF_ExternalDocumentNo) { }
            column(BSONo; "Blanket Order No.") { }
            column(BSOLine; "Blanket Order Line No.") { }
            column(BSOExtDoc; BSOExtDoc) { }
            dataitem(SCH; "Sales Cr.Memo Header")
            {
                DataItemLink = "No." = SCL."Document No.";
                SqlJoinType = InnerJoin;
                column(uRef; "Your Reference") { }
                column(INVExtDoc; "External Document No.") { }
                column(Campaign; "Campaign No.") { }
                column(ShipToCode; "Ship-to Code") { }

            }
        }

    }
}

query 78304 "JW 4345 lines"
{
    QueryType = Normal;

    elements
    {
        dataitem(GLE4345; "G/L Entry")
        {
            DataItemTableFilter = "G/L Account No." = const('4345');
            column(Entry_No_; "Entry No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Document_Type; "Document Type") { }
            column(Document_No_; "Document No.") { }
            column(G_L_Account_No_; "G/L Account No.") { }
            column(Description; Description) { }
            column(Reconcile_Ref_No_; "Reconcile Ref No.") { }
            column(Reconcile_Remarks; "ReconcileRemarks") { }
            column(Quantity; Quantity) { }
            column(Amount; Amount) { }
            column(Source_Code; "Source Code") { }
            column(Source_No_; "Source No.") { }
            column(Source_Type; "Source Type") { }

            // dataitem(SCL; "Sales Cr.Memo Line")
            // {
            //     DataItemLink = "Document No." = GLE4345."Document No.";
            //     SqlJoinType = LeftOuterJoin;

            //     column(Type; Type) { }
            //     column(No_; "No.") { }
            //     column(ItemDescription; Description) { }
            //     column(Description2; "Description 2") { }
            //     column(Line_No_; "Line No.") { }
            //     column(ItemQuantity; Quantity) { }
            //     column(ItemAmount; Amount) { }
            //     column(BSONo; "Blanket Order No.") { }
            //     column(LineNo; "Blanket Order Line No.") { }

            //     dataitem(SCH; "Sales Cr.Memo Header")
            //     {
            //         DataItemLink = "No." = SCL."Document No.";
            //         SqlJoinType = InnerJoin;
            //         column(uRef; "Your Reference") { }
            //         column(INVExtDoc; "External Document No.") { }
            //         column(Campaign; "Campaign No.") { }
            //         column(ShipToCode; "Ship-to Code") { }

            //     }
            // }


            // dataitem(SIL; "Sales Cr.Memo Line")
            // {
            //     DataItemLink = "Document No." = GLE4345."Document No.";
            //     SqlJoinType = LeftOuterJoin;

            //     column(Type; Type) { }
            //     column(No_; "No.") { }
            //     column(ItemDescription; Description) { }
            //     column(Description2; "Description 2") { }
            //     column(Line_No_; "Line No.") { }
            //     column(ItemQuantity; Quantity) { }
            //     column(ItemAmount; Amount) { }
            //     column(BSONo; "Blanket Order No.") { }
            //     column(LineNo; "Blanket Order Line No.") { }

            //     dataitem(SIH; "Sales Cr.Memo Header")
            //     {
            //         DataItemLink = "No." = SIL."Document No.";
            //         SqlJoinType = InnerJoin;
            //         column(uRef; "Your Reference") { }
            //         column(INVExtDoc; "External Document No.") { }
            //         column(Campaign; "Campaign No.") { }
            //         column(ShipToCode; "Ship-to Code") { }

            //     }
            // }


        }
    }

}