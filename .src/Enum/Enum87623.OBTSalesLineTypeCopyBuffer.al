/// <summary>
/// Enum OBT Sal. Line Type Copy Buff (ID 87623).
/// </summary>
enum 87623 "OBT Sal. Line Type Copy Buff"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "Quote") { Caption = 'Quote'; }
    value(1; "Order") { Caption = 'Order'; }
    value(2; "Invoice") { Caption = 'Invoice'; }
    value(3; "Credit Memo") { Caption = 'Credit Memo'; }
    value(4; "Blanket Order") { Caption = 'Blanket Order'; }
    value(5; "Return Order") { Caption = 'Return Order'; }
    value(21; "Posted Shipment") { Caption = 'Posted Shipment'; }
    value(22; "Posted Invoice") { Caption = 'Posted Invoice'; }
    value(23; "Posted Return Rcpt.") { Caption = 'Posted Return Rcpt.'; }
    value(24; "Posted Credit Memo") { Caption = 'Posted Credit Memo'; }

}
