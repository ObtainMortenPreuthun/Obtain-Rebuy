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
            TableRelation = "OBT Assortment";
            ValidateTableRelation = false;
            FieldClass = FlowFilter;
        }
        field(87603; "OBT In Assortment"; Boolean)
        {
            Caption = 'In Assortment';
            FieldClass = FlowField;
            Editable = False;
            CalcFormula = exist("OBT Item Assortment" where("OBT Item No." = field("No."), "OBT Assortment Code" = field("OBT Assortment Filter")));
        }

    }
}
