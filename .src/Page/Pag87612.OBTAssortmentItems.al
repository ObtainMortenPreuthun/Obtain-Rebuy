/// <summary>
/// Page OBT Assortment Items (ID 87612).
/// </summary>
page 87612 "OBT Assortment Items"
{
    ApplicationArea = All;
    Caption = 'Assortment Items';
    PageType = List;
    SourceTable = "OBT Item Assortment";
    SourceTableView = sorting("OBT Assortment Code", "OBT Item No.");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("OBT Assortment Code"; Rec."OBT Assortment Code")
                {
                    ApplicationArea = all;
                }
                field("OBT Assortment Description"; Rec."OBT Assortment Description")
                {
                    ApplicationArea = all;
                }
                field("OBT Item No."; Rec."OBT Item No.")
                {
                    ApplicationArea = all;
                }
                field("OBT Item Description"; Rec."OBT Item Description")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(PromotedSelectItems; SelectItems)
            {

            }
        }
        area(Processing)
        {
            action(SelectItems)
            {
                ApplicationArea = All;
                Caption = 'Assortment Items';
                image = Insert;
                trigger OnAction()
                var
                    lAssortments: Record "OBT Assortment";
                    lAssortmentCode: Code[20];

                begin
                    rec.FilterGroup := 4;
                    if rec.GetFilter("OBT Assortment Code") = '' then
                        lAssortmentCode := rec."OBT Assortment Code"
                    else
                        lAssortmentCode := Copystr(rec.GetFilter("OBT Assortment Code"), 1, MaxStrLen(lAssortmentCode));
                    rec.FilterGroup := 0;
                    lAssortments.SelectMultipleItems(lAssortmentCode);
                end;
            }
        }
    }
}