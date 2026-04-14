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
                    ApplicationArea = all;
                }
                field("OBT Assortment Description"; Rec."OBT Assortment Description")
                {
                    ApplicationArea = all;
                }
                field("OBT Contact No."; Rec."OBT Contact No.")
                {
                    ApplicationArea = all;
                }
                field("OBT Contact Name"; rec."OBT Contact Name")
                {
                    ApplicationArea = all;
                }
                field("OBT Copntact E-mail"; Rec."OBT Copntact E-mail")
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
            actionref(PromotedSelectContact; SelectContact)
            {

            }
        }


        area(Processing)
        {
            action(SelectContact)
            {
                ApplicationArea = All;
                Caption = 'Assortment Contacts';
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
                    lAssortments.SelectContacts(lAssortmentCode);
                end;
            }
        }
    }
}