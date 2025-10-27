table 50100 "Pre Inventary HH"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Item No"; Code[30])
        {
            Caption = 'Item No';
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Quantity Scan"; Decimal)
        {
            Caption = 'Quantity Scan';
        }
        field(5; "Cod. Location"; Code[30])
        {
            Caption = 'Cod. Location';
        }
        field(6; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
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
        field(11; "No. Lot Found"; Boolean)
        {
            Caption = 'No. Lot Found';
        }
        field(12; "Qty Calculated NAV"; Decimal)
        {
            Caption = 'Qty Calculated NAV';
        }
        field(13; "Entry No. Pre-Inventory"; Integer)
        {
            Caption = 'Entry No. Pre-Inventory';
        }
        field(14; "No. Lot"; Code[30])
        {
            Caption = 'No. Lot';
        }
        field(15; "Label No."; Integer)
        {
            Caption = 'Label No.';
        }
        field(16; "Inventory Code"; Code[50])
        {
            Caption = 'Inventory Code';
        }
        field(17; "Label Status"; Option)
        {
            Caption = 'Label Status';
            OptionMembers = HH;
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}