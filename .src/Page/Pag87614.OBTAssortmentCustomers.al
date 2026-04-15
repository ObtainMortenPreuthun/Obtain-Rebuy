namespace Obtain.Rebuy;

/// <summary>
/// Page OBT Assortment Customers (ID 87614).
/// </summary>
page 87614 "OBT Assortment Customers"
{
    ApplicationArea = All;
    Caption = 'Assortment Customers';
    PageType = List;
    SourceTable = "OBT Customer Assortment";
    SourceTableView = sorting("OBT Assortment Code", "OBT Customer No.");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("OBT Assortment Code"; Rec."OBT Assortment Code")
                {
                }
                field("OBT Assortment Description"; Rec."OBT Assortment Description")
                {
                }
                field("OBT Customer No."; Rec."OBT Customer No.")
                {
                }
                field("OBT Customer Name"; rec."OBT Customer Name")
                {
                }
                field("OBT Customer E-mail"; Rec."OBT Customer E-mail")
                {
                }
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(PromotedSelectCustomers; SelectCustomers)
            {

            }
        }
        area(Processing)
        {
            action(SelectCustomers)
            {
                Caption = 'Assortment Customers';
                image = Insert;
                ToolTip = 'Select customers to add to the assortment.', Comment = '%';
                trigger OnAction()
                var
                    lAssortments: Record "OBT Assortment";
                    lAssortmentCode: Code[20];
                begin
                    rec.FilterGroup := 4;
                    if rec.GetFilter("OBT Assortment Code") = '' then
                        lAssortmentCode := rec."OBT Assortment Code"
                    else
                        lAssortmentCode := CopyStr(rec.GetFilter("OBT Assortment Code"), 1, MaxStrLen(lAssortmentCode));
                    rec.FilterGroup := 0;
                    lAssortments.SelectCustomers(lAssortmentCode);
                end;
            }
        }
    }
}