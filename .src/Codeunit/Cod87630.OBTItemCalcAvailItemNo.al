/// <summary>
/// Codeunit OBT Item CalcAvail ItemNo (ID 87630).
/// </summary>
codeunit 87630 "OBT Item CalcAvail ItemNo"
{
    /// <summary>
    /// OBTItemCalcAvailable.
    /// </summary>
    /// <param name="pItemNo">Code[20].</param>
    /// <param name="pVariantCode">Code[10].</param>
    /// <param name="pLocationCode">Code[10].</param>
    /// <param name="pShipmentDate">Date.</param>
    /// <returns>Return value of type Decimal.</returns>
    procedure OBTItemCalcAvailable(pItemNo: Code[20]; pVariantCode: Code[10]; pLocationFilter: Text; pShipmentDate: Date): Decimal
    var
        LookaheadDateformula: DateFormula;
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: Enum "Analysis Period Type";
        lAvaildate: date;
    begin
        if gitem.get(pItemNo) then begin
            gitem.reset;
            gitem.Setrange("Date Filter");
            gitem.SetRange("Variant Filter", pVariantCode);
            gitem.SetFilter("Location Filter", pLocationFilter);
            gitem.setrange("Drop Shipment Filter", False);
            //Evaluate(LookaheadDateformula, '<0D>');
            //lAvaildate := WorkDate();
            gitem.CalcFields(Inventory, "Qty. on Sales Order");
            exit(gItem.Inventory - gItem."Qty. on Sales Order");
            //exit(
            //    gAvailableToPromise.CalcQtyAvailabletoPromise(
            //   gItem,
            //   GrossRequirement,
            //   ScheduledReceipt,
            //   lAvaildate,
            //   PeriodType,
            //   LookaheadDateformula))
        end;
    end;

    procedure OBXInventory(pItemNo: Code[20]; pVariantCode: Code[10]; pLocationCode: Code[10]): Decimal
    var
        Item: Record Item;
    begin
        if Item.Get(pItemNo) then begin
            Item.SetRange("Variant Filter", pVariantCode);
            Item.SetRange("Location Filter", pLocationCode);
            Item.CalcFields("Inventory");
            exit(Item."Inventory");
        end;

        exit(0);
    end;

    /// <summary>
    /// OBTItemComment.
    /// </summary>
    /// <param name="pItemNo">Code[20].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure OBTItemComment(pItemNo: Code[20]): Boolean;
    var
        lCommentLine: Record "Comment Line";
    begin
        lCommentLine.Reset();
        lCommentLine.SetRange("Table Name", enum::"Comment Line Table Name"::Item);
        lCommentLine.SetRange("No.", pItemNo);
        if lCommentLine.IsEmpty then
            exit(false)
        else
            exit(true);


    end;

    /// <summary>
    /// OBTItemCommentDrillDown.
    /// </summary>
    /// <param name="pItemNo">Code[20].</param>
    /// <returns>Return value of type Boolean.</returns>


    var
        gItem: Record Item;
        gAvailableToPromise: Codeunit "Available to Promise";
        gUOMMgt: Codeunit "Unit of Measure Management";
}

