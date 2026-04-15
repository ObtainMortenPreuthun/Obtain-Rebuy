namespace Obtain.Rebuy;

/// <summary>
/// Page OBT Assortment Contacts (ID 87617).
/// </summary>
page 87617 "OBT Assortment Contacts"
{
    ApplicationArea = All;
    Caption = 'Assortment Contacts';
    PageType = List;
    SourceTable = "OBT Contact Assortment";
    SourceTableView = sorting("OBT Assortment Code", "OBT Contact No.");
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
                field("OBT Contact No."; Rec."OBT Contact No.")
                {
                }
                field("OBT Contact Name"; rec."OBT Contact Name")
                {
                }
                field("OBT Copntact E-mail"; Rec."OBT Copntact E-mail")
                {
                }
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(PromotedSelectContact; SelectContact)
            {

            }
        }


        area(Processing)
        {
            action(SelectContact)
            {
                Caption = 'Assortment Contacts';
                image = Insert;
                ToolTip = 'Select contacts to add to the assortment.', Comment = '%';
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
                    lAssortments.SelectContacts(lAssortmentCode);
                end;
            }
        }
    }
}