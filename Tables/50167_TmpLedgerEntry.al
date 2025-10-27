table 50167 TmpLedgerEntryTrackingLotNo
{
    Caption = 'Tmp Ledger Entry Tracking Lot No';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(2; "Entry No. Pre-Inventory"; Integer)
        {
            Caption = 'Entry No. Pre-Inventory';
        }

        field(3; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }

        field(4; "Calculated Quantity"; Decimal)
        {
            Caption = 'Calculated Quantity';
        }

        field(5; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
        }

        field(6; "User ID"; Code[30])
        {
            Caption = 'User ID';
        }

        field(7; "Lot Found Physical"; Boolean)
        {
            Caption = 'Lot Found Physical';
        }

        field(8; "Lot Not Found System"; Boolean)
        {
            Caption = 'Lot Not Found System';
        }

        field(9; "Location Code"; Code[30])
        {
            Caption = 'Location Code';
        }

        field(10; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
        }

        field(11; "Item No."; Code[30])
        {
            Caption = 'Item No.';
        }

        field(12; "Sent to Journal Inventary"; Boolean)
        {
            Caption = 'Sent to Journal Inventory';
        }

        field(13; "Qty Physical"; Decimal)
        {
            Caption = 'Qty Physical';
        }

        field(14; "Full Lot"; Boolean)
        {
            Caption = 'Full Lot';
        }

        field(15; "Higher Lot"; Boolean)
        {
            Caption = 'Higher Lot';
        }

        field(16; "Incomplete Lot"; Boolean)
        {
            Caption = 'Incomplete Lot';
        }

        field(17; "Inventory Code"; Code[50])
        {
            Caption = 'Inventory Code';
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
