tableextension 50009 FS_RF_SalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        field(50000; FS_RF_ServiceProvider; Code[20])
        {
            Caption = 'Service Provider';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(50001; FS_RF_PhoneNo; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(50002; FS_RF_ServiceRequestFlag; Boolean)
        {
            Caption = 'Service Request Flag';
            DataClassification = CustomerContent;
        }
        // Field IDs 50003-50022 are occupied on the Sales Header table. This must be at the next available ID otherwise it breaks any .TransferFields() call
        field(50023; FS_RF_ContractorUnitCost; Decimal)
        {
            Caption = 'Contractor Unit Cost';
            DataClassification = EndUserIdentifiableInformation;
        }
    }
}
