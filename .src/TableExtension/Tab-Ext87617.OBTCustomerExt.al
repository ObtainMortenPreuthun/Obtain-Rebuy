namespace Obtain.Rebuy;

using Microsoft.Inventory.Location;
using Microsoft.Sales.Customer;

/// <summary>
/// TableExtension OBT Customer Ext (ID 87617) extends Record Customer.
/// </summary>
tableextension 87617 "OBT Customer Ext" extends Customer
{
    DataCaptionFields = "No.", "Name", "OBX Location Filter";

    fields
    {
        field(87600; "OBT Assortment Filter"; Code[20])
        {
            Caption = 'Assortment Filter';
            ToolTip = 'Specifies a filter to show customers belonging to a specific assortment.', Comment = '%';
            TableRelation = "OBT Assortment";
            ValidateTableRelation = false;
            FieldClass = FlowFilter;

        }
        field(87601; "OBT In Assortment"; Boolean)
        {
            Caption = 'In Assortment';
            ToolTip = 'Specifies whether the customer is included in the filtered assortment.', Comment = '%';
            FieldClass = FlowField;
            CalcFormula = exist("OBT Customer Assortment" where("OBT Customer No." = field("No."), "OBT Assortment Code" = field("OBT Assortment Filter")));
            Editable = false;

        }
        field(87602; "OBT Store Number"; Code[20])
        {
            Caption = 'Store Number';
            ToolTip = 'Specifies the store number associated with the customer.', Comment = '%';
            DataClassification = ToBeClassified;
        }
        field(87605; "OBX Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            ToolTip = 'Specifies a filter to show entries for a specific location.', Comment = '%';
            Editable = false;
            FieldClass = FlowFilter;
            TableRelation = "Location";
        }
    }
}
