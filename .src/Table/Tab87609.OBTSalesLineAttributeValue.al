/// <summary>
/// Table OBT Sales Line Attribute Value (ID 87609).
/// </summary>
table 87609 "OBT Sales Line Attribute Value"
{
    Caption = 'OBT Sales Line Attribute Value';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "OBT Sales Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Sales Document Type';
        }
        field(2; "OBT Sales Document No."; Code[20])
        {
            Caption = 'Sales Document No.';
        }
        field(3; "OBT Sales Document Line No."; Integer)
        {
            Caption = 'Sales Document Line No.';
        }
        field(11; "OBT AttributeID"; Integer)
        {
            Caption = 'AttributeID';
        }
        field(12; "OBT ID"; Integer)
        {
            Caption = 'ID';
        }
        field(13; "OBT Value"; Text[250])
        {
            Caption = 'Value';
        }
        field(14; "OBT Numeric Value"; Decimal)
        {
            Caption = 'Numeric Value';
        }
        field(15; "OBT Date Value"; Date)
        {
            Caption = 'Date Value';
        }
        field(16; "OBT Blocked"; Boolean)
        {
            Caption = 'Blocked';
        }
        field(20; "OBT Attribute Name"; Text[250])
        {
            CalcFormula = Lookup("Item Attribute".Name WHERE(ID = FIELD("OBT AttributeID")));
            Caption = 'Attribute Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "OBT Sales Document Type", "OBT Sales Document No.", "OBT Sales Document Line No.", "OBT AttributeID", "OBT ID")
        {
            Clustered = true;
        }
    }
    /// <summary>
    /// OBTSLLoadItemAttributesFactBoxData.
    /// </summary>
    /// <param name="pSH">Record "Sales Header".</param>       
    procedure OBTSLLoadItemAttributesFactBoxData(pSH: Record "Sales Header")
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValue: Record "Item Attribute Value";
        lSL: Record "Sales Line";

    begin
        Reset();
        DeleteAll();
        lsl.reset;
        lsl.SetCurrentKey("Document Type", "Document No.", Type, "No.");
        lsl.setrange("Document Type", pSH."Document Type");
        lsl.setrange("Document No.", pSH."No.");
        lsl.setrange(Type, lsl.type::Item);
        lSL.setfilter("No.", '<>%1', '');
        if lsl.FindSet() then
            repeat
                ItemAttributeValueMapping.setRange("Table ID", DATABASE::Item);
                ItemAttributeValueMapping.SetRange("No.", lsl."No.");
                if ItemAttributeValueMapping.FindSet() then
                    repeat
                        if ItemAttributeValue.Get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then begin
                            rec."OBT Sales Document Type" := lsl."Document Type";
                            rec."OBT Sales Document No." := lsl."Document No.";
                            rec."OBT Sales Document Line No." := lsl."Line No.";
                            rec."OBT AttributeID" := ItemAttributeValue."Attribute ID";
                            rec."OBT ID" := ItemAttributeValue.ID;
                            rec."OBT Value" := ItemAttributeValue."Value";
                            rec."OBT Blocked" := ItemAttributeValue.Blocked;
                            rec."OBT Date Value" := ItemAttributeValue."Date Value";
                            Insert();
                        end
                    until ItemAttributeValueMapping.Next() = 0;
            until lSL.Next() = 0;
    end;
    /// <summary>
    /// GetAttributeNameInCurrentLanguage.
    /// </summary>
    /// <returns>Return value of type Text[250].</returns>
    procedure OBTGetAttributeNameInCurrentLanguage(): Text[250]
    var
        ItemAttribute: Record "Item Attribute";
    begin
        if ItemAttribute.Get("OBT AttributeID") then
            exit(ItemAttribute.GetNameInCurrentLanguage());
        exit('');
    end;

    /// <summary>
    /// OBTGetValueInCurrentLanguage.
    /// </summary>
    /// <returns>Return variable ValueTxt of type Text[250].</returns>
    procedure OBTGetValueInCurrentLanguage() ValueTxt: Text[250]
    var
        ItemAttribute: Record "Item Attribute";
    begin
        ValueTxt := OBTGetValueInCurrentLanguageWithoutUnitOfMeasure();

        if ItemAttribute.Get("OBT AttributeID") then
            case ItemAttribute.Type of
                ItemAttribute.Type::Integer,
              ItemAttribute.Type::Decimal:
                    if ValueTxt <> '' then
                        exit(OBTAppendUnitOfMeasure(ValueTxt, ItemAttribute));
            end;
    end;

    /// <summary>
    /// OBTGetValueInCurrentLanguageWithoutUnitOfMeasure.
    /// </summary>
    /// <returns>Return value of type Text[250].</returns>
    procedure OBTGetValueInCurrentLanguageWithoutUnitOfMeasure(): Text[250]
    var
        ItemAttribute: Record "Item Attribute";
    begin
        if ItemAttribute.Get("OBT AttributeID") then
            case ItemAttribute.Type of
                ItemAttribute.Type::Option:
                    exit(OBTGetTranslatedName(GlobalLanguage));
                ItemAttribute.Type::Text:
                    exit("OBT Value");
                ItemAttribute.Type::Integer:
                    if "OBT Value" <> '' then
                        exit(Format("OBT Value"));
                ItemAttribute.Type::Decimal:
                    if "OBT Value" <> '' then
                        exit(Format("OBT Numeric Value"));
                ItemAttribute.Type::Date:
                    exit(Format("OBT Date Value"));
                else begin
                    exit("OBT Value");
                end;
            end;
        exit('');
    end;

    /// <summary>
    /// GetTranslatedName.
    /// </summary>
    /// <param name="LanguageID">Integer.</param>
    /// <returns>Return value of type Text[250].</returns>
    procedure OBTGetTranslatedName(LanguageID: Integer): Text[250]
    var
        Language: Codeunit Language;
        LanguageCode: Code[10];
    begin
        LanguageCode := Language.GetLanguageCode(LanguageID);
        if LanguageCode <> '' then
            exit(OBTGetTranslatedNameByLanguageCode(LanguageCode));
        exit("OBT Value");
    end;

    /// <summary>
    /// OBTGetTranslatedNameByLanguageCode.
    /// </summary>
    /// <param name="LanguageCode">Code[10].</param>
    /// <returns>Return value of type Text[250].</returns>
    procedure OBTGetTranslatedNameByLanguageCode(LanguageCode: Code[10]): Text[250]
    var
        ItemAttrValueTranslation: Record "Item Attr. Value Translation";
    begin
        if not ItemAttrValueTranslation.Get("OBT AttributeID", "OBT ID", LanguageCode) then
            exit("OBT Value");
        exit(ItemAttrValueTranslation.Name);
    end;

    local procedure OBTAppendUnitOfMeasure(String: Text; ItemAttribute: Record "Item Attribute"): Text
    begin
        if ItemAttribute."Unit of Measure" <> '' then
            exit(StrSubstNo('%1 %2', String, Format(ItemAttribute."Unit of Measure")));
        exit(String);
    end;
}

