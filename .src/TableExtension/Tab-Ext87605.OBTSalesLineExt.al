namespace Obtain.Rebuy;

using Microsoft.Inventory.Ledger;
using Microsoft.Sales.Document;

/// <summary>
/// TableExtension OBT Sales Line Ext (ID 87605) extends Record Sales Line.
/// </summary>
tableextension 87605 "OBX Sales Line Ext" extends "Sales Line"
{
    fields
    {

        field(87603; "OBX Inventory"; Decimal)
        {
            Caption = 'Inventory';
            ToolTip = 'Specifies the current inventory of the item at the specified location.', Comment = '%';
            Editable = false;
            DecimalPlaces = 0 : 5;
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Variant Code" = field("Variant Code"),
                                                                  "Location Code" = field("Location Code")));

        }

    }

}
