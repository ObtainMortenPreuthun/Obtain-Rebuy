namespace Obtain.Rebuy;

using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;

/// <summary>
/// Page OBT Item List -  (ID 87633).
/// </summary>
page 87634 "OBT Item List Assortment"
{
    Caption = 'Items';
    Editable = true;
    PageType = ListPart;
    SourceTable = Item;
    SourceTableView = sorting("No.") where("OBT In Assortment" = FILTER(true));
    CardPageId = "Item Card";
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
                    Lookup = false;
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the item number';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                }
                field(QuantiyToOrder; OBTQty)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order Quantity';
                    ToolTip = 'Specifies the new quantity to re-order.';
                    Editable = true;
                    DecimalPlaces = 0 : 2;
                    BlankZero = true;
                    trigger OnValidate()
                    begin
                        IF TempOBTQtyBuffer.GET(27, rec."No.", 0) then begin
                            TempOBTQtyBuffer."OBT Quantity" := OBTQty;
                            TempOBTQtyBuffer."OBT Item No." := rec."No.";
                            TempOBTQtyBuffer."OBT Unit of Measure Code" := rec."Base Unit of Measure";
                            TempOBTQtyBuffer."OBT Line Type" := TempOBTQtyBuffer."OBT Line Type"::Item;
                            TempOBTQtyBuffer.Modify();
                        end else begin
                            clear(TempOBTQtyBuffer);
                            TempOBTQtyBuffer."OBT Table Number" := 27;
                            TempOBTQtyBuffer."OBT Document No." := Rec."No.";
                            TempOBTQtyBuffer."OBT Document Line No." := 0;
                            TempOBTQtyBuffer."OBT Item No." := rec."No.";
                            TempOBTQtyBuffer."OBT Unit of Measure Code" := rec."Base Unit of Measure";
                            TempOBTQtyBuffer."OBT Line Type" := TempOBTQtyBuffer."OBT Line Type"::Item;
                            TempOBTQtyBuffer."OBT Quantity" := OBTQty;
                            TempOBTQtyBuffer.Insert();
                        end;
                    end;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                }
                field(Inventory; Rec.Inventory)
                {
                    Editable = false;
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    Editable = false;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    Editable = false;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    Editable = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                }
                field("Default Deferral Template Code"; Rec."Default Deferral Template Code")
                {
                    Editable = false;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    Visible = False;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = False;
                    Editable = false;
                }
                field("Block Reason"; Rec."Block Reason")
                {
                    Visible = False;
                    ToolTip = 'Specifies why the item is blocked.';
                    Editable = false;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    Visible = false;
                    Editable = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    Editable = false;
                }
                field(GTIN; Rec.GTIN)
                {
                    Visible = false;
                    Editable = false;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Visible = false;
                    Editable = false;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
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
                    Caption = 'Show Item';
                    Image = Item;
                    ShortcutKey = 'Shift+F5';
                    ToolTip = 'Open the item card for the selected item.';
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

    end;

    var
        ToSalesHeader: Record "Sales Header";
        gItem: record Item;
        TempOBTQtyBuffer: Record "OBT Get Post Buffer" temporary;
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
        clear(TempOBTQtyBuffer);
        IF TempOBTQtyBuffer.get(27, rec."No.", 0) THEN
            exit(TempOBTQtyBuffer."OBT Quantity")
        else
            exit(0);
    end;
    /// <summary>
    /// OBTQtyBufferLine.
    /// </summary>
    /// <param name="FromOBTQtyBuffer">VAR Record "OBT Sales Line Copy Buffer".</param>
    procedure OBTQtyBufferLine(var FromOBTQtyBuffer: Record "OBT Get Post Buffer")
    begin
        TempOBTQtyBuffer.reset;
        TempOBTQtyBuffer.SetFilter(TempOBTQtyBuffer."OBT Quantity", '<>%1', 0);
        FromOBTQtyBuffer.reset;
        FromOBTQtyBuffer.deleteall;
        IF TempOBTQtyBuffer.findfirst then
            repeat
                FromOBTQtyBuffer := TempOBTQtyBuffer;
                FromOBTQtyBuffer.insert;
            until TempOBTQtyBuffer.next = 0;

    end;
}