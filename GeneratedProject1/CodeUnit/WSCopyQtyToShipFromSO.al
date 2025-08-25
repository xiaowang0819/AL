// codeunit 77280 "WS Copy QtyToShip From SO"
// {
//     Subtype = Normal;

//     // need to 
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document",
//         'OnBeforeSetQtysOnShptLine', '', false, false)]
//     local procedure OnBeforeSetQtysOnShptLine(
//         var WarehouseShipmentLine: Record "Warehouse Shipment Line";
//         var Qty: Decimal; var QtyBase: Decimal; var IsHandled: Boolean)
//     var
//         SalesLine: Record "Sales Line";
//     begin
//         // 仅处理来源为销售订单
//         if WarehouseShipmentLine."Source Type" <> Database::"Sales Line" then
//             exit;
//         if WarehouseShipmentLine."Source Document" <>
//            "Warehouse Activity Source Document"::"Sales Order" then
//             exit;

//         if not SalesLine.Get(SalesLine."Document Type"::Order,
//                              WarehouseShipmentLine."Source No.",
//                              WarehouseShipmentLine."Source Line No.") then
//             exit;

//         if SalesLine."Qty. to Ship" <= 0 then
//             exit;

//         Qty := SalesLine."Qty. to Ship";
//         QtyBase := SalesLine."Qty. to Ship (Base)";
//         IsHandled := true; // 拦截标准数量设置
//     end;

//     // 兜底：行已插入后再校正（万一上面的事件在你版本里未触发）
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document",
//         'OnAfterWhseShptLineInsert', '', false, false)]
//     local procedure OnAfterWhseShptLineInsert(var WarehouseShipmentLine: Record "Warehouse Shipment Line")
//     var
//         SalesLine: Record "Sales Line";
//     begin
//         if WarehouseShipmentLine."Source Type" <> Database::"Sales Line" then
//             exit;
//         if WarehouseShipmentLine."Source Document" <>
//            "Warehouse Activity Source Document"::"Sales Order" then
//             exit;

//         if not SalesLine.Get(SalesLine."Document Type"::Order,
//                              WarehouseShipmentLine."Source No.",
//                              WarehouseShipmentLine."Source Line No.") then
//             exit;

//         if SalesLine."Qty. to Ship" <= 0 then
//             exit;

//         WarehouseShipmentLine.Validate(Quantity, SalesLine."Qty. to Ship");
//         WarehouseShipmentLine.Validate("Qty. to Ship", SalesLine."Qty. to Ship");
//         WarehouseShipmentLine.Modify(true);
//     end;
// }
