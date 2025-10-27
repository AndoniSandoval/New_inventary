page 50104 "Scanned Inventory"
{
    Caption = 'Pre-Inventario Escaneado';
    PageType = List;
    SourceTable = "Inventory Scan";
    UsageCategory = Lists;
    ApplicationArea = All;
    InsertAllowed = false;

    // layout
    // {
    //     area(content)
    //     {
    //         repeater(Group)
    //         {
    //             field("Entry No"; "Entry No")
    //             {
    //                 ApplicationArea = All;
    //                 Editable = false;
    //             }
    //             field("Inventory Code"; "Inventory Code")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field("Item No"; "Item No")
    //             {
    //                 ApplicationArea = All;
    //                 Editable = false;
    //             }
    //             field(Description; Description)
    //             {
    //                 ApplicationArea = All;
    //                 Editable = false;
    //             }
    //             field("Cod. Location"; "Cod. Location")
    //             {
    //                 ApplicationArea = All;
    //                 Editable = false;
    //             }
    //             field("Bin Code"; "Bin Code")
    //             {
    //                 ApplicationArea = All;
    //                 Editable = false;
    //             }
    //             field("Qty Calculated NAV"; "Qty Calculated NAV")
    //             {
    //                 ApplicationArea = All;
    //                 Editable = false;
    //             }
    //             field("Quantity Scan"; "Quantity Scan")
    //             {
    //                 ApplicationArea = All;
    //                 Editable = false;
    //             }
    //             field("Entry Related"; "Entry Related")
    //             {
    //                 ApplicationArea = All;
    //                 Editable = false;
    //             }
    //             field("Lot Related"; "Lot Related")
    //             {
    //                 ApplicationArea = All;
    //                 Editable = false;
    //             }
    //             field("Reg. Sended"; "Reg. Sended")
    //             {
    //                 ApplicationArea = All;
    //                 Editable = true;
    //             }
    //         }
    //     }
    // }

    actions
    {
        area(Processing)
        {
            group("Diario de Inventarios")
            {
                Image = Journals;

                action("Enviar a Diario Inventarios")
                {
                    Caption = 'Enviar a Diario Inventarios';
                    Image = SendTo;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        WSMovsAlmacen: Codeunit 50109;
                    begin
                        if Confirm('¿Desea enviar los datos pendientes?', false) then
                            WSMovsAlmacen.SendToJournalInventary(Rec, Rec."Item No", Today(), Rec."Inventory Code", Rec."Bin Code");
                    end;
                }

                action("Diario Inventario")
                {
                    Caption = 'Diario Inventario';
                    Image = InventoryJournal;
                    ApplicationArea = All;
                    RunObject = Page "Item Journal";
                }

                action("Recalcular Inv. Sistema")
                {
                    Caption = 'Recalcular Inv. Sistema';
                    Image = Calculate;
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    var
                        WSMovsAlmacen: Codeunit 50109;
                    begin
                        WSMovsAlmacen.GetProdOrder();
                    end;
                }
            }
        }
    }

    var
        WSMovsAlmacen: Codeunit 50109;
}
