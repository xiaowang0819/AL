reportextension 50011 FS_RF_SalesCreditMemo extends FSG_GLD_SalesCreditMemo
{
    rendering
    {
        layout(FS_RF_SalesCreditMemo)
        {
            Type = RDLC;
            LayoutFile = './layouts/SalesCreditMemo.rdlc';
        }
    }
}