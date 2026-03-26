reportextension 50001 FS_RF_StandardSalesQuote extends "Standard Sales - Quote"
{
    rendering
    {
        layout(FS_RF_SalesQuoteLayout)
        {
            Type = Word;
            LayoutFile = './layouts/SalesQuote.docx';
        }
    }
}
