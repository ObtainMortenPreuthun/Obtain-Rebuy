namespace Obtain.Rebuy;

using Microsoft.Inventory.Item;

/// <summary>
/// TableExtension OBT Item Extension (ID 87600) extends Record Item.
/// </summary>
tableextension 87600 "OBX Item Ext" extends Item
{
    fields
    {

        field(87602; "OBT Assortment Filter"; Code[20])
        {
            Caption = 'Assortment Filter';
            ToolTip = 'Specifies a filter to show items belonging to a specific assortment.', Comment = '%';
            TableRelation = "OBT Assortment";
            ValidateTableRelation = false;
            FieldClass = FlowFilter;
        }
        field(87603; "OBT In Assortment"; Boolean)
        {
            Caption = 'In Assortment';
            ToolTip = 'Specifies whether the item is included in the filtered assortment.', Comment = '%';
            FieldClass = FlowField;
            Editable = False;
            CalcFormula = exist("OBT Item Assortment" where("OBT Item No." = field("No."), "OBT Assortment Code" = field("OBT Assortment Filter")));
        }

    }
}
