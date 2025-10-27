table 50166 "Inventory Scan"
{
    Caption = 'Inventory Scan';
    DataClassification = ToBeClassified;
    TableType = Normal;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Item No"; Code[30])
        {
            Caption = 'Item No';
            TableRelation = Item."No.";
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Quantity Scan"; Decimal)
        {
            Caption = 'Quantity Scan';
        }
        field(5; "Cod. Location"; Code[20])
        {
            Caption = 'Cod. Location';
            TableRelation = Location.Code;
        }
        field(6; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Cod. Location"));
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(8; "User ID"; Code[100])
        {
            Caption = 'User ID';
        }
        field(9; "Reg. Sended"; Boolean)
        {
            Caption = 'Reg. Sended';
        }
        field(10; "Physical Location"; Code[30])
        {
            Caption = 'Physical Location';
        }
        field(11; "Entry Related"; Boolean)
        {
            Caption = 'Entry Related';
        }
        field(12; "Qty Calculated NAV"; Decimal)
        {
            Caption = 'Qty Calculated NAV';
        }
        field(13; "Lot Related"; Boolean)
        {
            Caption = 'Lot Related';
        }
        field(14; "Re-Calculate"; Boolean)
        {
            Caption = 'Re-Calculate';
        }
        field(15; "Cod. Location New"; Code[30])
        {
            Caption = 'Cod. Location New';
        }
        field(16; "Bin Code New"; Code[20])
        {
            Caption = 'Bin Code New';
        }
        field(17; Ajust; Boolean)
        {
            Caption = 'Ajust';
        }
        field(18; "Quantity Scan Calc"; Decimal)
        {
            Caption = 'Quantity Scan Calc';
        }
        field(19; "Qty Calculated NAV Calc"; Decimal)
        {
            Caption = 'Qty Calculated NAV Calc';
        }
        field(20; "DateTime Capture"; DateTime)
        {
            Caption = 'DateTime Capture';
        }
        field(21; "Inventory Code"; Code[50])
        {
            Caption = 'Inventory Code';
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
        key(Item; "Item No", "Inventory Code") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Item No", Description, "Cod. Location", "Quantity Scan", "Inventory Code") { }
    }
}
