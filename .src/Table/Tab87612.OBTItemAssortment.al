namespace Obtain.Rebuy;

using Microsoft.Inventory.Item;

/// <summary>
/// Table OBT Item Assortment (ID 87612).
/// </summary>
table 87612 "OBT Item Assortment"
{
    Caption = 'Item Assortment';
    DataClassification = ToBeClassified;
    LookupPageId = "OBT Assortment Items";
    DrillDownPageId = "OBT Assortment Items";
    fields
    {
        field(1; "OBT Item No."; Code[20])
        {
            Caption = 'Item No.,';
            TableRelation = Item;
            NotBlank = true;
            ToolTip = 'Specifies the item number.', Comment = '%';
        }
        field(5; "OBT Assortment Code"; Code[20])
        {
            Caption = 'Assortment Code';
            TableRelation = "OBT Assortment";
            ToolTip = 'Specifies the code of the assortment.', Comment = '%';
        }
        field(21; "OBT Item Description"; Text[100])
        {
            Caption = 'Item Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(item.Description where("No." = field("OBT Item No.")));
            ToolTip = 'Specifies the description of the item.', Comment = '%';
        }
        field(22; "OBT Assortment Description"; Text[100])
        {
            Caption = 'Assortment Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("OBT Assortment"."OBT Assortment Description" where("OBT Assortment Code" = field("OBT Assortment Code")));
            ToolTip = 'Specifies the description of the assortment.', Comment = '%';
        }
    }
    keys
    {
        key(Key1; "OBT Item No.", "OBT Assortment Code")
        {
            Clustered = true;
        }
        key(Key2; "OBT Assortment Code", "OBT Item No.")
        {

        }
    }
}
