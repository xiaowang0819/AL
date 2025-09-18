// reportextension 78001 "DeliveryDocket" extends FSG_GLD_OrderConfirmation
// {
//     dataset
//     {
//         add("Sales Header")
//         {
//             column(JW_WarehouseInstr; "FSG_GLD_WarehouseInstructions") { }
//             column(JW_DeliveryInstr; "FSG_GLD_DeliveryInstructions") { }
//         }

//     }

//     requestpage
//     {

//     }
//     rendering
//     {
//         layout(JW_Word)
//         {
//             Type = Word;
//             LayoutFile = './Layouts/JW_DeliverDocket.docx';
//         }
//     }
// }
