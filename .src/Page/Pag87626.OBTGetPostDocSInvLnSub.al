/// <summary>
/// Page OBT Get Post.Doc - S.InvLn Sub (ID 87626).
/// </summary>

page 87626 "OBT Get Post.Doc - S.InvLn Sub"
{
    Caption = 'Lines';
    Editable = True;
    PageType = ListPart;
    SourceTable = "Sales Invoice Line";
    SourceTableView = sorting("Document No.", "Line No.") Order(descending) where(Quantity = filter(<> 0), Type = filter(Item)); // Filter to show only Item lines with Quantity not equal to 0
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = DocumentNoHideValue;
                    Lookup = false;
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the invoice number.';
                    Editable = false;
                    Width = 8;
                }
                field("Posting Date"; SalesInvHeader."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the posting date of the record.';
                    Editable = false;
                    Width = 5;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    Visible = false;
                    Editable = false;
                    Width = 5;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                    Visible = false;
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the customer.';
                    Visible = false;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the line type.';
                    Editable = false;
                    Visible = true;
                    Width = 1;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Editable = false;
                    Visible = true;
                    Width = 10;
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    AccessByPermission = tabledata "Item Reference" = R;
                    ApplicationArea = Suite, ItemReferences;
                    ToolTip = 'Specifies the referenced item number.';
                    Editable = false;
                    Visible = false;
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
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that this item is a catalog item.';
                    Visible = false;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the item or general ledger account, or some descriptive text.';
                    Editable = false;
                    Visible = true;
                    Width = 20;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies information in addition to the description.';
                    Editable = false;
                    Visible = false;
                    Width = 20;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code explaining why the item was returned.';
                    Visible = false;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the location in which the invoice line was registered.';
                    Visible = false;
                    Editable = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Warehouse;
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
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    Editable = false;
                    Visible = true;
                    Width = 2;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of units of the item specified on the line.';
                    Editable = false;
                    Visible = true;
                    Width = 4;
                }
                field(QuantiyToOrder; OBTQty)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order Quantity';
                    Editable = true;
                    DecimalPlaces = 0 : 2;
                    Width = 4;
                    Visible = true;
                    BlankZero = true;
                    ToolTip = 'Specifies the new quantity to re-order.';
                    trigger OnValidate()
                    begin
                        IF TempOBTQtyBuffer.GET(113, Rec."Document No.", rec."Line No.") then begin
                            TempOBTQtyBuffer."OBT Quantity" := OBTQty;
                            TempOBTQtyBuffer."OBT Item No." := rec."No.";
                            TempOBTQtyBuffer."OBT Unit of Measure Code" := rec."Unit of Measure Code";
                            TempOBTQtyBuffer."OBT Line Type" := rec.Type;
                            TempOBTQtyBuffer.Modify();
                        end else begin
                            clear(TempOBTQtyBuffer);
                            TempOBTQtyBuffer."OBT Table Number" := 113;
                            TempOBTQtyBuffer."OBT Document No." := rec."Document No.";
                            TempOBTQtyBuffer."OBT Document Line No." := rec."Line No.";
                            TempOBTQtyBuffer."OBT Item No." := rec."No.";
                            TempOBTQtyBuffer."OBT Unit of Measure Code" := rec."Unit of Measure Code";
                            TempOBTQtyBuffer."OBT Line Type" := rec.Type;
                            TempOBTQtyBuffer."OBT Quantity" := OBTQty;
                            TempOBTQtyBuffer.Insert();
                        end;
                    end;
                }
                field(Inventory; OBTItemCalcAvail.OBXInventory(rec."No.", rec."Variant Code", ToSalesHeader."Location Code"))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory';
                    Editable = false;
                    Visible = true;
                    Width = 4;
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the current Inventory of the current Location Code of the item that is available in the inventory.';
                }
                field(Available; OBTAvailable)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available';
                    Editable = false;
                    Visible = true;
                    Width = 4;
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the available quantity (Inventory minus Salesorders for the current Location Code) of the item that is for sale.';
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                        LocFilter: Text;
                    begin
                        if not Item.Get(rec."No.") then
                            exit;
                        Item.SetRange("Location Filter", ToSalesHeader."Location Code");
                        LocFilter := ToSalesHeader."Location Code";
                        if LocFilter = '' then LocFilter := '<Blank>';
                        Item.CalcFields(Inventory, "Qty. on Sales Order");
                        Message('Location %1: Inventory: %2, Sales Orders: %3', LocFilter, Item.Inventory, Item."Qty. on Sales Order");
                    end;

                }
                field(QtyNotReturned; QtyNotReturned)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Qty. Not Returned';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity from the posted document line that has been shipped to the customer and not returned by the customer.';
                    Editable = false;
                    Visible = false;
                    Width = 2;
                }
                field(QtyReturned; GetQtyReturned())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Qty. Returned';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity that was returned.';
                    Editable = false;
                    Visible = false;
                    Width = 2;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    Visible = false;
                    Editable = false;
                    Width = 2;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
                    Visible = false;
                    Editable = false;
                    Width = 4;
                }
                field(RevUnitCostLCY; RevUnitCostLCY)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 2;
                    Caption = 'Reverse Unit Cost (LCY)';
                    ToolTip = 'Specifies the unit cost that will appear on the new document lines.';
                    Visible = false;
                    Editable = false;
                }
                field(UnitPrice; UnitPrice)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatExpression = SalesInvHeader."Currency Code";
                    AutoFormatType = 2;
                    Caption = 'Unit Price';
                    ToolTip = 'Specifies the item''s unit price.';
                    Visible = true;
                    Editable = false;
                    Width = 4;
                }
                field(LineAmount; LineAmount)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatExpression = SalesInvHeader."Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Line Amount';
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                    Editable = false;
                    Visible = true;
                    Width = 4;
                }
                field("SalesInvHeader.""Currency Code"""; SalesInvHeader."Currency Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the code for the currency that amounts are shown in.';
                    Visible = false;
                    Editable = false;
                }
                field("SalesInvHeader.""Prices Including VAT"""; SalesInvHeader."Prices Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prices Including VAT';
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';
                    Visible = false;
                    Editable = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                    Editable = false;
                    Visible = true;
                    Width = 3;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    Visible = false;
                    Editable = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                    Visible = false;
                    Editable = false;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total calculated invoice discount amount for the line.';
                    Visible = false;
                    Editable = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the related job.';
                    Visible = false;
                    Editable = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the blanket order that the record originates from.';
                    Visible = false;
                    Editable = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
                    Visible = false;
                    Editable = false;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied from.';
                    Visible = false;
                    Editable = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied to.';
                    Visible = false;
                    Editable = false;
                }
                field(ItemComment; OBTItemComment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Comment';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies if there is a comment from the Item';
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
                    ApplicationArea = Basic, Suite;
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
                        Rec.ShowDimensions();
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
        Result: Boolean;
    begin
        if not IsVisible then
            exit(false);

        IsHandled := false;
        OnFindRecordOnBeforeFind(Rec, Which, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if Rec.Find(Which) then begin
            SalesInvLine := Rec;
            while true do begin
                ShowRec := IsShowRec(Rec);
                if ShowRec then
                    exit(true);
                if Rec.Next(1) = 0 then begin
                    Rec := SalesInvLine;
                    if Rec.Find(Which) then
                        while true do begin
                            ShowRec := IsShowRec(Rec);
                            if ShowRec then
                                exit(true);
                            if Rec.Next(-1) = 0 then
                                exit(false);
                        end;
                end;
            end;
        end;
        exit(false);
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        RealSteps: Integer;
        NextSteps: Integer;
    begin
        if Steps = 0 then
            exit;

        SalesInvLine := Rec;
        repeat
#pragma warning disable AL0756
            NextSteps := Rec.Next(Steps / Abs(Steps));
#pragma warning restore AL0756
            ShowRec := IsShowRec(Rec);
            if ShowRec then begin
                RealSteps := RealSteps + NextSteps;
                SalesInvLine := Rec;
            end;
        until (NextSteps = 0) or (RealSteps = Steps);
        Rec := SalesInvLine;
        Rec.Find();
        exit(RealSteps);
    end;

    trigger OnOpenPage()
    begin

    end;

    var
        ToSalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        TempSalesInvLine: Record "Sales Invoice Line" temporary;
        TempOBTQtyBuffer: Record "OBT Get Post Buffer" temporary;
        OBTItemCalcAvail: Codeunit "OBT Item CalcAvail ItemNo";
        QtyNotReturned: Decimal;
        RevUnitCostLCY: Decimal;
        UnitPrice: Decimal;
        LineAmount: Decimal;
        RevQtyFilter: Boolean;
        FillExactCostReverse: Boolean;
        IsVisible: Boolean;
        ShowRec: Boolean;
        OBTQty: Decimal;

    protected var
        [InDataSet]
        DocumentNoHideValue: Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesInvHeader2: Record "Sales Invoice Header";
        SalesInvLine2: Record "Sales Invoice Line";
        QtyNotReturned2: Decimal;
        RevUnitCostLCY2: Decimal;
    begin
        TempSalesInvLine.Reset();
        TempSalesInvLine.CopyFilters(Rec);
        TempSalesInvLine.SetRange("Document No.", Rec."Document No.");
        if not TempSalesInvLine.FindLast() then begin
            SalesInvHeader2 := SalesInvHeader;
            QtyNotReturned2 := QtyNotReturned;
            RevUnitCostLCY2 := RevUnitCostLCY;
            SalesInvLine2.CopyFilters(Rec);
            SalesInvLine2.SetRange("Document No.", Rec."Document No.");
            if not SalesInvLine2.FindLast() then
                exit(false);
            repeat
                ShowRec := IsShowRec(SalesInvLine2);
                if ShowRec then begin
                    TempSalesInvLine := SalesInvLine2;
                    TempSalesInvLine.Insert();
                end;
            until (SalesInvLine2.Next(-1) = 0) or ShowRec;
            SalesInvHeader := SalesInvHeader2;
            QtyNotReturned := QtyNotReturned2;
            RevUnitCostLCY := RevUnitCostLCY2;
        end;

        if Rec."Document No." <> SalesInvHeader."No." then
            SalesInvHeader.Get(Rec."Document No.");

        UnitPrice := Rec."Unit Price";
        LineAmount := Rec."Line Amount";

        exit(Rec."Line No." = TempSalesInvLine."Line No.");
    end;

    local procedure IsShowRec(SalesInvLine2: Record "Sales Invoice Line"): Boolean
    var
        IsHandled: Boolean;
        ReturnValue: Boolean;
    begin
        IsHandled := false;
        OnBeforeIsShowRec(Rec, SalesInvLine2, ReturnValue, IsHandled);
        if IsHandled then
            exit(ReturnValue);

#pragma warning disable AL0606
        with SalesInvLine2 do begin
#pragma warning restore AL0606
            QtyNotReturned := 0;
            if "Document No." <> SalesInvHeader."No." then
                SalesInvHeader.Get("Document No.");
            if SalesInvHeader."Prepayment Invoice" then
                exit(false);
            if RevQtyFilter then begin
                if SalesInvHeader."Currency Code" <> ToSalesHeader."Currency Code" then
                    exit(false);
                if Type = Type::" " then
                    exit("Attached to Line No." = 0);
            end;
            if Type <> Type::Item then
                exit(true);
            CalcShippedSaleNotReturned(QtyNotReturned, RevUnitCostLCY, FillExactCostReverse);
            if not RevQtyFilter then
                exit(true);
            exit(QtyNotReturned > 0);
        end;
    end;

    local procedure GetQtyReturned(): Decimal
    begin
        if (Rec.Type = Rec.Type::Item) and (Rec.Quantity - QtyNotReturned > 0) then
            exit(Rec.Quantity - QtyNotReturned);
        exit(0);
    end;

    /// <summary>
    /// OBTQtyBufferLine.
    /// </summary>
    /// <param name="FromOBTQtyBuffer">VAR Record "OBT Sales Line Copy Buffer".</param>
    procedure OBTQtyBufferLine(var FromOBTQtyBuffer: Record "OBT Get Post Buffer")
    begin
        TempOBTQtyBuffer.Reset;
        TempOBTQtyBuffer.SetFilter(TempOBTQtyBuffer."OBT Quantity", '<>%1', 0);
        FromOBTQtyBuffer.Reset;
        FromOBTQtyBuffer.DeleteAll;
        IF TempOBTQtyBuffer.FindSet then
            repeat
                FromOBTQtyBuffer := TempOBTQtyBuffer;
                FromOBTQtyBuffer.Insert;
            until TempOBTQtyBuffer.Next = 0;

    end;

    /// <summary>
    /// Initialize.
    /// </summary>
    /// <param name="NewToSalesHeader">Record "Sales Header".</param>
    /// <param name="NewRevQtyFilter">Boolean.</param>
    /// <param name="NewFillExactCostReverse">Boolean.</param>
    /// <param name="NewVisible">Boolean.</param>
    procedure Initialize(NewToSalesHeader: Record "Sales Header"; NewRevQtyFilter: Boolean; NewFillExactCostReverse: Boolean; NewVisible: Boolean)
    begin
        ToSalesHeader := NewToSalesHeader;
        RevQtyFilter := NewRevQtyFilter;
        FillExactCostReverse := NewFillExactCostReverse;
        IsVisible := NewVisible;

        if IsVisible then begin
            TempSalesInvLine.Reset();
            TempSalesInvLine.DeleteAll();
        end;
    end;

    /// <summary>
    /// GetSelectedLine.
    /// </summary>
    /// <param name="FromSalesInvLine">VAR Record "Sales Invoice Line".</param>
    procedure GetSelectedLine(var FromSalesInvLine: Record "Sales Invoice Line")
    begin
        FromSalesInvLine.Copy(Rec);
        CurrPage.SetSelectionFilter(FromSalesInvLine);
    end;

    local procedure ShowDocument()
    begin
        if not SalesInvHeader.Get(rec."Document No.") then
            exit;
        PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvHeader);
    end;

    local procedure ItemTrackingLines()
    var
        FromSalesInvLine: Record "Sales Invoice Line";
    begin
        GetSelectedLine(FromSalesInvLine);
        FromSalesInvLine.ShowItemTrackingLines();
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
            EXIT(OBTItemCalcAvail.OBTItemCalcAvailable(rec."No.", rec."Variant Code", ToSalesHeader."Location Code", Workdate));
    end;

    local procedure OBTItemComment(): Boolean
    begin
        if (rec.Type <> rec.Type::Item) then
            exit(false)
        else
            exit(OBTItemCalcAvail.OBTItemComment(rec."No."));

    end;

    local procedure OBTGetOrderQty(): Decimal
    begin
        clear(TempOBTQtyBuffer);
        if TempOBTQtyBuffer.get(113, rec."Document No.", rec."Line No.") then
            exit(TempOBTQtyBuffer."OBT Quantity")
        else
            exit(0);
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeIsShowRec(var SalesInvoiceLine: Record "Sales Invoice Line"; var SalesInvoiceLine2: Record "Sales Invoice Line"; var ReturnValue: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFindRecordOnBeforeFind(var SalesInvoiceLine: Record "Sales Invoice Line"; var Which: Text; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;
}
