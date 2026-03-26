table 50000 FS_RF_SalesOrderTemplate
{
    Caption = 'Sales Order Template';
    DataClassification = CustomerContent;

    fields
    {
        field(1; FS_RF_Code; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; FS_RF_Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; FS_RF_NoSeries; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; FS_RF_Code)
        {
            Clustered = true;
        }
    }
}
