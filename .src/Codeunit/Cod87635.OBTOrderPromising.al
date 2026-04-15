namespace Obtain.Rebuy;

using Microsoft.Inventory.Availability;
using Microsoft.Inventory.Planning;
using Microsoft.Inventory.Requisition;
using Microsoft.Sales.Document;

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
        AvailabilityMgt.SetSourceRecord(TempOrderPromisingLine, pSH);
        AvailabilityMgt.CalcAvailableToPromise(TempOrderPromisingLine);
        AvailabilityMgt.UpdateSource(TempOrderPromisingLine);
        ReqLine.SetCurrentKey("Order Promising ID", "Order Promising Line ID", "Order Promising Line No.");
        ReqLine.SetRange("Order Promising ID", pSH."No.");
        ReqLine.ModifyAll("Accept Action Message", true);
    end;

    var
        TempOrderPromisingLine: record "Order Promising Line" temporary;
        ReqLine: Record "Requisition Line";
        AvailabilityMgt: Codeunit AvailabilityManagement;

}
