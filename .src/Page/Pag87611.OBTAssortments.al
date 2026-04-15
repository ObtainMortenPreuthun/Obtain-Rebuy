namespace Obtain.Rebuy;

using Microsoft.Finance.Dimension;

/// <summary>
/// Page OBT Assortments (ID 87611).
/// </summary>
page 87611 "OBT Assortments"
{
    ApplicationArea = All;
    Caption = 'Assortments';
    PageType = List;
    SourceTable = "OBT Assortment";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("OBT Assortment Code"; Rec."OBT Assortment Code")
                {
                    NotBlank = false;
                }
                field("OBT Assortment Description"; Rec."OBT Assortment Description")
                {
                }
                field("OBT Active from Date"; Rec."OBT Active from Date")
                {
                }
                field("OBT Active to Date"; Rec."OBT Active to Date")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    trigger OnValidate()
                    begin
                        OBTShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    trigger OnValidate()
                    begin
                        OBTShortcutDimension2CodeOnAfterV();
                    end;
                }
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(PromotedShowItems; ShowItems)
            {

            }
            actionref(PromotedShowCustomers; ShowCustomers)
            {

            }
            actionref(PromotedShowContacts; ShowContacts)
            {

            }
            actionref(PromotedDimensions; Dimensions)
            {

            }
        }
        area(Navigation)
        {
            action(ShowItems)
            {
                Caption = 'Show Items';
                Image = ShowList;
                ToolTip = 'Show the items that belong to this assortment.', Comment = '%';
                RunObject = Page "OBT Assortment Items";
                RunPageLink = "OBT Assortment Code" = FIELD("OBT Assortment Code");
                RunPageView = SORTING("OBT Assortment Code", "OBT Item No.");
            }
            action(ShowCustomers)
            {
                Caption = 'Show Customers';
                Image = ShowList;
                ToolTip = 'Show the customers that belong to this assortment.', Comment = '%';
                RunObject = Page "OBT Assortment Customers";
                RunPageLink = "OBT Assortment Code" = FIELD("OBT Assortment Code");
                RunPageView = SORTING("OBT Assortment Code", "OBT Customer No.");
            }
            action(ShowContacts)
            {
                Caption = 'Show Contacts';
                Image = ShowList;
                ToolTip = 'Show the contacts that belong to this assortment.', Comment = '%';
                RunObject = Page "OBT Assortment Contacts";
                RunPageLink = "OBT Assortment Code" = FIELD("OBT Assortment Code");
                RunPageView = SORTING("OBT Assortment Code", "OBT Contact No.");
            }
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = Dimensions;
                Caption = 'Dimensions';
                Enabled = rec."OBT Assortment Code" <> '';
                Image = Dimensions;
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                begin
                    Rec.ShowDocDim();
                    CurrPage.SaveRecord();
                end;
            }
        }

    }
    local procedure OBTShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure OBTShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update();
    end;
}
