/// <summary>
/// Page OBT Item Assortment Factbox (ID 87613).
/// </summary>
page 87615 "OBT Cust. Assortment Factbox"
{
    ApplicationArea = All;
    Caption = 'Customer Assortment Factbox';
    PageType = Listpart;
    SourceTable = "OBT Customer Assortment";
    DataCaptionFields = "OBT Assortment Code";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("OBT Assortment Code"; Rec."OBT Assortment Code")
                {
                    Caption = 'Assortment Code';
                    ShowCaption = false;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ShowAssortment();
                    end;
                }
                field("OBT Assortment Description"; Rec."OBT Assortment Description")
                {
                    Caption = 'Assortment Description';
                    ShowCaption = false;
                    ApplicationArea = All;
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
        Customerassortment: record "OBT Customer Assortment";
    begin
        Customerassortment.Reset();
        Customerassortment.SetCurrentKey("OBT Assortment Code", "OBT Customer No.");
        Customerassortment.SetRange("OBT Assortment Code", Rec."OBT Assortment Code");
        page.Run(0, Customerassortment);
    end;
}
