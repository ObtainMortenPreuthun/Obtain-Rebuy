namespace Obtain.Rebuy;

using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Sales.History;

/// <summary>
/// Page OBT Get Post.Doc-S.Cr.MemoLn S (ID 87628).
/// </summary>
page 87628 "OBT Get Post.Doc-S.Cr.MemoLn S"
{
    Caption = 'Lines';
    Editable = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Sales Cr.Memo Line";
    SourceTableView = sorting("Document No.", "Line No.") Order(descending);
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
                    ApplicationArea = Basic, Suite;
                    HideValue = DocumentNoHideValue;
                    Lookup = false;
                    StyleExpr = 'Strong';
                    ToolTip = 'Specifies the credit memo number.';
                    Editable = false;
                }
                field(CrMemoPostingDate; SalesCrMemoHeader."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the posting date of the record.';
                    Editable = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                    Visible = false;
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
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the line type.';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
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
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the item or general ledger account, or some descriptive text.';
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic, Suite;
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the location in which the credit memo line was registered.';
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
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of units of the item specified on the line.';
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
                        IF TempOBTQtyBuffer.GET(115, Rec."Document No.", rec."Line No.") then begin
                            TempOBTQtyBuffer."OBT Quantity" := OBTQty;
                            TempOBTQtyBuffer."OBT Item No." := rec."No.";
                            TempOBTQtyBuffer."OBT Unit of Measure Code" := rec."Unit of Measure Code";
                            TempOBTQtyBuffer."OBT Line Type" := rec.Type;
                            TempOBTQtyBuffer.Modify();
                        end else begin
                            clear(TempOBTQtyBuffer);
                            TempOBTQtyBuffer."OBT Table Number" := 115;
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
                field(UnitPrice; UnitPrice)
                {
                    ApplicationArea = SalesReturnOrder;
                    AutoFormatExpression = SalesCrMemoHeader."Currency Code";
                    AutoFormatType = 2;
                    Caption = 'Unit Price';
                    ToolTip = 'Specifies the item''s unit price.';
                    Visible = false;
                    Editable = false;
                }
                field(LineAmount; LineAmount)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatExpression = SalesCrMemoHeader."Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Line Amount';
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                    Editable = false;
                }
                field(CrMemoCurrencyCode; SalesCrMemoHeader."Currency Code")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the code for the currency that amounts are shown in.';
                    Visible = false;
                    Editable = false;
                }
                field(CrMemoPricesInclVAT; SalesCrMemoHeader."Prices Including VAT")
                {
                    ApplicationArea = SalesReturnOrder;
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
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    Visible = false;
                    Editable = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                    Visible = false;
                    Editable = false;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = SalesReturnOrder;
                    ToolTip = 'Specifies the total calculated invoice discount amount for the line.';
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
                }
                field(Available; OBTAvailable)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available';
                    ToolTip = 'Specifies the available quantity of the item in the location of the order.';
                    Editable = false;
                    DecimalPlaces = 0 : 2;

                }
                field(ItemComment; OBTItemComment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Comment';
                    ToolTip = 'Specifies whether the item has a comment.';
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
        Result: Boolean;
    begin
        if GoToFirstOnNextFind then begin
            Which := '-';
            GoToFirstOnNextFind := false;
        end;

        IsHandled := false;
        OnFindRecordOnBeforeFind(Rec, Which, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if Rec.Find(Which) then begin
            SalesCrMemoLine := Rec;
            while true do begin
                ShowRec := IsShowRec(Rec);
                if ShowRec then
                    exit(true);
                if Rec.Next(1) = 0 then begin
                    Rec := SalesCrMemoLine;
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

        SalesCrMemoLine := Rec;
        repeat
#pragma warning disable AL0756
            NextSteps := rec.Next(Steps / Abs(Steps));
#pragma warning restore AL0756
            ShowRec := IsShowRec(Rec);
            if ShowRec then begin
                RealSteps := RealSteps + NextSteps;
                SalesCrMemoLine := Rec;
            end;
        until (NextSteps = 0) or (RealSteps = Steps);
        Rec := SalesCrMemoLine;
        rec.Find();
        exit(RealSteps);
    end;

    trigger OnOpenPage()
    begin
        if Rec.FindFirst() then;
    end;

    procedure GoToFirst()
    begin
        GoToFirstOnNextFind := true;
    end;

    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        TempSalesCrMemoLine: Record "Sales Cr.Memo Line" temporary;
        TempOBTQtyBuffer: Record "OBT Get Post Buffer" temporary;
        OBTItemCalcAvail: Codeunit "OBT Item CalcAvail ItemNo";
        UnitPrice: Decimal;
        LineAmount: Decimal;
        OBTQty: Decimal;
        GoToFirstOnNextFind: Boolean;
        DocumentNoHideValue: Boolean;
        ShowRec: Boolean;

    local procedure IsFirstDocLine(): Boolean
    begin
        TempSalesCrMemoLine.Reset();
        TempSalesCrMemoLine.CopyFilters(Rec);
        TempSalesCrMemoLine.SetRange("Document No.", rec."Document No.");
        if not TempSalesCrMemoLine.FindFirst() then begin
            SalesCrMemoLine.CopyFilters(Rec);
            SalesCrMemoLine.SetRange("Document No.", rec."Document No.");
            if not SalesCrMemoLine.FindFirst() then
                exit(false);
            TempSalesCrMemoLine := SalesCrMemoLine;
            TempSalesCrMemoLine.Insert();
        end;

        if rec."Document No." <> SalesCrMemoHeader."No." then
            SalesCrMemoHeader.Get(rec."Document No.");

        UnitPrice := rec."Unit Price";
        LineAmount := rec."Line Amount";

        exit(rec."Line No." = TempSalesCrMemoLine."Line No.");
    end;

    local procedure IsShowRec(SalesCrMemoLine2: Record "Sales Cr.Memo Line"): Boolean
    var
        IsHandled: Boolean;
        ReturnValue: Boolean;
    begin
        IsHandled := false;
        OnBeforeIsShowRec(Rec, SalesCrMemoLine2, ReturnValue, IsHandled);
        if IsHandled then
            exit(ReturnValue);

#pragma warning disable AL0606
        with SalesCrMemoLine2 do begin
#pragma warning restore AL0606
            if "Document No." <> SalesCrMemoHeader."No." then
                SalesCrMemoHeader.Get("Document No.");
            if SalesCrMemoHeader."Prepayment Credit Memo" then
                exit(false);
            exit(true);
        end;
    end;

    /// <summary>
    /// GetSelectedLine.
    /// </summary>
    /// <param name="FromSalesCrMemoLine">VAR Record "Sales Cr.Memo Line".</param>
    procedure GetSelectedLine(var FromSalesCrMemoLine: Record "Sales Cr.Memo Line")
    begin
        FromSalesCrMemoLine.Copy(Rec);
        CurrPage.SetSelectionFilter(FromSalesCrMemoLine);
    end;

    local procedure ShowDocument()
    begin
        if not SalesCrMemoHeader.Get(rec."Document No.") then
            exit;
        PAGE.Run(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
    end;

    local procedure ItemTrackingLines()
    var
        FromSalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        GetSelectedLine(FromSalesCrMemoLine);
        FromSalesCrMemoLine.ShowItemTrackingLines();
    end;

    local procedure DocumentNoOnFormat()
    begin
        if not IsFirstDocLine() then
            DocumentNoHideValue := true;
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

    local procedure OBTGetOrderQty(): Decimal
    begin
        clear(TempOBTQtyBuffer);
        IF TempOBTQtyBuffer.get(115, rec."Document No.", rec."Line No.") THEN
            exit(TempOBTQtyBuffer."OBT Quantity")
        else
            exit(0);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeIsShowRec(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; var SalesCrMemoLine2: Record "Sales Cr.Memo Line"; var ReturnValue: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFindRecordOnBeforeFind(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; var Which: Text; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;
}
