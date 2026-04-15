/// <summary>
/// Codeunit OBT Order Promising (ID 87520).
/// </summary>
codeunit 87635 "OBT Order Promising"
{

    trigger OnRun()
    begin

    end;

    /// <summary>
    /// SalesOrderPromising.
    /// </summary>
    /// <param name="pSH">Record "Sales Header".</param>
    procedure SalesOrderPromising(pSH: Record "Sales Header")
    begin
        if psh."Document Type" <> psh."Document Type"::Order then
            exit;
#if not CLEAN28
        AvailabilityMgt.SetSalesHeader(OrderPromisingLine, psh);
#else
        AvailabilityMgt.SetSourceRecord(OrderPromisingLine, pSH);
#endif
        AvailabilityMgt.CalcAvailableToPromise(OrderPromisingLine);
        AvailabilityMgt.UpdateSource(OrderPromisingLine);
        ReqLine.SetCurrentKey("Order Promising ID", "Order Promising Line ID", "Order Promising Line No.");
        ReqLine.SetRange("Order Promising ID", pSH."No.");
        ReqLine.ModifyAll("Accept Action Message", true);

    end;

    var
        OrderPromisingLine: record "Order Promising Line" temporary;
        AvailabilityMgt: Codeunit AvailabilityManagement;
        ReqLine: Record "Requisition Line";

}
