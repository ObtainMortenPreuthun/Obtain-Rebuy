/// <summary>
/// Page OBT Get Pst.Doc-RtrnRcptLn Sub (ID 87627).
/// </summary>
page 87627 "OBT Get Pst.Doc-RtrnRcptLn Sub"
{
    Caption = 'Lines';
    Editable = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Return Receipt Line";
    SourceTableView = sorting("Document No.", "Line No.") Order(descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = SalesReturnOrder;
                    HideValue = DocumentNoHideValue;
                    Lookup = false;
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the number of the return receipt.';
                    Editable = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    Editable = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                    Visible = false;
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the number of the customer.';
                    Visible = false;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the line type.';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Editable = false;
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    AccessByPermission = tabledata "Item Reference" = R;
                    ApplicationArea = Suite, ItemReferences;
                    ToolTip = 'Specifies the referenced item number.';
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;
                    Editable = false;
                }
                field(Nonstock; rec.Nonstock)
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies that this item is a catalog item.';
                    Visible = false;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies either the name of, or the description of, the item, general ledger account, or item charge.';
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information in addition to the description.';
                    Editable = false;

                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the code explaining why the item was returned.';
                    Visible = false;
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = SalesReturnOrder;
                    DrillDown = false;
                    Lookup = false;
                    ToolTip = 'Specifies the currency code for the amount on this line.';
                    Visible = false;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the location in which the return receipt line was registered.';
                    Visible = false;
                    Editable = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    Visible = false;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the number of units of the item, general ledger account, or item charge specified on the line.';
                    Editable = false;
                }
                field(QuantiyToOrder; OBTQty)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order Quantity';
                    Editable = true;
                    DecimalPlaces = 0 : 2;
                    BlankZero = true;
                    trigger OnValidate()
                    var
                        lOBTGetDocumentLinesFunction: Codeunit OBTGetDocumentLinesFunction;
                    begin
                        IF OBTQtyBuffer.GET(6661, Rec."Document No.", rec."Line No.") then begin
                            OBTQtyBuffer."OBT Quantity" := OBTQty;
                            OBTQtyBuffer."OBT Item No." := rec."No.";
                            OBTQtyBuffer."OBT Unit of Measure Code" := rec."Unit of Measure Code";
                            OBTQtyBuffer."OBT Line Type" := rec.Type;
                            OBTQtyBuffer.Modify();
                        end else begin
                            clear(OBTQtyBuffer);
                            OBTQtyBuffer."OBT Table Number" := 6661;
                            OBTQtyBuffer."OBT Document No." := rec."Document No.";
                            OBTQtyBuffer."OBT Document Line No." := rec."Line No.";
                            OBTQtyBuffer."OBT Item No." := rec."No.";
                            OBTQtyBuffer."OBT Unit of Measure Code" := rec."Unit of Measure Code";
                            OBTQtyBuffer."OBT Line Type" := rec.Type;
                            OBTQtyBuffer."OBT Quantity" := OBTQty;
                            OBTQtyBuffer.Insert();
                        end;
                    end;
                }
                field("Return Qty. Rcd. Not Invd."; Rec."Return Qty. Rcd. Not Invd.")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the quantity from the line that has been posted as received but that has not yet been posted as invoiced.';
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    Visible = false;
                    Editable = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
                    Visible = false;
                    Editable = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the number of the related job.';
                    Visible = false;
                    Editable = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the number of the blanket order that the record originates from.';
                    Visible = false;
                    Editable = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
                    Visible = false;
                    Editable = false;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied from.';
                    Visible = false;
                    Editable = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied to.';
                    Visible = false;
                    Editable = false;
                }
                field(Available; OBTAvailable)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available';
                    Editable = false;
                    DecimalPlaces = 0 : 2;
                }
                field(ItemComment; OBTItemComment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Comment';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Show Document")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Show Document';
                    Image = View;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Open the document that the selected line exists on.';

                    trigger OnAction()
                    begin
                        ShowDocument();
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        rec.ShowDimensions();
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Ctrl+Alt+I';
                    ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                    trigger OnAction()
                    begin
                        ItemTrackingLines();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OBT
        OBTQty := OBTGetOrderQty();
        DocumentNoHideValue := false;
        DocumentNoOnFormat();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        IsHandled: Boolean;
        ReturnValue: Boolean;
    begin
        IsHandled := false;
        OnBeforeFindRecord(Which, Rec, ReturnValue, IsHandled);
        if IsHandled then
            exit(ReturnValue);

        exit(Rec.Find(Which));
    end;

    trigger OnOpenPage()
    begin
    end;

    var
        ReturnRcptLine: Record "Return Receipt Line";
        TempReturnRcptLine: Record "Return Receipt Line" temporary;
        [InDataSet]
        DocumentNoHideValue: Boolean;

        OBTItemCalcAvail: Codeunit "OBT Item CalcAvail ItemNo";
        OBTQtyBuffer: Record "OBT Get Post Buffer" temporary;
        OBTQty: Decimal;

    local procedure IsFirstDocLine(): Boolean
    begin
        TempReturnRcptLine.Reset();
        TempReturnRcptLine.CopyFilters(Rec);
        TempReturnRcptLine.SetRange("Document No.", rec."Document No.");
        if not TempReturnRcptLine.FindFirst() then begin
            ReturnRcptLine.CopyFilters(Rec);
            ReturnRcptLine.SetRange("Document No.", rec."Document No.");
            if not ReturnRcptLine.FindFirst() then
                exit(false);
            TempReturnRcptLine := ReturnRcptLine;
            TempReturnRcptLine.Insert();
        end;

        exit(Rec."Line No." = TempReturnRcptLine."Line No.");
    end;

    /// <summary>
    /// GetSelectedLine.
    /// </summary>
    /// <param name="FromReturnRcptLine">VAR Record "Return Receipt Line".</param>
    procedure GetSelectedLine(var FromReturnRcptLine: Record "Return Receipt Line")
    begin
        FromReturnRcptLine.Copy(Rec);
        CurrPage.SetSelectionFilter(FromReturnRcptLine);
    end;

    local procedure ShowDocument()
    var
        ReturnRcptHeader: Record "Return Receipt Header";
    begin
        if not ReturnRcptHeader.Get(Rec."Document No.") then
            exit;
        PAGE.Run(PAGE::"Posted Return Receipt", ReturnRcptHeader);
    end;

    local procedure ItemTrackingLines()
    var
        FromReturnRcptLine: Record "Return Receipt Line";
    begin
        GetSelectedLine(FromReturnRcptLine);
        FromReturnRcptLine.ShowItemTrackingLines();
    end;

    local procedure DocumentNoOnFormat()
    begin
        if not IsFirstDocLine() then
            DocumentNoHideValue := true;
    end;

    local procedure OBTAvailable(): Decimal
    begin
        IF (rec.Type <> rec.Type::Item) then
            exit(0)
        else
            EXIT(OBTItemCalcAvail.OBTItemCalcAvailable(rec."No.", rec."Variant Code", rec."Location Code", Workdate));

    end;

    local procedure OBTItemComment(): Boolean
    begin
        IF (rec.Type <> rec.Type::Item) then
            exit(false)
        else
            exit(OBTItemCalcAvail.OBTItemComment(rec."No."));

    end;
    /// <summary>
    /// OBTQtyBufferLine.
    /// </summary>
    /// <param name="FromOBTQtyBuffer">VAR Record "OBT Get Post Buffer".</param>
    procedure OBTQtyBufferLine(var FromOBTQtyBuffer: Record "OBT Get Post Buffer")
    begin
        OBTQtyBuffer.reset;
        OBTQtyBuffer.SetFilter(OBTQtyBuffer."OBT Quantity", '<>%1', 0);
        FromOBTQtyBuffer.reset;
        FromOBTQtyBuffer.deleteall;
        IF OBTQtyBuffer.findfirst then
            repeat
                FromOBTQtyBuffer := OBTQtyBuffer;
                FromOBTQtyBuffer.insert;
            until OBTQtyBuffer.next = 0;

    end;

    local procedure OBTGetOrderQty(): Decimal
    begin
        clear(OBTQtyBuffer);
        IF OBTQtyBuffer.get(6661, rec."Document No.", rec."Line No.") THEN
            exit(OBTQtyBuffer."OBT Quantity")
        else
            exit(0);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFindRecord(var Which: Text; var ReturnReceiptLine: Record "Return Receipt Line"; var ReturnValue: Boolean; var IsHandled: Boolean)
    begin
    end;
}
