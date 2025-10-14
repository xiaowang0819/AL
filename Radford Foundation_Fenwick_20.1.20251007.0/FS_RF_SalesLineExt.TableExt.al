tableextension 50020 FS_RF_SalesLineExt extends "Sales Line"
{
    fields
    {
        field(50000; FS_RF_FreightPrice; Decimal)
        {
            Caption = 'Freight Price';
            DataClassification = CustomerContent;
        }
        field(50001; FS_RF_ContractorUnitCost; Decimal)
        {
            Caption = 'Contractor Unit Cost';
            DataClassification = EndUserIdentifiableInformation;

            trigger OnValidate()
            var
                CostIncGST: Boolean;
            begin
                if FS_RF_ContractorUnitCost <> xRec.FS_RF_ContractorUnitCost then begin
                    CostIncGST:=FS_RF_ContractorCostAmount = FS_RF_ContractorAmountInclGST;
                    FS_RF_ContractorCostAmount:=FS_RF_ContractorUnitCost * Quantity;
                    if CostIncGST then begin
                        FS_RF_ContractorAmountInclGST:=FS_RF_ContractorCostAmount;
                    end
                    else
                        FS_RF_ContractorAmountInclGST:=FS_RF_ContractorCostAmount * (1 + FS_RF_ContractorGSTPercent / 100);
                end;
            end;
        }
        field(50002; FS_RF_ContractorCostAmount; Decimal)
        {
            Caption = 'Contractor Amount';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50003; FS_RF_ContractorAmountInclGST; Decimal)
        {
            Caption = 'Contractor Amount Including GST';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50004; FS_RF_ContractorGSTPercent; Decimal)
        {
            Caption = 'Contractor GST %';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50005; FS_RF_ExternalDocumentNo; Code[50])
        {
            Caption = 'External Document No.';
            DataClassification = AccountData;
        }
        field(50006; FS_RF_TotalOrderOutstandingQuantity; Decimal)
        {
            Caption = 'Total Order Outstanding Quantity';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Outstanding Quantity" where("Blanket Order No."=field("Document No."), "Blanket Order Line No."=field("Line No.")));
        }
        field(50007; FS_RF_CampaignNo; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Campaign."No.";
        }
        field(50008; FS_RF_OutstandingQty; Decimal)
        {
            Caption = 'Outstanding Qty.';
            DataClassification = CustomerContent;
            DecimalPlaces = 0: 5;
            Editable = false;
        }
        modify(Quantity)
        {
        trigger OnAfterValidate()
        begin
            FS_RF_FreightPrice:=FS_RF_UpdateFreightPrice();
            UpdateOutstandingQtyonBSO();
        end;
        }
        modify("No.")
        {
        trigger OnAfterValidate()
        begin
            FS_RF_FreightPrice:=FS_RF_UpdateFreightPrice();
        end;
        }
    }
    procedure FS_RF_UpdateFreightPrice(): Decimal var
        Item: Record Item;
        Customer: Record Customer;
        ShipToAddr: Record "Ship-to Address";
        SalesHeader: Record "Sales Header";
        FreightZone: Record FS_RF_FreightZone;
        LoadingFactor: Decimal;
        ItemFreightPrice: Decimal;
    begin
        SalesHeader:=GetSalesHeader();
        if Type = Type::Item then begin
            if "No." <> '' then begin
                Item.Get("No.");
                ItemFreightPrice:=Item.FS_RF_FreightPrice;
            end;
            if ShipToAddr.Get(SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code")then begin
                if ShipToAddr.FS_RF_FreightZone <> '' then begin
                    FreightZone.Get(ShipToAddr.FS_RF_FreightZone);
                    LoadingFactor:=FreightZone.FS_RF_LoadingFactor;
                end;
            end
            else
            begin
                if Customer.Get(SalesHeader."Sell-to Customer No.")then begin
                    if Customer.FS_RF_FreightZone <> '' then begin
                        FreightZone.Get(Customer.FS_RF_FreightZone);
                        LoadingFactor:=FreightZone.FS_RF_LoadingFactor;
                    end;
                end;
            end;
            if(LoadingFactor <> 0) and (ItemFreightPrice <> 0)then begin
                exit(Quantity * ItemFreightPrice * LoadingFactor);
            end;
        end;
    end;
    procedure UpdateOutstandingQtyonBSO()
    var
        BlanketSalesLine: Record "Sales Line";
        OrderSalesLine: Record "Sales Line";
        OrderQty: Decimal;
    begin
        if BlanketSalesLine.Get(BlanketSalesLine."Document Type"::"Blanket Order", "Blanket Order No.", "Blanket Order Line No.")then begin
            OrderSalesLine.SetRange("Blanket Order No.", "Blanket Order No.");
            OrderSalesLine.SetRange("Blanket Order Line No.", "Blanket Order Line No.");
            OrderSalesLine.SetFilter("Document No.", '<>%1', Rec."Document No.");
            if OrderSalesLine.FindSet()then begin
                repeat OrderQty+=OrderSalesLine."Quantity (Base)";
                until OrderSalesLine.Next() = 0;
            end;
            OrderQty+=Rec."Quantity (Base)";
            BlanketSalesLine.FS_RF_OutstandingQty:=BlanketSalesLine."Quantity (Base)" - OrderQty;
            BlanketSalesLine.Modify();
        end;
    end;
}
