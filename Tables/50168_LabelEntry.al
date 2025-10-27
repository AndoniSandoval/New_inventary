table 50168 "Label Ledger Entry"
{
    Caption = 'Label Ledger Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(2; "Label Type"; Option)
        {
            Caption = 'Label Type';
            OptionMembers = " ","Type1","Type2","Type3"; // Ajusta según los valores reales
        }

        field(3; "Label No."; Code[40])
        {
            Caption = 'Label No.';
        }

        field(4; "Source Table"; Text[30])
        {
            Caption = 'Source Table';
        }

        field(5; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionMembers = " ","Creation","Reprint","Adjustment"; // Ejemplo genérico
        }

        field(6; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }

        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }

        field(8; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionMembers = " ","Item","Production Order","Transfer","Purchase"; // Ajusta si aplica
        }

        field(9; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = " ","Order","Receipt","Shipment"; // Ejemplo, depende del origen
        }

        field(10; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }

        field(11; "Sub Type Label"; Option)
        {
            Caption = 'Sub Type Label';
            OptionMembers = " ","Primary","Secondary"; // Ajusta si aplica
        }

        field(12; "Pallet Number"; Integer)
        {
            Caption = 'Pallet Number';
        }

        field(13; "DUNS Code"; Code[10])
        {
            Caption = 'DUNS Code';
        }

        field(14; "Print Copies"; Integer)
        {
            Caption = 'Print Copies';
        }

        field(15; "Type Container"; Text[2])
        {
            Caption = 'Type Container';
        }

        field(16; "Box Number"; Integer)
        {
            Caption = 'Box Number';
        }

        field(17; "Year"; Integer)
        {
            Caption = 'Year';
        }

        field(18; "Week Number"; Integer)
        {
            Caption = 'Week Number';
        }

        field(19; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }

        field(20; "Labels to Print"; Integer)
        {
            Caption = 'Labels to Print';
        }

        field(21; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }

        field(22; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(23; "Document Origin"; Code[20])
        {
            Caption = 'Document Origin';
        }

        field(24; "Line No. Origin"; Integer)
        {
            Caption = 'Line No. Origin';
        }

        field(25; "Entry No. Origin"; Integer)
        {
            Caption = 'Entry No. Origin';
        }

        field(26; "Label Production Type"; Option)
        {
            Caption = 'Label Production Type';
            OptionMembers = " ","Internal","External"; // Ajusta según necesidad
        }

        field(27; "Serial Code"; Code[10])
        {
            Caption = 'Serial Code';
        }

        field(28; "No. Mov. Serial"; Integer)
        {
            Caption = 'No. Mov. Serial';
        }

        field(29; "Turn Code"; Code[10])
        {
            Caption = 'Turn Code';
        }

        field(30; "Number Serie GA"; Code[10])
        {
            Caption = 'Number Serie GA';
        }

        field(31; "Number Serie HBPO"; Code[10])
        {
            Caption = 'Number Serie HBPO';
        }

        field(32; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
        }

        field(33; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
        }
        field(34; "Source Code Vendor"; Code[20]) { Caption = 'Source Code Vendor'; }
        field(35; "Source Code Cust"; Code[20]) { Caption = 'Source Code Cust'; }
        field(36; "Gross Weight"; Decimal) { Caption = 'Gross Weight'; }
        field(37; "Net Weight"; Decimal) { Caption = 'Net Weight'; }
        field(38; "Comentarios"; Text[50]) { Caption = 'Comentarios'; }
        field(39; "Serie Label ASN"; Code[40]) { Caption = 'Serie Label ASN'; }
        field(40; "Qty Total Master"; Decimal) { Caption = 'Qty Total Master'; }
        field(41; "Persona Quien Recibe"; Text[50]) { Caption = 'Persona Quien Recibe'; }
        field(42; "Fecha Registro"; DateTime) { Caption = 'Fecha Registro'; }
        field(43; "User ID"; Code[30]) { Caption = 'User ID'; }
        field(44; "Serie Hella"; Code[10]) { Caption = 'Serie Hella'; }
        field(45; "Cod Serie Hella"; Code[9]) { Caption = 'Cod Serie Hella'; }
        field(46; "CANCELADO"; Boolean) { Caption = 'CANCELADO'; }
        field(47; "Cancelled"; Boolean) { Caption = 'Cancelled'; }
        field(48; "Original Quantity"; Decimal) { Caption = 'Original Quantity'; }
        field(49; "Pedido Venta Abierto"; Code[30]) { Caption = 'Pedido Venta Abierto'; }
        field(50; "BlanketOrder"; Code[30]) { Caption = 'BlanketOrder'; }
        field(51; "Control Seguridad"; Boolean) { Caption = 'Control Seguridad'; }
        field(52; "Qty Container"; Integer) { Caption = 'Qty Container'; }
        field(53; "Description Container"; Code[30]) { Caption = 'Description Container'; }
        field(54; "Qty per Container"; Decimal) { Caption = 'Qty per Container'; }
        field(55; "Mark"; Boolean) { Caption = 'Mark'; }
        field(56; "Mark Process"; Boolean) { Caption = 'Mark Process'; }
        field(57; "ASN No. Generado"; Code[30]) { Caption = 'ASN No. Generado'; }
        field(58; "ASN Linea Generado"; Integer) { Caption = 'ASN Linea Generado'; }
        field(59; "MarkHella"; Boolean) { Caption = 'MarkHella'; }
        field(60; "Serie VW"; Integer) { Caption = 'Serie VW'; }
        field(61; "Modified"; Boolean) { Caption = 'Modified'; }
        field(62; "Modified Date"; Date) { Caption = 'Modified Date'; }
        field(63; "Computer Name"; Text[100]) { Caption = 'Computer Name'; }
        field(64; "Label Status"; Option)
        {
            Caption = 'Label Status';
            OptionMembers = " ",Active,Inactive,Reprinted;
        }
        field(65; "Physical Location"; Code[60]) { Caption = 'Physical Location'; }
        field(66; "Remaining Quantity Label"; Decimal) { Caption = 'Remaining Quantity Label'; }
        field(67; "Exits Entry Tracking Label"; Boolean) { Caption = 'Exits Entry Tracking Label'; }
        field(68; "Ctrol Serie GA"; Integer) { Caption = 'Ctrol Serie GA'; }
        field(69; "Ctrol Serie HBPO"; Integer) { Caption = 'Ctrol Serie HBPO'; }
        field(70; "Ctrol Serie GM"; Integer) { Caption = 'Ctrol Serie GM'; }
        field(71; "Inventory"; Boolean) { Caption = 'Inventory'; }
        field(72; "Confirm Control Posting Jrnal"; Code[10]) { Caption = 'Confirm Control Posting Jrnal'; }
        field(73; "Selected Label"; Boolean) { Caption = 'Selected Label'; }
        field(74; "Journal Template Name"; Code[30]) { Caption = 'Journal Template Name'; }
        field(75; "Journal Batch Name"; Code[30]) { Caption = 'Journal Batch Name'; }
        field(76; "Journal Line No."; Integer) { Caption = 'Journal Line No.'; }
        field(77; "Consumption Qty"; Decimal) { Caption = 'Consumption Qty'; }
        field(78; "Audit Shipment"; Boolean) { Caption = 'Audit Shipment'; }
        field(79; "Audit Shipment No"; Code[30]) { Caption = 'Audit Shipment No'; }
        field(80; "Assigned Journal Transfer"; Boolean) { Caption = 'Assigned Journal Transfer'; }
        field(81; "Pre-Label Status"; Option)
        {
            Caption = 'Pre-Label Status';
            OptionMembers = " ",Pending,Validated,Posted;
        }
        field(82; "IDSourcePostin"; Code[30]) { Caption = 'IDSourcePostin'; }
        field(83; "Pre Physical Location"; Code[60]) { Caption = 'Pre Physical Location'; }
        field(84; "Pre Remaining Quantity"; Decimal) { Caption = 'Pre Remaining Quantity'; }
        field(85; "NoHeaderSales"; Code[30]) { Caption = 'NoHeaderSales'; }
        field(86; "Packing Code"; Code[50]) { Caption = 'Packing Code'; }
        field(87; "Quality Control"; Option)
        {
            Caption = 'Quality Control';
            OptionMembers = " ",Approved,Rejected,Rework;
        }
        field(88; "Selected Label Quality"; Boolean) { Caption = 'Selected Label Quality'; }
        field(89; "Remaint Quantity Lot"; Decimal) { Caption = 'Remaint Quantity Lot'; }
        field(90; "Hella-Forvia No"; Code[50]) { Caption = 'Hella-Forvia No'; }
        field(91; "Selected Label Hella-F"; Boolean) { Caption = 'Selected Label Hella-F'; }
        field(92; "Line No. HellaF"; Integer) { Caption = 'Line No. HellaF'; }
        field(93; "Selected Lot Hella - Forb"; Boolean) { Caption = 'Selected Lot Hella - Forb'; }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
