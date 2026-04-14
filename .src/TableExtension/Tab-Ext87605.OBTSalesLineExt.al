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
