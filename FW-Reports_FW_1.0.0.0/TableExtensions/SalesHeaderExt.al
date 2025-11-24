tableextension 78204 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(78204; "Opportunity"; Option)
        {
            Caption = 'Opportunity';
            OptionMembers = " ",Hot,Medium;
            OptionCaption = ' ,Hot,Medium';
            DataClassification = ToBeClassified;
            InitValue = " ";
        }
    }
}