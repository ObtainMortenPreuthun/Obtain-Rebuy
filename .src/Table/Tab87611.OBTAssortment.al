/// <summary>
/// Table OBT  (ID 87611).
/// </summary>
table 87611 "OBT Assortment"

{
    Caption = 'Assortment';
    LookupPageId = "OBT Assortments";
    DataCaptionFields = "OBT Assortment Code", "OBT Assortment Description";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "OBT Assortment Code"; Code[20])
        {
            Caption = 'Assortment Code';

        }
        field(5; "OBT Assortment Description"; Text[100])
        {
            Caption = 'Assortment Description';
        }
        field(11; "OBT Active from Date"; Date)
        {
            Caption = 'Assortment Active from Date';


        }

        field(12; "OBT Active to Date"; Date)
        {
            Caption = 'Assortment Active to Date';


        }
        field(13; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                Rec.ShowDocDim();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(14; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                Rec.OBTValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(15; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                Rec.OBTValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }


    }

    keys
    {
        key(PK; "OBT Assortment Code")
        {
            Clustered = true;
        }
    }
    var
        DimMgt: Codeunit DimensionManagement;
    /// <summary>
    /// SelectMultipleItems.
    /// </summary>
    /// <param name="pAssortmentCode">Code[20].</param>
    procedure SelectMultipleItems(pAssortmentCode: Code[20])
    var
        ItemListPage: Page "Item List";
        SelectionFilter: Text;
    begin

        SelectionFilter := ItemListPage.SelectActiveItems();

        if SelectionFilter <> '' then
            AddItems(SelectionFilter, pAssortmentCode);


    end;
    /// <summary>
    /// AddItems.
    /// </summary>
    /// <param name="pSelectionFilter">Text.</param>
    /// <param name="pAssortmentCode">Code[20].</param>
    procedure AddItems(pSelectionFilter: Text; pAssortmentCode: Code[20])
    var
        item: record Item;
        obtItemAssort: Record "OBT Item Assortment";
    begin
        item.reset;
        item.setfilter("No.", pSelectionFilter);
        if item.FindSet() then
            repeat
                if not obtItemAssort.get(item."No.", pAssortmentCode) then begin
                    obtItemAssort."OBT Item No." := item."No.";
                    obtItemAssort."OBT Assortment Code" := pAssortmentCode;
                    obtItemAssort.Insert;
                end;
            until item.next = 0;
    end;

    /// <summary>
    /// SelectCustomers.
    /// </summary>
    /// <param name="pAssortmentCode">Code[20].</param>
    procedure SelectCustomers(pAssortmentCode: Code[20])
    var
        Customer: Record Customer;
        CustomerList: page "Customer List";
        CustomerFilter: Text;
        CustomerAssortment: Record "OBT Customer Assortment";
    begin
        customerlist.SetTableView(Customer);
        CustomerList.LookupMode(true);
        if not (CustomerList.RunModal = Action::LookupOK) then
            exit;
        CustomerFilter := CustomerList.GetSelectionFilter();
        if CustomerFilter = '' then
            exit;
        Customer.RESET;
        Customer.SetFilter("No.", CustomerFilter);
        if Customer.FindSet() then
            repeat
                if not CustomerAssortment.get(Customer."No.", pAssortmentCode) then begin
                    CustomerAssortment."OBT Customer No." := Customer."No.";
                    CustomerAssortment."OBT Assortment Code" := pAssortmentCode;
                    CustomerAssortment.Insert;
                end;
            until Customer.next = 0;

    end;

    /// <summary>
    /// SelectContacts.
    /// </summary>
    /// <param name="pAssortmentCode">Code[20].</param>
    procedure SelectContacts(pAssortmentCode: Code[20])
    var
        Contact: Record Contact;
        ContactList: page "Contact List";
        ContactFilter: Text;
        ContactAssortment: Record "OBT Contact Assortment";
    begin
        ContactList.SetTableView(Contact);
        ContactList.LookupMode(true);
        if not (ContactList.RunModal = Action::LookupOK) then
            exit;
        ContactFilter := ContactList.GetSelectionFilter();
        if ContactFilter = '' then
            exit;
        Contact.RESET;
        Contact.SetFilter("No.", ContactFilter);
        if Contact.FindFirst() then
            repeat
                if not ContactAssortment.get(Contact."No.", pAssortmentCode) then begin
                    ContactAssortment."OBT Contact No." := Contact."No.";
                    ContactAssortment."OBT Assortment Code" := pAssortmentCode;
                    ContactAssortment.Insert;
                end;
            until Contact.next = 0;
    end;
    /// <summary>
    /// ShowDocDim.
    /// </summary>
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;

    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
        DimMgt.EditDimensionSet(
        Rec, "Dimension Set ID", StrSubstNo('%1', rec."OBT Assortment Code"),
        "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            Modify();
        end;
    end;
    /// <summary>
    /// ValidateShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Integer.</param>
    /// <param name="ShortcutDimCode">VAR Code[20].</param>
    procedure OBTValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if rec."OBT Assortment Code" <> '' then
            Modify();
        if OldDimSetID <> "Dimension Set ID" then begin
            if not IsNullGuid(Rec.SystemId) then
                Modify();
        end;
    end;

}
