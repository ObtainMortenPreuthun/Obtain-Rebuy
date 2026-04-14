/// <summary>
/// Table OBT Get Post Buffer (ID 87635).
/// </summary>
table 87635 "OBT Get Post Buffer"
{
    Caption = 'Get Post Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "OBT Table Number"; Integer)
        {
            Caption = 'Table Number';
        }
        field(2; "OBT Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "OBT Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(4; "OBT Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(5; "OBT Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(6; "OBT Quantity"; Decimal)
        {
            Caption = 'Quantity ';
        }
        field(7; "OBT Line Type"; Enum "Sales Line Type")
        {
            Caption = 'Line Type';
        }
    }
    keys
    {
        key(PK; "OBT Table Number", "OBT Document No.", "OBT Document Line No.")
        {
            Clustered = true;
        }
    }
}
