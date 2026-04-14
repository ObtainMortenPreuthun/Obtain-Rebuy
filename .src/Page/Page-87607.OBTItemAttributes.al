/// <summary>
/// Page OBT Item Attributes Factbox (ID 87607).
/// </summary>
page 87607 "OBT Item Attributes Factbox"
{
    Caption = 'Item Attributes';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Item Attribute Value";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field(Attribute; rec.GetAttributeNameInCurrentLanguage())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attribute';
                    ToolTip = 'Specifies the name of the item attribute.';
                    Visible = TranslatedValuesVisible;
                }
                field(Value; rec.GetValueInCurrentLanguage())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Value';
                    ToolTip = 'Specifies the value of the item attribute.';
                    Visible = TranslatedValuesVisible;
                }
                field("Attribute Name"; Rec."Attribute Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attribute';
                    ToolTip = 'Specifies the name of the item attribute.';
                    Visible = NOT TranslatedValuesVisible;
                }
                field(RawValue; rec.Value)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Value';
                    ToolTip = 'Specifies the value of the item attribute.';
                    Visible = NOT TranslatedValuesVisible;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Edit)
            {
                AccessByPermission = TableData "Item Attribute" = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Edit';
                Image = Edit;
                ToolTip = 'Edit item''s attributes, such as color, size, or other characteristics that help to describe the item.';
                Visible = IsItem;

                trigger OnAction()
                var
                    Item: Record Item;
                begin
                    if not IsItem then
                        exit;
                    if not Item.Get(ContextValue) then
                        exit;
                    PAGE.RunModal(PAGE::"Item Attribute Value Editor", Item);
                    CurrPage.SaveRecord();
                    LoadItemAttributesData(ContextValue);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //SetAutoCalcFields("Attribute Name");
        TranslatedValuesVisible := ClientTypeManagement.GetCurrentClientType() <> CLIENTTYPE::Phone;
        IsVisible := true;
        if ItemAttCode <> '' then begin
            LoadItemAttributesData(ItemAttCode);
            ItemAttCode := '';
        end;

        if CategoryAttCode <> '' then begin
            LoadCategoryAttributesData(CategoryAttCode);
            CategoryAttCode := '';
        end;
    end;

    var
        ClientTypeManagement: Codeunit "Client Type Management";
        ContextType: Option "None",Item,Category;
        ContextValue: Code[20];
        IsItem: Boolean;
        IsVisible: Boolean;
        ItemAttCode: Code[20];
        CategoryAttCode: Code[20];

    protected var
        TranslatedValuesVisible: Boolean;

    /// <summary>
    /// LoadItemAttributesData.
    /// </summary>
    /// <param name="KeyValue">Code[20].</param>
    procedure LoadItemAttributesData(KeyValue: Code[20])
    begin
        if not IsVisible then begin
            ItemAttCode := KeyValue;
            exit;
        end;
        rec.LoadItemAttributesFactBoxData(KeyValue);
        SetContext(ContextType::Item, KeyValue);
        CurrPage.Update(false);
    end;

    /// <summary>
    /// LoadCategoryAttributesData.
    /// </summary>
    /// <param name="CategoryCode">Code[20].</param>
    procedure LoadCategoryAttributesData(CategoryCode: Code[20])
    begin
        if not IsVisible then begin
            CategoryAttCode := CategoryCode;
            exit;
        end;
        //LoadCategoryAttributesFactBoxData(CategoryCode);
        SetContext(ContextType::Category, CategoryCode);
        CurrPage.Update(false);
    end;

    local procedure SetContext(NewType: Option; NewValue: Code[20])
    begin
        ContextType := NewType;
        ContextValue := NewValue;
        IsItem := ContextType = ContextType::Item;
    end;
}

