namespace Obtain.Rebuy;

/// <summary>
/// Page OBT Item Assortment Factbox (ID 87613).
/// </summary>
page 87613 "OBT Item Assortment Factbox"
{
    ApplicationArea = All;
    Caption = 'Item Assortment Factbox';
    PageType = Listpart;
    SourceTable = "OBT Item Assortment";
    DataCaptionFields = "OBT Assortment Code";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("OBT Assortment Code"; Rec."OBT Assortment Code")
                {
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        ShowAssortment();
                    end;
                }
                field("OBT Assortment Description"; Rec."OBT Assortment Description")
                {
                    ShowCaption = false;
                    trigger OnDrillDown()
                    begin
                        ShowAssortment();
                    end;
                }
            }

        }
    }
    /// <summary>
    /// ShowAssortment.
    /// </summary>
    procedure ShowAssortment()
    var
        itemassortment: record "OBT Item Assortment";
    begin
        itemassortment.Reset();
        itemassortment.SetCurrentKey("OBT Assortment Code", "OBT Item No.");
        itemassortment.SetRange("OBT Assortment Code", Rec."OBT Assortment Code");
        page.Run(0, itemassortment);
    end;
}
