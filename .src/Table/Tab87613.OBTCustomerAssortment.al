/// <summary>
/// Table OBT Customer Assortment (ID 87613).
/// </summary>
table 87613 "OBT Customer Assortment"
{
    Caption = 'Customer Assortment';
    DataClassification = ToBeClassified;
    LookupPageId = "OBT Assortment Customers";

    fields
    {
        field(1; "OBT Customer No."; Code[20])
        {
            Caption = 'Customer No.,';
            DataClassification = ToBeClassified;
            TableRelation = Customer;

        }
        field(5; "OBT Assortment Code"; Code[20])
        {
            Caption = 'Assortment Code';
            DataClassification = ToBeClassified;
            TableRelation = "OBT Assortment";

        }
        field(21; "OBT Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(customer.Name where("No." = field("OBT Customer No.")));
        }
        field(22; "OBT Assortment Description"; Text[100])
        {
            Caption = 'Assortment Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("OBT Assortment"."OBT Assortment Description" where("OBT Assortment Code" = field("OBT Assortment Code")));
        }
        field(23; "OBT Customer E-mail"; Text[100])
        {
            Caption = 'Customer E-mail';
            Editable = false;
            ExtendedDatatype = EMail;
            FieldClass = FlowField;
            CalcFormula = lookup(customer."E-Mail" where("No." = field("OBT Customer No.")));

        }

    }
    keys
    {
        key(Key1; "OBT Customer No.", "OBT Assortment Code")
        {
            Clustered = true;
        }
        key(Key2; "OBT Assortment Code", "OBT Customer No.")
        {

        }
    }
}
