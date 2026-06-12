query 78309 "FW_Items"
{
    QueryType = API;
    APIPublisher = 'FW';
    APIGroup = 'supplyChain';
    APIVersion = 'v1.0';
    EntityName = 'item';
    EntitySetName = 'items';

    elements
    {
        dataitem(Item; Item)
        {
            column(no; "No.") { }
            column(description; Description) { }
            column(inventory; Inventory) { }
            column(unitPrice; "Unit Price") { }
            column(itemCategoryCode; "Item Category Code") { }
            column(monitor; "WSB Checkbox 1") { }
            column(alertQuantity; "WSB Number 1") { }
            column(alertReason; "WSB Text 1") { }
            // dataitem(BSOoutstanding; "Sales Line")
            // {
            //     DataItemLink = "No." = Item."No.";
            //     DataItemTableFilter = "Document Type" = const("Blanket Order");
            //     SqlJoinType = LeftOuterJoin;

            //     column(blanketOutstandingQty; "Outstanding Quantity")
            //     {
            //         Method = Sum;
            //     }
            //     dataitem(BlanketSalesHeader; "Sales Header")
            //     {
            //         DataItemLink = "No." = BlanketSalesLine."No.";
            //         DataItemTableFilter = "Document Type" = const("Blanket Order"), Status = const(Open);
            //         SqlJoinType = InnerJoin;
            //     }

            // }
        }
    }
}