codeunit 50109 "WS Movs Almacen"
{
    //TableNo = 0;

    procedure SendToJournalInventary(InventoryScan: Record "Inventory Scan"; ItemNo: Code[30]; PostingDate: Date; NextDocNo: Code[30]; InventoryCode: Code[30])
    var
        InventaryScan: Record "Inventory Scan";
        ItemJournalLine: Record "Item Journal Line";
        TmpLedgerEntryTrackingLotNo: Record TmpLedgerEntryTrackingLotNo;
        ManufacturingSetup: Record "Manufacturing Setup";
        AjustPos: Boolean;
        AjustPos1: Boolean;
        AjustNeg: Boolean;
        QtyNAVAjsPos: Decimal;
        QtyNAVAjsPos1: Decimal;
        QtyNAVAjsNeg: Decimal;
        QtyAjstPos: Decimal;
        QtyAjstPos1: Decimal;
        QtyAjstNeg: Decimal;
        ProgressDialog: Dialog;
    begin
        ManufacturingSetup.Get();

        InventaryScan.Reset();
        InventaryScan.SetRange("Item No", ItemNo);
        InventaryScan.SetRange("Inventory Code", InventoryCode);
        InventaryScan.SetFilter("Reg. Sended", '=%1', false);
        InventaryScan.SetFilter("Cod. Location", '<>%1', '100');

        if InventaryScan.FindSet() then begin
            ProgressDialog.Open('Procesando: #1########################');
            repeat
                InventaryScan.TestField("Cod. Location");
                InventaryScan.TestField("Bin Code");

                AjustPos := false;
                AjustNeg := false;
                AjustPos1 := false;
                QtyAjstPos := 0;
                QtyAjstNeg := 0;
                QtyNAVAjsPos := 0;
                QtyNAVAjsNeg := 0;
                QtyAjstPos1 := 0;
                QtyNAVAjsPos1 := 0;

                ProgressDialog.Update(1, InventaryScan."Item No");

                TmpLedgerEntryTrackingLotNo.Reset();
                TmpLedgerEntryTrackingLotNo.SetRange("Entry No. Pre-Inventory", InventaryScan."Entry No");
                if TmpLedgerEntryTrackingLotNo.FindSet() then
                    repeat
                        if TmpLedgerEntryTrackingLotNo."Calculated Quantity" > TmpLedgerEntryTrackingLotNo."Qty Physical" then begin
                            QtyAjstNeg += TmpLedgerEntryTrackingLotNo."Qty Physical";
                            QtyNAVAjsNeg += TmpLedgerEntryTrackingLotNo."Calculated Quantity";
                            AjustNeg := true;
                        end;

                        if TmpLedgerEntryTrackingLotNo."Calculated Quantity" < TmpLedgerEntryTrackingLotNo."Qty Physical" then begin
                            QtyAjstPos += TmpLedgerEntryTrackingLotNo."Qty Physical";
                            QtyNAVAjsPos += TmpLedgerEntryTrackingLotNo."Calculated Quantity";
                            AjustPos := true;
                        end;

                        if TmpLedgerEntryTrackingLotNo."Calculated Quantity" = TmpLedgerEntryTrackingLotNo."Qty Physical" then begin
                            QtyAjstPos1 += TmpLedgerEntryTrackingLotNo."Qty Physical";
                            QtyNAVAjsPos1 += TmpLedgerEntryTrackingLotNo."Calculated Quantity";
                            AjustPos1 := true;
                        end;
                    until TmpLedgerEntryTrackingLotNo.Next() = 0;

                // Cantidades iguales
                if AjustPos1 then
                    DiarioInventarios(PostingDate, NextDocNo, InventaryScan."Item No", InventaryScan."Cod. Location", InventaryScan."Bin Code", QtyNAVAjsPos1, QtyAjstPos1, ItemJournalLine);

                // Ajuste positivo
                if AjustPos then begin
                    DiarioInventarios(PostingDate, NextDocNo, InventaryScan."Item No", InventaryScan."Cod. Location", InventaryScan."Bin Code", QtyNAVAjsPos, QtyAjstPos, ItemJournalLine);
                    InsertLotPosJrnalInv(InventaryScan, ItemJournalLine);
                end;

                // Ajuste negativo
                if AjustNeg then begin
                    DiarioInventarios(PostingDate, NextDocNo, InventaryScan."Item No", InventaryScan."Cod. Location", InventaryScan."Bin Code", QtyNAVAjsNeg, QtyAjstNeg, ItemJournalLine);
                    InsertLotNegJrnalInv(InventaryScan, ItemJournalLine);
                end;

                InventaryScan."Reg. Sended" := true;
                InventaryScan.Modify();

                UpdateStatusLabelInventory(InventaryScan);

                if ManufacturingSetup."Delete Reg InventaryPhys" then
                    DeleteRegPreInventary(InventaryScan);

            until InventaryScan.Next() = 0;

            if ManufacturingSetup."Delete Reg InventaryPhys" then
                DeleteRegNoSendtoJornal();

            ProgressDialog.Close();
            Message('¡Envío completado!');
        end else
            Message('No hay registros pendientes por enviar.');
    end;

    procedure DiarioInventarios(PostingDate: Date; NextDocNo: Code[30]; NoPrd: Code[30]; CodAlm: Code[30]; CodUbic: Code[30]; PhysInvQuantity: Decimal; Qty1: Decimal; var TrnItemJournalLine: Record "Item Journal Line"): Boolean
    var
        ManufacturingSetup: Record "Manufacturing Setup";
        SourceCodeSetup: Record "Source Code Setup";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemJournalLine: Record "Item Journal Line";
        LastLine: Integer;
        Libro: Code[50];
        Seccion: Code[50];
        Qty: Decimal;
    begin
        SourceCodeSetup.Get();
        ManufacturingSetup.Get();
        ManufacturingSetup.TestField("Journal Template Name Stock");
        ManufacturingSetup.TestField("Journal Batch Name Stock");

        Libro := ManufacturingSetup."Journal Template Name Stock";
        Seccion := ManufacturingSetup."Journal Batch Name Stock";
        Qty := Qty1;

        ItemJnlTemplate.Get(Libro);
        ItemJnlBatch.Get(Libro, Seccion);

        ItemJournalLine.Reset();
        ItemJournalLine.SetRange("Journal Template Name", Libro);
        ItemJournalLine.SetRange("Journal Batch Name", Seccion);
        if ItemJournalLine.FindLast() then
            LastLine := ItemJournalLine."Line No." + 10000
        else
            LastLine := 10000;

        ItemJournalLine.Init();
        ItemJournalLine.Validate("Journal Template Name", Libro);
        ItemJournalLine.Validate("Journal Batch Name", Seccion);
        ItemJournalLine."Line No." := LastLine;
        ItemJournalLine.Validate("Posting Date", PostingDate);
        if PhysInvQuantity >= Qty then
            ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.")
        else
            ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");

        ItemJournalLine.Validate("Document No.", NextDocNo);
        ItemJournalLine.Validate("Item No.", NoPrd);
        ItemJournalLine.Validate("Location Code", CodAlm);
        ItemJournalLine.Validate("Bin Code", CodUbic);
        ItemJournalLine.Validate("Source Code", SourceCodeSetup."Phys. Inventory Journal");
        ItemJournalLine."Qty. (Phys. Inventory)" := Qty;
        ItemJournalLine."Phys. Inventory" := true;
        ItemJournalLine.Validate("Qty. (Calculated)", PhysInvQuantity);
        ItemJournalLine."Posting No. Series" := ItemJnlBatch."Posting No. Series";
        ItemJournalLine."Reason Code" := ItemJnlBatch."Reason Code";

        ItemLedgEntry.Reset();
        ItemLedgEntry.SetCurrentKey("Item No.");
        ItemLedgEntry.SetRange("Item No.", NoPrd);
        if ItemLedgEntry.FindLast() then
            ItemJournalLine."Last Item Ledger Entry No." := ItemLedgEntry."Entry No."
        else
            ItemJournalLine."Last Item Ledger Entry No." := 0;

        if ItemJournalLine.Insert(true) then begin
            TrnItemJournalLine := ItemJournalLine;
            exit(true);
        end;
    end;

    local procedure UpdateStatusLabelInventory(PreScannedInventory: Record "Inventory Scan")
    var
        LabelLedgerEntry: Record "Label Ledger Entry";
        LotRelationed: Record TmpLedgerEntryTrackingLotNo;
        LabelLedgerEntry2: Record "Label Ledger Entry";
        ManufacturingSetup: Record "Manufacturing Setup";
        LibroInvFis: Code[50];
        SeccionInvFis: Code[50];
        PreStatus: Integer;
    begin
        ManufacturingSetup.Get();
        ManufacturingSetup.TestField("Journal Template Name Stock");
        ManufacturingSetup.TestField("Journal Batch Name Stock");
        LibroInvFis := ManufacturingSetup."Journal Template Name Stock";
        SeccionInvFis := ManufacturingSetup."Journal Batch Name Stock";

        // Limpia asignados previos
        LabelLedgerEntry2.Reset();
        LabelLedgerEntry2.SetRange("Journal Batch Name", SeccionInvFis);
        LabelLedgerEntry2.SetRange("Journal Template Name", LibroInvFis);
        if LabelLedgerEntry2.FindSet() then
            repeat
                LabelLedgerEntry2."Journal Batch Name" := '';
                LabelLedgerEntry2."Journal Template Name" := '';
                LabelLedgerEntry2.Modify();
            until LabelLedgerEntry2.Next() = 0;

        LotRelationed.Reset();
        LotRelationed.SetRange("Inventory Code", PreScannedInventory."Inventory Code");
        LotRelationed.SetRange("Item No.", PreScannedInventory."Item No");
        LotRelationed.SetRange("Location Code", PreScannedInventory."Cod. Location");
        LotRelationed.SetRange("Bin Code", PreScannedInventory."Bin Code");

        if LotRelationed.FindSet() then
            repeat
                if LotRelationed."Calculated Quantity" <= LotRelationed."Qty Physical" then
                    PreStatus := 1
                else
                    PreStatus := 0;

                LabelLedgerEntry.Reset();
                LabelLedgerEntry.SetCurrentKey("Source No.", "Lot No.");
                LabelLedgerEntry.SetRange("Source No.", LotRelationed."Item No.");
                LabelLedgerEntry.SetRange("Lot No.", LotRelationed."Lot No.");

                if LabelLedgerEntry.FindSet() then
                    repeat
                        case PreStatus of
                            1:
                                begin
                                    LabelLedgerEntry."Pre-Label Status" := LabelLedgerEntry."Pre-Label Status"::Almacen;
                                    LabelLedgerEntry."Pre Remaining Quantity" := LabelLedgerEntry."Pre Remaining Quantity";
                                end;
                            0:
                                begin
                                    LabelLedgerEntry."Pre-Label Status" := LabelLedgerEntry."Pre-Label Status"::Terminada;
                                    LabelLedgerEntry."Pre Remaining Quantity" := 0;
                                end;
                        end;

                        LabelLedgerEntry."Journal Template Name" := LibroInvFis;
                        LabelLedgerEntry."Journal Batch Name" := SeccionInvFis;
                        LabelLedgerEntry.Modify();
                    until LabelLedgerEntry.Next() = 0;
            until LotRelationed.Next() = 0;
    end;

    local procedure InsertLotPosJrnalInv(InventaryScan: Record "Inventory Scan"; ItemJournalLine: Record "Item Journal Line")
    var
        LedgerEntryTrackingLotNo: Record TmpLedgerEntryTrackingLotNo;
        LabelLedgerEntry: Record "Label Ledger Entry";
        QtySuperior: Decimal;
    begin
        // Procesar lotes con cantidad física superior a la calculada
        LedgerEntryTrackingLotNo.Reset();
        LedgerEntryTrackingLotNo.SetRange("Entry No. Pre-Inventory", InventaryScan."Entry No");
        LedgerEntryTrackingLotNo.SetFilter("Sent to Journal Inventary", '=%1', false);
        LedgerEntryTrackingLotNo.SetFilter("Qty Physical", '<>%1', 0);

        if LedgerEntryTrackingLotNo.FindSet() then
            repeat
                QtySuperior := 0;

                if LedgerEntryTrackingLotNo."Calculated Quantity" < LedgerEntryTrackingLotNo."Qty Physical" then begin
                    QtySuperior := (LedgerEntryTrackingLotNo."Qty Physical" - LedgerEntryTrackingLotNo."Calculated Quantity") * -1;
                    AssignLotJrnalInventaryPhys(ItemJournalLine, LedgerEntryTrackingLotNo."Lot No.", QtySuperior);
                    CtrlTracking_LotNo_Label(ItemJournalLine, LedgerEntryTrackingLotNo);
                end;
            until LedgerEntryTrackingLotNo.Next() = 0;
    end;

    local procedure InsertLotNegJrnalInv(InventaryScan: Record "Inventory Scan"; ItemJournalLine: Record "Item Journal Line")
    var
        LedgerEntryTrackingLotNo: Record TmpLedgerEntryTrackingLotNo;
        LabelLedgerEntry: Record "Label Ledger Entry";
    begin
        // Procesar lotes no encontrados físicamente (ajustes negativos)
        LedgerEntryTrackingLotNo.Reset();
        LedgerEntryTrackingLotNo.SetRange("Entry No. Pre-Inventory", InventaryScan."Entry No");
        LedgerEntryTrackingLotNo.SetFilter("Sent to Journal Inventary", '=%1', false);
        LedgerEntryTrackingLotNo.SetFilter("Qty Physical", '=%1', 0);
        LedgerEntryTrackingLotNo.SetFilter("Calculated Quantity", '<>%1', 0);

        if LedgerEntryTrackingLotNo.FindSet() then
            repeat
                AssignLotJrnalInventaryPhys(ItemJournalLine, LedgerEntryTrackingLotNo."Lot No.", LedgerEntryTrackingLotNo."Calculated Quantity");
                CtrlTracking_LotNo_Label(ItemJournalLine, LedgerEntryTrackingLotNo);
            until LedgerEntryTrackingLotNo.Next() = 0;
    end;

    local procedure DeleteRegPreInventary(InventaryScan: Record "Inventory Scan")
    var
        InventaryScan2: Record "Inventory Scan";
        EntryTrackingLotNo: Record "TmpLedgerEntryTrackingLotNo";
        PreInventaryHH: Record "Pre Inventary HH";
    begin
        if InventaryScan2.Get(InventaryScan."Entry No") then
            InventaryScan2.Delete();

        PreInventaryHH.Reset();
        PreInventaryHH.SetRange("Entry No. Pre-Inventory", InventaryScan."Entry No");
        if PreInventaryHH.FindSet() then
            repeat
                PreInventaryHH.Delete();
            until PreInventaryHH.Next() = 0;

        EntryTrackingLotNo.Reset();
        EntryTrackingLotNo.SetRange("Entry No. Pre-Inventory", InventaryScan."Entry No");
        if EntryTrackingLotNo.FindSet() then
            repeat
                EntryTrackingLotNo.Delete();
            until EntryTrackingLotNo.Next() = 0;
    end;

    procedure GetProdOrder(): Text[1024]
    var
        ProductionOrder: Record "Production Order";
        RtnOP: Text[1024];
    begin
        Clear(RtnOP);
        ProductionOrder.Reset();
        ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);

        if ProductionOrder.FindSet() then
            repeat
                RtnOP += ProductionOrder."No." + '|';
            until ProductionOrder.Next() = 0;

        exit(RtnOP);
    end;

    local procedure DeleteRegNoSendtoJornal()
    var
        InventaryScan3: Record "Inventory Scan";
        LedgerEntryTrackingLotNo5: Record TmpLedgerEntryTrackingLotNo;
    begin
        InventaryScan3.DeleteAll();
        LedgerEntryTrackingLotNo5.DeleteAll();
    end;
}
