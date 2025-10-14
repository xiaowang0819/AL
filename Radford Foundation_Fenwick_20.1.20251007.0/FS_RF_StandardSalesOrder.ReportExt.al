reportextension 50002 FS_RF_StandardSalesOrder extends "Standard Sales - Order Conf."
{
    rendering
    {
        layout(FS_RF_SalesOrderLayout)
        {
            Type = Word;
            LayoutFile = './layouts/SalesOrder.docx';
        }
    }
}
