/// <summary>
/// Page OBT Item Assortment Factbox (ID 87613).
/// </summary>
page 87619 "OBT Cont. Assortment Factbox"
{
    ApplicationArea = All;
    Caption = 'Contact Assortment Factbox';
    PageType = Listpart;
    SourceTable = "OBT Contact Assortment";
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
        Contactassortment: record "OBT Contact Assortment";
    begin
        Contactassortment.Reset();
        Contactassortment.SetCurrentKey("OBT Assortment Code", "OBT Contact No.");
        Contactassortment.SetRange("OBT Assortment Code", Rec."OBT Assortment Code");
        page.Run(0, Contactassortment);
    end;
}
