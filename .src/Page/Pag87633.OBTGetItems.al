/// <summary>
/// Page OBT Item List -  (ID 87633).
/// </summary>
page 87633 "OBT Item List"
{
    Caption = 'Items';
    Editable = true;
    PageType = List;
    SourceTable = Item;
    CardPageId = "Item Card";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Lookup = false;
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the item number';
                    Editable = false;
                    Width = 8;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                    Width = 20;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                    Width = 4;
                }
                field(QuantityToOrder; OBTQty)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order Quantity';
                    Editable = true;
                    DecimalPlaces = 0 : 2;
                    BlankZero = true;
                    Width = 6;
                    ToolTip = 'Specifies the quantity to order for the item.';
                    trigger OnValidate()
                    begin
                        IF OBTQtyBuffer.GET(27, rec."No.", 0) then begin
                            OBTQtyBuffer."OBT Quantity" := OBTQty;
                            OBTQtyBuffer."OBT Item No." := rec."No.";
                            OBTQtyBuffer."OBT Unit of Measure Code" := rec."Base Unit of Measure";
                            OBTQtyBuffer."OBT Line Type" := OBTQtyBuffer."OBT Line Type"::Item;
                            OBTQtyBuffer.Modify();
                        end else begin
                            clear(OBTQtyBuffer);
                            OBTQtyBuffer."OBT Table Number" := 27;
                            OBTQtyBuffer."OBT Document No." := Rec."No.";
                            OBTQtyBuffer."OBT Document Line No." := 0;
                            OBTQtyBuffer."OBT Item No." := rec."No.";
                            OBTQtyBuffer."OBT Unit of Measure Code" := rec."Base Unit of Measure";
                            OBTQtyBuffer."OBT Line Type" := OBTQtyBuffer."OBT Line Type"::Item;
                            OBTQtyBuffer."OBT Quantity" := OBTQty;
                            OBTQtyBuffer.Insert();
                        end;
                    end;
                }
                field(Inventory; OBTItemCalcAvail.OBXInventory(Rec."No.", '', ToSalesHeader."Location Code"))
                {
                    ApplicationArea = All;
                    Caption = 'Inventory';
                    Editable = false;
                    Visible = true;
                    DecimalPlaces = 0 : 2;
                    Width = 4;
                    ToolTip = 'Specifies the current inventory of the item in the location.';
                }
                field(Available; OBTAvailable)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available';
                    Editable = false;
                    Visible = true;
                    Width = 4;
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the available quantity of the item in the location.';

                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Width = 4;
                    ToolTip = 'Specifies the item category code that is assigned to the item.';
                }

                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Width = 1;
                    ToolTip = 'Specifies whether there are substitutes for the item.';
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Width = 1;
                    ToolTip = 'Specifies whether the item is an assembly BOM.';
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the base unit of measure for the item.';
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Width = 2;
                    ToolTip = 'Specifies whether the cost of the item is adjusted.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Width = 4;
                    ToolTip = 'Specifies the unit cost of the item.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Width = 4;
                    ToolTip = 'Specifies the unit price of the item.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                    ToolTip = 'Specifies the number of the vendor that is associated with the item.';
                }
                field("Default Deferral Template Code"; Rec."Default Deferral Template Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    ApplicationArea = All;
                    Visible = False;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Visible = False;
                    Editable = false;
                }
                field("Block Reason"; Rec."Block Reason")
                {
                    ApplicationArea = All;
                    Visible = False;
                    Editable = false;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field(GTIN; Rec.GTIN)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;

                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("&Item")
            {

                action("Show Item")
                {
                    ApplicationArea = All;
                    Caption = 'Show Item';
                    Image = Item;
                    ShortcutKey = 'Shift+F5';
                    trigger OnAction()
                    begin
                        ShowItem();
                    end;
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action(DimensionsSingle)
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(27),
                                      "No." = FIELD("No.");
                        Scope = Repeater;
                        ShortCutKey = 'Alt+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action(DimensionsMultiple)
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction()
                        var
                            Item: Record Item;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SetSelectionFilter(Item);
                            DefaultDimMultiple.SetMultiRecord(Item, rec.FieldNo("No."));
                            DefaultDimMultiple.RunModal();
                        end;
                    }
                }



            }
        }

    }
    trigger OnAfterGetRecord()
    begin
        //OBT
        OBTQty := OBTGetOrderQty();
    end;

    trigger OnOpenPage()
    begin
        if ToSalesHeader.Get(ToSalesHeader."Document Type"::Order, ToSalesHeader."No.") then;
    end;

    var
        ToSalesHeader: Record "Sales Header";
        gItem: record Item;
        OBTQtyBuffer: Record "OBT Get Post Buffer" temporary;
        OBTItemCalcAvail: Codeunit "OBT Item CalcAvail ItemNo";
        OBTQty: Decimal;

    /// <summary>
    /// Initialize.
    /// </summary>
    /// <param name="NewToSalesHeader">Record "Sales Header".</param>
    procedure Initialize(NewToSalesHeader: Record "Sales Header")
    begin
        ToSalesHeader := NewToSalesHeader;
    end;



    /// <summary>
    /// GetSelectedLine.
    /// </summary>
    /// <param name="FromItem">VAR Record Item.</param>
    procedure GetSelectedLine(var FromItem: Record Item)
    begin
        FromItem.Copy(Rec);
        CurrPage.SetSelectionFilter(FromItem);
    end;
    /// <summary>
    /// ShowItem.
    /// </summary>
    procedure ShowItem()
    begin
        if not gItem.get(rec."No.") then
            exit;
        Page.run(Page::"Item Card", gItem);
    end;

    local procedure OBTGetOrderQty(): Decimal
    begin
        clear(OBTQtyBuffer);
        IF OBTQtyBuffer.get(27, rec."No.", 0) THEN
            exit(OBTQtyBuffer."OBT Quantity")
        else
            exit(0);
    end;

    local procedure OBTAvailable(): Decimal

    begin
        exit(OBTItemCalcAvail.OBTItemCalcAvailable(rec."No.", '', ToSalesHeader."Location Code", Workdate));
    end;

    /// <summary>
    /// OBTQtyBufferLine.
    /// </summary>
    /// <param name="FromOBTQtyBuffer">VAR Record "OBT Sales Line Copy Buffer".</param>
    procedure OBTQtyBufferLine(var FromOBTQtyBuffer: Record "OBT Get Post Buffer")
    begin
        OBTQtyBuffer.reset;
        OBTQtyBuffer.SetFilter(OBTQtyBuffer."OBT Quantity", '<>%1', 0);
        FromOBTQtyBuffer.reset;
        //FromOBTQtyBuffer.deleteall;
        IF OBTQtyBuffer.findfirst then
            repeat
                FromOBTQtyBuffer := OBTQtyBuffer;
                FromOBTQtyBuffer.insert;
            until OBTQtyBuffer.next = 0;

    end;
}