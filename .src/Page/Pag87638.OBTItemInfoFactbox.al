/// <summary>
/// Page OBT Item Information Factbox (ID 87638).
/// </summary>
page 87638 "OBT Item Information Factbox"
{
    ApplicationArea = All;
    Caption = 'Item Information Factbox';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field(Inventory; Rec.Inventory)
            {
                ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                ApplicationArea = All;

            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ToolTip = 'Specifies how many units of the item are inbound on purchase orders, meaning listed on outstanding purchase order lines.';
                ApplicationArea = All;

            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ToolTip = 'Specifies how many units of the item are allocated to sales orders, meaning listed on outstanding sales orders lines.';
                ApplicationArea = All;
            }
        }
    }
    actions
    {

    }
    trigger OnAfterGetRecord()
    begin
        rec.CalcFields(Inventory, "Qty. on Purch. Order", "Qty. on Sales Order");
    end;

    local procedure ShowDetails()
    begin
        PAGE.Run(PAGE::"Item Card", Rec);
    end;
}
