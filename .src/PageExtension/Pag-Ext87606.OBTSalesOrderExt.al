namespace Obtain.Rebuy;

using Microsoft.Sales.Document;

/// <summary>
/// PageExtension OBT Sales Order Ext (ID 87606) extends Record Sales Order.
/// </summary>
pageextension 87606 "OBT Sales Order Ext" extends "Sales Order"
{
    layout
    {


        addbefore(Control1901314507)
        {
            part(OBTSalesLineAttributesFactbox; "OBT Sales Line Attributes")
            {
                ApplicationArea = All;
                Caption = 'Item Attributes';
                Provider = SalesLines;
                SubPageLink = "OBT Sales Document Type" = FIELD("Document Type"), "OBT Sales Document No." = FIELD("Document No."),
                "OBT Sales Document Line No." = field("Line No.");
                UpdatePropagation = Both;

            }
        }
    }
    actions
    {

        addafter(CopyDocument_Promoted)
        {
            actionref(OBTGetPostedDocumentLines_Promoted; OBTGetPostedDocumentLines)
            {

            }
        }
        addafter(CopyDocument)
        {
            action(OBTGetPostedDocumentLines)
            {
                ApplicationArea = Suite;
                Caption = 'Get Document Lines';
                Ellipsis = true;
                Enabled = rec."No." <> '';
                Image = ReverseLines;
                ToolTip = 'Get Lines from Posted Documents';

                trigger OnAction()
                var
                    OBTCopySalesDoc: Codeunit "OBT Sales Header Function";
                begin
                    CLEAR(OBTCopySalesDoc);
                    OBTCopySalesDoc.OBTGetPstdDocLines(Rec);
                end;
            }

        }
        addafter("Pla&nning")
        {
            action(OBTATP)
            {
                ApplicationArea = All;
                Caption = 'ATP Test';
                Image = AvailableToPromise;
                ToolTip = 'Available to Promise calculation';

                trigger OnAction()
                var
                    lSH: Record "Sales Header";
                    OBTOrderPromising: Codeunit "OBT Order Promising";
                begin
                    lSH := rec;
                    OBTOrderPromising.SalesOrderPromising(lSH);
                end;
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.OBTSalesLineAttributesFactbox.page.LoadFactboxAttributesSL(Rec);
    end;
}
