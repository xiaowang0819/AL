xmlport 50000 FS_RF_ImportGenJournal
{
    Format = VariableText;
    Direction = Import;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line";
            "Gen. Journal Line")
            {
                XmlName = 'GenJournalLine';

                fieldelement(GeneralTemplateName; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(JournalBatchName; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(LineNo; "Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(AccountType; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(AccountNo; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(Description; "Gen. Journal Line".Description)
                {
                }
                fieldelement(PostingDate; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(DocumentDate; "Gen. Journal Line"."Document Date")
                {
                }
                fieldelement(DocumentNo; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(SourceCode; "Gen. Journal Line"."Source Code")
                {
                }
                fieldelement(Amount; "Gen. Journal Line".Amount)
                {
                }
                textelement(Dim1)
                {
                    MinOccurs = Zero;
                }
                textelement(Dim2)
                {
                    MinOccurs = Zero;
                }
                textelement(Dim3)
                {
                    MinOccurs = Zero;
                }
                textelement(Dim4)
                {
                    MinOccurs = Zero;
                }
                textelement(Dim5)
                {
                    MinOccurs = Zero;
                }
                textelement(Dim6)
                {
                    MinOccurs = Zero;
                }
                textelement(Dim7)
                {
                    MinOccurs = Zero;
                }
                textelement(Dim8)
                {
                    MinOccurs = Zero;
                }
                trigger OnAfterInitRecord()
                begin
                    Dim1 := '';
                    Dim2 := '';
                    Dim3 := '';
                    Dim4 := '';
                    Dim5 := '';
                    Dim6 := '';
                    Dim7 := '';
                    Dim8 := '';
                end;

                trigger OnBeforeInsertRecord()
                var
                    TempDimSetEntry: Record "Dimension Set Entry" temporary;
                    GenLedgerSetup: Record "General Ledger Setup";
                    DimValue: Record "Dimension Value";
                    DimMgmt: Codeunit DimensionManagement;
                begin
                    GenLedgerSetup.Get();
                    TempDimSetEntry.DeleteAll();
                    if (GenLedgerSetup."Shortcut Dimension 1 Code" <> '') and (Dim1 <> '') then begin
                        DimValue.Get(GenLedgerSetup."Shortcut Dimension 1 Code", Dim1);
                        TempDimSetEntry.Init();
                        TempDimSetEntry."Dimension Code" := GenLedgerSetup."Shortcut Dimension 1 Code";
                        TempDimSetEntry."Dimension Value Code" := Dim1;
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        TempDimSetEntry.Insert();
                        "Gen. Journal Line".Validate("Shortcut Dimension 1 Code", Dim1);
                    end;
                    if (GenLedgerSetup."Shortcut Dimension 2 Code" <> '') and (Dim2 <> '') then begin
                        DimValue.Get(GenLedgerSetup."Shortcut Dimension 2 Code", Dim2);
                        TempDimSetEntry.Init();
                        TempDimSetEntry."Dimension Code" := GenLedgerSetup."Shortcut Dimension 2 Code";
                        TempDimSetEntry."Dimension Value Code" := Dim2;
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        TempDimSetEntry.Insert();
                        "Gen. Journal Line".Validate("Shortcut Dimension 2 Code", Dim2);
                    end;
                    if (GenLedgerSetup."Shortcut Dimension 3 Code" <> '') and (Dim3 <> '') then begin
                        DimValue.Get(GenLedgerSetup."Shortcut Dimension 3 Code", Dim3);
                        TempDimSetEntry.Init();
                        TempDimSetEntry."Dimension Code" := GenLedgerSetup."Shortcut Dimension 3 Code";
                        TempDimSetEntry."Dimension Value Code" := Dim3;
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        TempDimSetEntry.Insert();
                    end;
                    if (GenLedgerSetup."Shortcut Dimension 4 Code" <> '') and (Dim4 <> '') then begin
                        DimValue.Get(GenLedgerSetup."Shortcut Dimension 4 Code", Dim4);
                        TempDimSetEntry.Init();
                        TempDimSetEntry."Dimension Code" := GenLedgerSetup."Shortcut Dimension 4 Code";
                        TempDimSetEntry."Dimension Value Code" := Dim4;
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        TempDimSetEntry.Insert();
                    end;
                    if (GenLedgerSetup."Shortcut Dimension 5 Code" <> '') and (Dim5 <> '') then begin
                        DimValue.Get(GenLedgerSetup."Shortcut Dimension 5 Code", Dim5);
                        TempDimSetEntry.Init();
                        TempDimSetEntry."Dimension Code" := GenLedgerSetup."Shortcut Dimension 5 Code";
                        TempDimSetEntry."Dimension Value Code" := Dim5;
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        TempDimSetEntry.Insert();
                    end;
                    if (GenLedgerSetup."Shortcut Dimension 6 Code" <> '') and (Dim6 <> '') then begin
                        DimValue.Get(GenLedgerSetup."Shortcut Dimension 6 Code", Dim6);
                        TempDimSetEntry.Init();
                        TempDimSetEntry."Dimension Code" := GenLedgerSetup."Shortcut Dimension 6 Code";
                        TempDimSetEntry."Dimension Value Code" := Dim6;
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        TempDimSetEntry.Insert();
                    end;
                    if (GenLedgerSetup."Shortcut Dimension 7 Code" <> '') and (Dim7 <> '') then begin
                        DimValue.Get(GenLedgerSetup."Shortcut Dimension 7 Code", Dim7);
                        TempDimSetEntry.Init();
                        TempDimSetEntry."Dimension Code" := GenLedgerSetup."Shortcut Dimension 7 Code";
                        TempDimSetEntry."Dimension Value Code" := Dim7;
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        TempDimSetEntry.Insert();
                    end;
                    if (GenLedgerSetup."Shortcut Dimension 8 Code" <> '') and (Dim8 <> '') then begin
                        DimValue.Get(GenLedgerSetup."Shortcut Dimension 8 Code", Dim8);
                        TempDimSetEntry.Init();
                        TempDimSetEntry."Dimension Code" := GenLedgerSetup."Shortcut Dimension 8 Code";
                        TempDimSetEntry."Dimension Value Code" := Dim8;
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        TempDimSetEntry.Insert();
                    end;
                    if TempDimSetEntry.Count > 0 then begin
                        "Gen. Journal Line".Validate("Dimension Set ID", DimMgmt.GetDimensionSetID(TempDimSetEntry));
                    end;
                end;
            }
        }
    }
}
