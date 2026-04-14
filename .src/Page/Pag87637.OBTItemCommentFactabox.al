/// <summary>
/// Page OBT Item Comment Factbox (ID 87637).
/// </summary>
page 87637 "OBT Item Comment Factbox"
{
    ApplicationArea = All;
    Caption = 'Item Comment Factbox';
    PageType = ListPart;
    SourceTable = "Comment Line";
#pragma warning disable AL0603
    SourceTableView = sorting("Table Name", "No.", "Line No.") where("Table Name" = Const(3));
#pragma warning restore AL0603
    Editable = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}
