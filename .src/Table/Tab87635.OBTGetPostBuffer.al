namespace Obtain.Rebuy;

using Microsoft.Sales.Document;

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
            ToolTip = 'Specifies the table number of the posted document.', Comment = '%';
        }
        field(2; "OBT Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the document number of the posted document.', Comment = '%';
        }
        field(3; "OBT Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            ToolTip = 'Specifies the line number of the posted document.', Comment = '%';
        }
        field(4; "OBT Item No."; Code[20])
        {
            Caption = 'Item No.';
            ToolTip = 'Specifies the item number.', Comment = '%';
        }
        field(5; "OBT Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            ToolTip = 'Specifies the unit of measure code for the item.', Comment = '%';
        }
        field(6; "OBT Quantity"; Decimal)
        {
            Caption = 'Quantity ';
            ToolTip = 'Specifies the quantity of the item.', Comment = '%';
        }
        field(7; "OBT Line Type"; Enum "Sales Line Type")
        {
            Caption = 'Line Type';
            ToolTip = 'Specifies the type of the sales line.', Comment = '%';
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
