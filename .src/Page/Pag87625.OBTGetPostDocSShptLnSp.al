namespace Obtain.Rebuy;

using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;

/// <summary>
/// Page OBT Get Post.Doc - S.ShptLn Sp (ID 87625).
/// </summary>
page 87625 "OBT Get Post.Doc - S.ShptLn Sp"
{
    Caption = 'Lines';
    Editable = true;
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "Sales Shipment Line";
    SourceTableView = sorting("Document No.", "Line No.") Order(descending) where(Quantity = filter(<> 0), Type = filter(Item));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    HideValue = DocumentNoHideValue;
                    Lookup = false;
                    Width = 8;
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the number of the related document.';
                    Editable = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Width = 5;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    Editable = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                    Visible = false;
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer.';
                    Visible = false;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the line type.';
                    Editable = false;
                    Visible = true;
                    Width = 1;
                }
                field("No."; Rec."No.")
                {
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
                field(Nonstock; Rec.Nonstock)
                {
                    ToolTip = 'Specifies that the item on the sales line is a catalog item, which means it is not normally kept in inventory.';
                    Visible = false;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies either the name of or the description of the item, general ledger account or item charge.';
                    Editable = false;
                    Width = 20;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Visible = false;
                    ToolTip = 'Specifies information in addition to the description.';
                    Editable = false;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ToolTip = 'Specifies the code explaining why the item was returned.';
                    Visible = false;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location in which the invoice line was registered.';
                    Visible = false;
                    Editable = false;

                }
                field("Bin Code"; Rec."Bin Code")
                {
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
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    Editable = false;
                    Visible = true;
                    Width = 3;

                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item, general ledger account, or item charge on the line.';
                    Editable = false;
                    Visible = true;
                    Width = 4;

                }
                field(QuantiyToOrder; OBTQty)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order Quantity';
                    Editable = true;
                    Visible = true;
                    Width = 4;
                    DecimalPlaces = 0 : 2;
                    BlankZero = true;
                    ToolTip = 'Specifies the new quantity to re-order.';
                    trigger OnValidate()
                    begin
                        IF TempOBTQtyBuffer.GET(111, Rec."Document No.", rec."Line No.") then begin
                            TempOBTQtyBuffer."OBT Quantity" := OBTQty;
                            TempOBTQtyBuffer."OBT Item No." := rec."No.";
                            TempOBTQtyBuffer."OBT Unit of Measure Code" := rec."Unit of Measure Code";
                            TempOBTQtyBuffer."OBT Line Type" := rec.Type;
                            TempOBTQtyBuffer.Modify();
                        end else begin
                            clear(TempOBTQtyBuffer);
                            TempOBTQtyBuffer."OBT Table Number" := 111;
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
                    ToolTip = 'Specifies the quantity of the item in inventory at the location.';
                }
                field(Available; OBTAvailable)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available';
                    Editable = false;
                    Visible = true;
                    Width = 4;
                    DecimalPlaces = 0 : 2;
                    ToolTip = 'Specifies the available quantity of the item in the location of the order.';
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    ToolTip = 'Specifies the quantity of the shipped item that has been posted as shipped but that has not yet been posted as invoiced.';
                    Editable = false;
                    Visible = false;

                }
                field(QtyNotReturned; QtyNotReturned)
                {
                    Caption = 'Qty. Not Returned';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity from the posted document line that has been shipped to the customer and not returned by the customer.';
                    Editable = false;
                    Visible = false;

                }
                field(QtyReturned; GetQtyReturned())
                {
                    Caption = 'Qty. Returned';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity that was returned.';
                    Editable = false;
                    Visible = false;

                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    Visible = false;
                    Editable = false;

                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
                    Visible = false;
                    Editable = false;

                }
                field(RevUnitCostLCY; RevUnitCostLCY)
                {
                    AutoFormatType = 2;
                    Caption = 'Reverse Unit Cost (LCY)';
                    ToolTip = 'Specifies the unit cost that will appear on the new document lines.';
                    Visible = false;
                    Editable = false;

                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the number of the related job.';
                    Visible = false;
                    Editable = false;

                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ToolTip = 'Specifies the number of the blanket order that the record originates from.';
                    Visible = false;
                    Editable = false;

                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
                    Visible = false;
                    Editable = false;

                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied from.';
                    Visible = false;
                    Editable = false;

                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied to.';
                    Editable = false;
                    Visible = false;

                }

                field(ItemComment; OBTItemComment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Comment';
                    ToolTip = 'Specifies whether the item has a comment.';
                    Editable = false;
                    Visible = false;
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
                action(ShowDocument)
                {
                    Caption = 'Show Document';
                    Image = View;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Open the document that the selected line exists on.';

                    trigger OnAction()
                    begin
                        ShowPostedShipment();
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
                action(ItemTrackingLines)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Ctrl+Alt+I';
                    ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                    trigger OnAction()
                    begin
                        ShowShptItemTrackingLines();
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
        if not Visible then
            exit(false);

        if GoToFirstOnNextFind then begin
            Which := '-';
            GoToFirstOnNextFind := false;
        end;

        IsHandled := false;
        OnFindRecordOnBeforeFind(Rec, Which, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if Rec.Find(Which) then begin
            SalesShptLine := Rec;
            while true do begin
                ShowRec := IsShowRec(Rec);
                if ShowRec then
                    exit(true);
                if Rec.Next(1) = 0 then begin
                    Rec := SalesShptLine;
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

        SalesShptLine := Rec;
        repeat
#pragma warning disable AL0756
            NextSteps := rec.Next(Steps / Abs(Steps));
#pragma warning restore AL0756
            ShowRec := IsShowRec(Rec);
            if ShowRec then begin
                RealSteps := RealSteps + NextSteps;
                SalesShptLine := Rec;
            end;
        until (NextSteps = 0) or (RealSteps = Steps);
        Rec := SalesShptLine;
        rec.Find();
        exit(RealSteps);
    end;

    trigger OnOpenPage()
    begin
    end;

    procedure SetLocFilter(SetLocationFilter: Text)
    begin
        LocFilter := SetLocationFilter;
    end;

    var
        ToSalesHeader: Record "Sales Header";
        SalesShptLine: Record "Sales Shipment Line";
        TempSalesShptLine: Record "Sales Shipment Line" temporary;
        TempOBTQtyBuffer: Record "OBT Get Post Buffer" temporary;
        OBTItemCalcAvail: Codeunit "OBT Item CalcAvail ItemNo";
        QtyNotReturned: Decimal;
        RevUnitCostLCY: Decimal;
        OBTQty: Decimal;
        RevQtyFilter: Boolean;
        FillExactCostReverse: Boolean;
        Visible: Boolean;
        GoToFirstOnNextFind: Boolean;
        ShowRec: Boolean;
        DocumentNoHideValue: Boolean;
        LocFilter: Text;



    local procedure IsFirstDocLine(): Boolean
    var
        SalesShptLine2: Record "Sales Shipment Line";
        QtyNotReturned2: Decimal;
        RevUnitCostLCY2: Decimal;
    begin
        TempSalesShptLine.Reset();
        TempSalesShptLine.CopyFilters(Rec);
        TempSalesShptLine.SetRange("Document No.", rec."Document No.");
        if not TempSalesShptLine.FindLast() then begin
            QtyNotReturned2 := QtyNotReturned;
            RevUnitCostLCY2 := RevUnitCostLCY;
            SalesShptLine2.CopyFilters(Rec);
            SalesShptLine2.SetRange("Document No.", rec."Document No.");
            if not SalesShptLine2.FindLast() then
                exit(false);
            repeat
                ShowRec := IsShowRec(SalesShptLine2);
                if ShowRec then begin
                    TempSalesShptLine := SalesShptLine2;
                    TempSalesShptLine.Insert();
                end;
            until (SalesShptLine2.Next(-1) = 0) or ShowRec;
            QtyNotReturned := QtyNotReturned2;
            RevUnitCostLCY := RevUnitCostLCY2;
        end;

        exit(rec."Line No." = TempSalesShptLine."Line No.");
    end;

    local procedure IsShowRec(SalesShptLine2: Record "Sales Shipment Line"): Boolean
    var
        IsHandled: Boolean;
        ReturnValue: Boolean;
    begin
        IsHandled := false;
        OnBeforeIsShowRec(Rec, SalesShptLine2, ReturnValue, IsHandled);
        if IsHandled then
            exit(ReturnValue);

#pragma warning disable AL0606
        with SalesShptLine2 do begin
#pragma warning restore AL0606
            QtyNotReturned := 0;
            if RevQtyFilter and (Type = Type::" ") then
                exit("Attached to Line No." = 0);
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
        if (rec.Type = rec.Type::Item) and (rec.Quantity - QtyNotReturned > 0) then
            exit(rec.Quantity - QtyNotReturned);
        exit(0);
    end;

    /// <summary>
    /// Initialize.
    /// </summary>
    /// <param name="NewRevQtyFilter">Boolean.</param>
    /// <param name="NewFillExactCostReverse">Boolean.</param>
    /// <param name="NewVisible">Boolean.</param>
    procedure Initialize(NewToSalesHeader: Record "Sales Header"; NewRevQtyFilter: Boolean; NewFillExactCostReverse: Boolean; NewVisible: Boolean)
    begin
        ToSalesHeader := NewToSalesHeader;
        SetLocFilter(ToSalesHeader."Location Code");
        RevQtyFilter := NewRevQtyFilter;
        FillExactCostReverse := NewFillExactCostReverse;
        Visible := NewVisible;

        if Visible then begin
            TempSalesShptLine.Reset();
            TempSalesShptLine.DeleteAll();
            GoToFirstOnNextFind := true;
        end;
    end;

    /// <summary>
    /// GetSelectedLine.
    /// </summary>
    /// <param name="FromSalesShptLine">VAR Record "Sales Shipment Line".</param>
    procedure GetSelectedLine(var FromSalesShptLine: Record "Sales Shipment Line")
    begin
        FromSalesShptLine.Copy(Rec);
        CurrPage.SetSelectionFilter(FromSalesShptLine);
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

    local procedure ShowPostedShipment()
    var
        SalesShptHeader: Record "Sales Shipment Header";
    begin
        if not SalesShptHeader.Get(rec."Document No.") then
            exit;
        PAGE.Run(PAGE::"Posted Sales Shipment", SalesShptHeader);
    end;

    local procedure ShowShptItemTrackingLines()
    var
        FromSalesShptLine: Record "Sales Shipment Line";
    begin
        GetSelectedLine(FromSalesShptLine);
        FromSalesShptLine.ShowItemTrackingLines();
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
            EXIT(OBTItemCalcAvail.OBTItemCalcAvailable(rec."No.", rec."Variant Code", LocFilter, Workdate));

    end;

    local procedure OBTItemComment(): Boolean
    begin
        IF (rec.Type <> rec.Type::Item) then
            exit(false)
        else
            exit(OBTItemCalcAvail.OBTItemComment(rec."No."));

    end;

    local procedure OBTGetOrderQty(): Decimal
    begin
        clear(TempOBTQtyBuffer);
        IF TempOBTQtyBuffer.get(111, rec."Document No.", rec."Line No.") THEN
            exit(TempOBTQtyBuffer."OBT Quantity")
        else
            exit(0);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeIsShowRec(var SalesShipmentLine: Record "Sales Shipment Line"; var SalesShipmentLine2: Record "Sales Shipment Line"; var ReturnValue: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFindRecordOnBeforeFind(var SalesShipmentLine: Record "Sales Shipment Line"; var Which: Text; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;
}

