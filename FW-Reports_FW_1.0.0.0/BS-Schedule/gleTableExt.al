
tableextension 78101 GenLedgerEntryExt extends "G/L Entry"
{
    fields
    {
        field(78101; "Reconcile Ref No."; Code[50])
        {
            Caption = 'Reconcile Ref No.';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Reconcile Entry"."Reconcile Ref No."
                                 where("Entry No." = field("Entry No.")));
        }

        field(78102; "Reconciled"; Boolean)
        {
            Caption = 'Reconciled';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Reconcile Entry".Reconciled
                                 where("Entry No." = field("Entry No.")));
        }
    }
}
permissionset 78102 "GL Reconcile"
{
    Assignable = true;
    Caption = 'G/L Reconcile Entry Permissions';
    Permissions =
        tabledata "G/L Reconcile Entry" = RIMD; // Read, Insert, Modify, Delete
}

permissionsetextension 78103 "D365 Bus Full Access - Reconcile" extends "D365 BUS FULL ACCESS"
{
    Permissions =
        tabledata "G/L Reconcile Entry" = RIMD;
}

table 78102 "G/L Reconcile Entry"
{
    Caption = 'G/L Reconcile Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            TableRelation = "G/L Entry"."Entry No.";
            DataClassification = CustomerContent;
        }

        field(2; "Reconcile Ref No."; Code[50])
        {
            Caption = 'Reconcile Ref No.';
            DataClassification = CustomerContent;
        }

        field(3; "Reconciled"; Boolean)
        {
            Caption = 'Reconciled';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}

pageextension 78005 GenLedgerEntryPageExt extends "General Ledger Entries"
{
    layout
    {
        addfirst(Content)
        {
            field("SelectedTotal"; SelectedTotalAmountText)
            {
                ApplicationArea = All;
                Editable = false;
                ShowCaption = false;
            }
        }
        addafter(Description)
        {
            field("Reconcile Ref No."; Rec."Reconcile Ref No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Is Reconciled"; rec.Reconciled)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(ReconcileAction)
            {
                Caption = 'Reconcile';
                ApplicationArea = All;
                Image = Approve;
                trigger OnAction()
                var
                    Selection: Record "G/L Entry";
                    ReconcilePage: Page "G/L Reconcile Page";
                begin
                    CurrPage.SetSelectionFilter(Selection);
                    if Selection.IsEmpty() then
                        Error('Please select at least one line.');

                    ReconcilePage.SetSelectedRecords(Selection);
                    ReconcilePage.RunModal();
                end;
            }

            action(UnReconcileAction)
            {
                Caption = 'Unreconcile';
                ApplicationArea = All;
                Image = Cancel;
                trigger OnAction()
                var
                    Selection: Record "G/L Entry";
                    ReconcileEntry: Record "G/L Reconcile Entry";
                    TotalAmount: Decimal;
                begin
                    CurrPage.SetSelectionFilter(Selection);
                    if Selection.IsEmpty() then
                        Error('Please select at least one line.');

                    TotalAmount := 0;
                    if Selection.FindSet() then
                        repeat
                            if ReconcileEntry.Get(Selection."Entry No.") then //begin
                                // if ReconcileEntry.Reconciled then
                                    TotalAmount += Selection.Amount
                            else
                                Error('Line %1 is not reconciled and cannot be unreconciled.', Selection."Entry No.");
                        //end;
                        until Selection.Next() = 0;

                    if TotalAmount <> 0 then
                        Error('Total amount of selected reconciled lines must be 0. Current total: %1', TotalAmount);

                    if Selection.FindSet() then
                        repeat
                            if ReconcileEntry.Get(Selection."Entry No.") then
                                ReconcileEntry.Delete();
                        until Selection.Next() = 0;

                    Message('Unreconciled successfully.');
                end;
            }
        }
    }

    var
        SelectedTotalAmount: Decimal;
        SelectedTotalAmountText: Text[50];

    local procedure UpdateSelectionTotal()
    var
        Selection: Record "G/L Entry";
        Total: Decimal;
    begin
        CurrPage.SetSelectionFilter(Selection);
        Total := 0;

        if Selection.FindSet() then
            repeat
                Total += Selection.Amount;
            until Selection.Next() = 0;

        SelectedTotalAmount := Total;
        SelectedTotalAmountText := StrSubstNo('Selected Total: %1', Format(SelectedTotalAmount));

        CurrPage.Update(false);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateSelectionTotal();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateSelectionTotal();
    end;
}


page 78010 "G/L Reconcile Page"
{
    PageType = Card;
    SourceTable = "G/L Entry";
    Caption = 'Reconcile Lines';

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Reference No."; ReferenceNo)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Total Amount"; TotalAmount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DoReconcile)
            {
                Caption = 'Reconcile';
                ApplicationArea = All;
                trigger OnAction()
                var
                    ReconcileEntry: Record "G/L Reconcile Entry";
                    BaseAccountNo: Code[20];
                    FirstLine: Boolean;
                begin

                    ReconcileEntry.Reset();
                    ReconcileEntry.SetRange("Reconcile Ref No.", ReferenceNo);
                    if not ReconcileEntry.IsEmpty then
                        Error('Reference %1 already exists.', ReferenceNo);

                    if TotalAmount <> 0 then
                        Error('Total amount must be 0 for reconciliation. Current total: %1', TotalAmount);

                    FirstLine := true;
                    if TempGLEntries.FindSet() then
                        repeat
                            if FirstLine then begin
                                BaseAccountNo := TempGLEntries."G/L Account No.";
                                FirstLine := false;
                            end else
                                if TempGLEntries."G/L Account No." <> BaseAccountNo then
                                    Error(
                                    'All selected lines must have the same G/L Account No. Found %1 and %2.',
                                    BaseAccountNo, TempGLEntries."G/L Account No.");
                        until TempGLEntries.Next() = 0;

                    if TempGLEntries.FindSet() then
                        repeat
                            if not ReconcileEntry.Get(TempGLEntries."Entry No.") then begin
                                ReconcileEntry.Init();
                                ReconcileEntry."Entry No." := TempGLEntries."Entry No.";
                            end;
                            ReconcileEntry."Reconcile Ref No." := ReferenceNo;
                            ReconcileEntry.Reconciled := true;
                            ReconcileEntry.Insert(true);
                        until TempGLEntries.Next() = 0;

                    Message('Reconciliation completed with reference %1.', ReferenceNo);
                    CurrPage.Update(false);
                end;
            }
        }
    }
    var
        TempGLEntries: Record "G/L Entry" temporary;
        ReferenceNo: Code[20];
        TotalAmount: Decimal;

    procedure SetSelectedRecords(var SelectedEntries: Record "G/L Entry")
    begin
        if SelectedEntries.FindSet() then
            repeat
                TempGLEntries := SelectedEntries;
                TempGLEntries.Insert();
                TotalAmount += SelectedEntries.Amount;
            until SelectedEntries.Next() = 0;
        if ReferenceNo = '' then
            ReferenceNo := Format(CurrentDateTime, 0, '<Year4><Month,2><Day,2><Hours24,2><Minutes,2><Seconds,2>');
        // 示例：20250923154045
    end;
}
