namespace Obtain.Rebuy;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Foundation.UOM;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Utilities;

/// <summary>
/// Table OBT Sales Line Copy Buffer (ID 87622).
/// </summary>
table 87622 "OBT Sales Line Copy Buffer"
{
    Caption = 'Sales Line Copy Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "OBT Sal. Line Type Copy Buff")
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies the type of the document.', Comment = '%';
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            ToolTip = 'Specifies the customer number.', Comment = '%';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the document number.', Comment = '%';
            TableRelation =
IF ("Document Type" = const("Posted Invoice")) "Sales Invoice Header"
            else
            IF ("Document Type" = const("Posted Shipment")) "Sales Shipment Header"
            ELSE
            IF ("Document Type" = const("Posted Credit Memo")) "Sales Cr.Memo Header"
            ELSE
            IF ("Document Type" = const("Posted Return Rcpt.")) "Return Receipt Header"
            else
            "Sales Header";
            //TableRelation = "Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the line number.', Comment = '%';
        }
        field(5; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the type of the sales line.', Comment = '%';
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the number of the involved entry or record.', Comment = '%';
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account"),
                                     "System-Created Entry" = CONST(false)) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                               "Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"),
                                                                                                        "System-Created Entry" = CONST(true)) "G/L Account"
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST(Item),
                                                                                                                 "Document Type" = FILTER(<> "Credit Memo" & <> "Return Order")) Item WHERE(Blocked = CONST(false),
                                                                                                                                                                                       "Sales Blocked" = CONST(false))
            ELSE
            IF (Type = CONST(Item),
                                                                                                                                                                                                "Document Type" = FILTER("Credit Memo" | "Return Order")) Item WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the location from which the items were shipped.', Comment = '%';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(8; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            ToolTip = 'Specifies the posting group of the sales line.', Comment = '%';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Shipment Date"; Date)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Shipment Date';
            ToolTip = 'Specifies the date on which the items on the line are planned to be shipped.', Comment = '%';
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies a description of the item on the sales line.', Comment = '%';
            TableRelation = IF (Type = CONST("G/L Account"),
                                "System-Created Entry" = CONST(false)) "G/L Account".Name WHERE("Direct Posting" = CONST(true),
                                "Account Type" = CONST(Posting),
                                Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"), "System-Created Entry" = CONST(true)) "G/L Account".Name
            ELSE
            IF (Type = CONST(Item), "Document Type" = FILTER(<> "Credit Memo" & <> "Return Order")) Item.Description WHERE(Blocked = CONST(false),
                                                    "Sales Blocked" = CONST(false))
            ELSE
            IF (Type = CONST(Item), "Document Type" = FILTER("Credit Memo" | "Return Order")) Item.Description WHERE(Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Resource)) Resource.Name
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset".Description
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge".Description;
            ValidateTableRelation = False;
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            ToolTip = 'Specifies information in addition to the description.', Comment = '%';
        }
        field(13; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure';
            ToolTip = 'Specifies the unit of measure for the item on the sales line.', Comment = '%';
            TableRelation = IF (Type = FILTER(<> " ")) "Unit of Measure".Description;
            ValidateTableRelation = false;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the quantity on the sales line.', Comment = '%';
            DecimalPlaces = 0 : 5;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            ToolTip = 'Specifies whether the entry was created by the system.', Comment = '%';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document Type")
        {
            Clustered = true;
        }
    }
}
