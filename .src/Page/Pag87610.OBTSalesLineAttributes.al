namespace Obtain.Rebuy;

using Microsoft.Sales.Document;

/// <summary>
/// Page OBT Sales Line Attributes (ID 87610).
/// </summary>
page 87610 "OBT Sales Line Attributes"
{

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTableTemporary = true;
    ApplicationArea = All;
    Caption = 'Item Attributes';
    SourceTable = "OBT Sales Line Attribute Value";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("OBT Sales Document Type"; Rec."OBT Sales Document Type")
                {
                    Visible = false;
                }
                field("OBT Sales Document No."; Rec."OBT Sales Document No.")
                {
                    Visible = false;
                }
                field("OBT Sales Document Line No."; Rec."OBT Sales Document Line No.")
                {
                    Visible = false;
                }
                field(Attribute; rec.OBTGetAttributeNameInCurrentLanguage())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attribute';
                    ToolTip = 'Specifies the name of the item attribute.';
                    Visible = TranslatedValuesVisible;
                }
                field(Value; rec.OBTGetValueInCurrentLanguage())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Value';
                    ToolTip = 'Specifies the value of the item attribute.';
                    Visible = TranslatedValuesVisible;
                }
                field("Attribute Name"; rec."OBT Attribute Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attribute';
                    Visible = NOT TranslatedValuesVisible;
                }
                field(RawValue; rec."OBT Value")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT TranslatedValuesVisible;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        TranslatedValuesVisible := ClientTypeManagement.GetCurrentClientType() <> CLIENTTYPE::Phone;
    end;


    /// <summary>
    /// LoadFactboxAttributesSL.
    /// </summary>
    /// <param name="pSH">Record "Sales Header".</param>
    procedure LoadFactboxAttributesSL(pSH: Record "Sales Header")
    Begin
        rec.OBTSLLoadItemAttributesFactBoxData(pSH);
    End;

    var


        ClientTypeManagement: Codeunit 4030;


    protected var
        TranslatedValuesVisible: Boolean;

}
