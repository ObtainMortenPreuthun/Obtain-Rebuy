/// <summary>
/// Table OBT Customer Assortment (ID 87613).
/// </summary>
table 87616 "OBT Contact Assortment"
{
    Caption = 'Contact Assortment';
    DataClassification = ToBeClassified;
    LookupPageId = "OBT Assortment Contacts";

    fields
    {
        field(1; "OBT Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact;
            NotBlank = true;

        }
        field(5; "OBT Assortment Code"; Code[20])
        {
            Caption = 'Assortment Code';
            DataClassification = ToBeClassified;
            TableRelation = "OBT Assortment";

        }
        field(21; "OBT Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("OBT Contact No.")));
        }
        field(22; "OBT Assortment Description"; Text[100])
        {
            Caption = 'Assortment Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("OBT Assortment"."OBT Assortment Description" where("OBT Assortment Code" = field("OBT Assortment Code")));
        }
        field(23; "OBT Copntact E-mail"; Text[100])
        {
            Caption = 'Contact E-Mail';
            Editable = false;
            ExtendedDatatype = EMail;
            FieldClass = FlowField;
            CalcFormula = lookup(contact."E-Mail" where("No." = field("OBT Contact No.")));
        }
    }
    keys
    {
        key(Key1; "OBT Contact No.", "OBT Assortment Code")
        {
            Clustered = true;
        }
        key(Key2; "OBT Assortment Code", "OBT Contact No.")
        {
        }
    }
}
