/// <summary>
/// Codeunit OBT Sales Header Function (ID 87629).
/// </summary>
codeunit 87629 "OBT Sales Header Function"
{
    /// <summary>
    /// OBTGetPstdDocLines.
    /// </summary>
    /// <param name="pSH">Record "Sales Header".</param>
    procedure OBTGetPstdDocLines(pSH: Record "Sales Header")
    var
        lCustomer: Record Customer;
        lSalesPostedDocLines: Page "OBT Copy Sales Doc. Lines";
    begin
        if not lCustomer.get(pSH."Sell-to Customer No.") then
            exit;
        lSalesPostedDocLines.SetToSalesHeader(pSH);
        lSalesPostedDocLines.SetRecord(lCustomer);
        lSalesPostedDocLines.LookupMode := true;
        if lSalesPostedDocLines.RunModal() = ACTION::LookupOK then
            lSalesPostedDocLines.CopyLineToDoc();
        Clear(lSalesPostedDocLines);
    end;

}
