/// <summary>
/// Page OBT  (ID 87624).
/// </summary>
page 87624 "OBT Copy Sales Doc. Lines"
{
    Caption = 'Copy Lines';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = true;
    PageType = ListPlus;
    SaveValues = true;
    SourceTable = Customer;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                Visible = False;
                field(ShowRevLine; ShowRevLinesOnly)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Reversible Lines Only';
                    Enabled = ShowRevLineEnable;
                    ToolTip = 'Specifies if only lines with quantities that are available to be reversed are shown. For example, on a posted sales invoice with an original quantity of 20, and 15 of the items have already been returned, the quantity that is available to be reversed on the posted sales invoice is 5.';
                    Visible = False;

                    trigger OnValidate()
                    begin
                        case CurrentMenuType of
                            0:
                                CurrPage.PostedShpts.PAGE.Initialize(
                                  ToSalesHeader, ShowRevLinesOnly,
                                  CopyDocMgt.IsSalesFillExactCostRevLink(
                                    ToSalesHeader, CurrentMenuType, ToSalesHeader."Currency Code"), true);
                            1:
                                CurrPage.PostedInvoices.PAGE.Initialize(
                                  ToSalesHeader, ShowRevLinesOnly,
                                  CopyDocMgt.IsSalesFillExactCostRevLink(
                                    ToSalesHeader, CurrentMenuType, ToSalesHeader."Currency Code"), true);
                        end;
                        ShowRevLinesOnlyOnAfterValidat();
                    end;
                }
                field(OriginalQuantity; OriginalQuantity)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Return Original Quantity';
                    ToolTip = 'Specifies whether to use the original quantity to receive quantities associated with specific shipments. For example, on a posted sales invoice with an original quantity of 20, you can match the 20 items with a specific shipment.';
                    Visible = False;
                }
            }
            group(Control19)
            {
                ShowCaption = false;
                group(Control9)
                {
                    ShowCaption = false;
                    field(PostedShipmentsBtn; CurrentMenuTypeOpt)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionClass = OptionCaptionServiceTier();
                        OptionCaption = 'Posted Shipments,Posted Invoices,Posted Return Receipts,Posted Cr. Memos,Items,Assortment Items';

                        trigger OnValidate()
                        begin
                            if CurrentMenuTypeOpt = CurrentMenuTypeOpt::x5 then
                                x5CurrentMenuTypeOptOnValidate();
                            if CurrentMenuTypeOpt = CurrentMenuTypeOpt::x4 then
                                x4CurrentMenuTypeOptOnValidate();
                            if CurrentMenuTypeOpt = CurrentMenuTypeOpt::x3 then
                                x3CurrentMenuTypeOptOnValidate();
                            if CurrentMenuTypeOpt = CurrentMenuTypeOpt::x2 then
                                x2CurrentMenuTypeOptOnValidate();
                            if CurrentMenuTypeOpt = CurrentMenuTypeOpt::x1 then
                                x1CurrentMenuTypeOptOnValidate();
                            if CurrentMenuTypeOpt = CurrentMenuTypeOpt::x0 then
                                x0CurrentMenuTypeOptOnValidate();
                        end;
                    }

                    field(LocationCode; ToSalesHeader."Location Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Location Filter';
                        ToolTip = 'The Location filter used when calculation available quantity';
                        Visible = true;
                        Editable = false;
                    }
                    field("STRSUBSTNO('(%1)',""No. of Pstd. Shipments"")"; StrSubstNo('(%1)', rec."No. of Pstd. Shipments"))
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '&Posted Shipments';
                        Editable = false;
                        ToolTip = 'Specifies the lines that represent posted shipments.';
                    }
                    field(NoOfPostedInvoices; StrSubstNo('(%1)', rec."No. of Pstd. Invoices" - NoOfPostedPrepmtInvoices()))
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted I&nvoices';
                        Editable = false;
                        ToolTip = 'Specifies the lines that represent posted invoices.';
                    }
                    field("STRSUBSTNO('(%1)',""No. of Pstd. Return Receipts"")"; StrSubstNo('(%1)', rec."No. of Pstd. Return Receipts"))
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Ret&urn Receipts';
                        Editable = false;
                        ToolTip = 'Specifies the lines that represent posted return receipts.';
                    }
                    field(NoOfPostedCrMemos; StrSubstNo('(%1)', rec."No. of Pstd. Credit Memos" - NoOfPostedPrepmtCrMemos()))
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Cr. &Memos';
                        Editable = false;
                        ToolTip = 'Specifies the lines that represent posted sales credit memos.';
                    }
                    field(NoOfItems; StrSubstNo('(%1)', FORMAT(gitems.Count)))
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Items';
                        Editable = false;
                        ToolTip = 'Items';
                    }
                    field(NoOfItemsAss; StrSubstNo('(%1)', FORMAT(gitemsAssortment.Count)))
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Items Assortment';
                        Editable = false;
                        ToolTip = 'Items';
                    }
                    field(CurrentMenuTypeValue; CurrentMenuType)
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                        Caption = 'Menu Type';
                        ToolTip = 'Current Menu Type';
                    }
                }
            }
            group(Control18)
            {
                ShowCaption = false;
                part(PostedInvoices; "OBT Get Post.Doc - S.InvLn Sub")
                {
                    ApplicationArea = All;
                    SubPageLink = "Sell-to Customer No." = FIELD("No.");
                    SubPageView = SORTING("Sell-to Customer No.");
                    Visible = PostedInvoicesVisible;
                }
                part(PostedShpts; "OBT Get Post.Doc - S.ShptLn Sp")
                {
                    ApplicationArea = All;
                    SubPageLink = "Sell-to Customer No." = FIELD("No.");
                    SubPageView = SORTING("Sell-to Customer No.");
                    Visible = PostedShptsVisible;
                }
                part(PostedCrMemos; "OBT Get Post.Doc-S.Cr.MemoLn S")
                {
                    ApplicationArea = All;
                    SubPageLink = "Sell-to Customer No." = FIELD("No.");
                    SubPageView = SORTING("Sell-to Customer No.");
                    Visible = PostedCrMemosVisible;
                }
                part(PostedReturnRcpts; "OBT Get Pst.Doc-RtrnRcptLn Sub")
                {
                    ApplicationArea = All;
                    SubPageLink = "Sell-to Customer No." = FIELD("No.");
                    SubPageView = SORTING("Sell-to Customer No.");
                    Visible = PostedReturnRcptsVisible;
                }
                part(OBTItems; "OBT Item List")
                {
                    ApplicationArea = All;
                    SubPageView = sorting("No.");
                    SubPageLink = "OBT Assortment Filter" = field("OBT Assortment Filter");
                    Visible = gItemListVisible;
                }
                part(OBTItemsAssortment; "OBT Item List Assortment")
                {
                    ApplicationArea = All;
                    SubPageView = sorting("No.");
                    SubPageLink = "OBT Assortment Filter" = field("OBT Assortment Filter");
                    Visible = gItemListVisibleAssortment;
                }
            }
        }
        area(factboxes)
        {
            Part("OBTItemInfo PostedShpts"; "OBT Item Information Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Information';
                Visible = PostedShptsVisible;
                Provider = PostedShpts;
                SubPageLink = "No." = field("No.");

            }
            part("Item Comment PostedShpts"; "OBT Item Comment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Comment';
                Provider = PostedShpts;
                SubPageLink = "No." = field("No."),
#pragma warning disable AL0603
            "Table Name" = Const(3);
#pragma warning restore AL0603
                Visible = PostedShptsVisible;
            }
            Part("OBTItemInfo PostedInvoices"; "OBT Item Information Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Information';
                Visible = PostedInvoicesVisible;
                Provider = PostedInvoices;
                SubPageLink = "No." = field("No.");

            }
            part("Item Comment PostedInvoices"; "OBT Item Comment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Comment';
                Provider = PostedInvoices;
                SubPageLink = "No." = field("No."),
#pragma warning disable AL0603
            "Table Name" = Const(3);
#pragma warning restore AL0603                
                Visible = PostedInvoicesVisible;
            }
            Part("OBTItemInfo PostedCrMemos"; "OBT Item Information Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Information';
                Visible = PostedCrMemosVisible;
                Provider = PostedCrMemos;
                SubPageLink = "No." = field("No.");

            }
            part("Item Comment PostedCrMemos"; "OBT Item Comment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Comment';
                Provider = PostedCrMemos;
                SubPageLink = "No." = field("No."),
#pragma warning disable AL0603
            "Table Name" = Const(3);
#pragma warning restore AL0603                
                Visible = PostedCrMemosVisible;
            }
            Part("OBTItemInfo PostedReturnRcpts"; "OBT Item Information Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Information';
                Visible = PostedReturnRcptsVisible;
                Provider = PostedReturnRcpts;
                SubPageLink = "No." = field("No.");

            }
            part("Item Comment PostedReturnRcpts"; "OBT Item Comment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Comment';
                Provider = PostedReturnRcpts;
                SubPageLink = "No." = field("No."),
#pragma warning disable AL0603
            "Table Name" = Const(3);
#pragma warning restore AL0603                
                Visible = PostedReturnRcptsVisible;
            }
            Part("OBTItemInfo OBTItems"; "OBT Item Information Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Information';
                Visible = gItemListVisible;
                Provider = OBTItems;
                SubPageLink = "No." = field("No.");

            }
            part("Item Comment OBTItems"; "OBT Item Comment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Comment';
                Provider = OBTItems;
                SubPageLink = "No." = field("No."),
#pragma warning disable AL0603
            "Table Name" = Const(3);
#pragma warning restore AL0603                
                Visible = gItemListVisible;
            }
            Part("OBTItemInfo OBTItemsAssortment"; "OBT Item Information Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Information';
                Visible = gItemListVisibleAssortment;
                Provider = OBTItemsAssortment;
                SubPageLink = "No." = field("No.");

            }
            part("Item Comment OBTItemsAssortment"; "OBT Item Comment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Item Comment';
                Provider = OBTItemsAssortment;
                SubPageLink = "No." = field("No."),
#pragma warning disable AL0603
            "Table Name" = Const(3);
#pragma warning restore AL0603                
                Visible = gItemListVisibleAssortment;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        rec.CalcFields(
          "No. of Pstd. Shipments", "No. of Pstd. Invoices",
          "No. of Pstd. Return Receipts", "No. of Pstd. Credit Memos");
        SetAssortmentFilterItem(gItemsAssortment);

        CurrentMenuTypeOpt := CurrentMenuType;
    end;

    trigger OnInit()
    begin
        ShowRevLineEnable := true;
    end;

    trigger OnOpenPage()
    begin
        CurrentMenuType := 1;
        ToSalesHeader.Get(ToSalesHeader."Document Type"::Order, ToSalesHeader."No.");
        ChangeSubMenu(CurrentMenuType);
        rec.SetRange("No.", rec."No.");
    end;

    var
        OBTGetPostBufferTemp: Record "OBT Get Post Buffer" temporary;
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        OldMenuType: Integer;
        LinesNotCopied: Integer;
        ShowRevLinesOnly: Boolean;
        MissingExCostRevLink: Boolean;
        Text000: Label 'The document lines that have a G/L account that does not allow direct posting have not been copied to the new document.';
        OriginalQuantity: Boolean;
        Text002: Label 'Document Type Filter';
        CurrentMenuTypeOpt: Option x0,x1,x2,x3,x4,x5;
        ItemList2: Page "OBT Item List2";


    protected var
        gItems: Record item;
        gItemsAssortment: Record item;

        ToSalesHeader: Record "Sales Header";
        PostedShptsVisible: Boolean;
        PostedInvoicesVisible: Boolean;
        PostedReturnRcptsVisible: Boolean;
        PostedCrMemosVisible: Boolean;
        ShowRevLineEnable: Boolean;
        CurrentMenuType: Integer;
        gItemListVisible: Boolean;
        gItemListVisibleAssortment: Boolean;

    /// <summary>
    /// CopyLineToDoc.
    /// </summary>
    procedure CopyLineToDoc()
    var
        FromSalesShptLine: Record "Sales Shipment Line";
        FromSalesInvLine: Record "Sales Invoice Line";
        FromSalesCrMemoLine: Record "Sales Cr.Memo Line";
        FromReturnRcptLine: Record "Return Receipt Line";
        FromItem: record Item;
        IsHandled: Boolean;
    begin
        OnBeforeCopyLineToDoc(CopyDocMgt, CurrentMenuType);

        ToSalesHeader.TestField(Status, ToSalesHeader.Status::Open);
        LinesNotCopied := 0;
        //message('CurrentMenuType: %1', CurrentMenuType);
        case CurrentMenuType of
            0:
                begin
                    CurrPage.PostedShpts.page.OBTQtyBufferLine(OBTGetPostBufferTemp);
                    AddLinesOBTBuffer(OBTGetPostBufferTemp);
                end;
            1:
                begin
                    CurrPage.PostedInvoices.PAGE.OBTQtyBufferLine(OBTGetPostBufferTemp);
                    AddLinesOBTBuffer(OBTGetPostBufferTemp);
                end;
            2:
                begin
                    CurrPage.PostedReturnRcpts.PAGE.OBTQtyBufferLine(OBTGetPostBufferTemp);
                    AddLinesOBTBuffer(OBTGetPostBufferTemp);
                end;
            3:
                begin
                    CurrPage.PostedCrMemos.PAGE.OBTQtyBufferLine(OBTGetPostBufferTemp);
                    AddLinesOBTBuffer(OBTGetPostBufferTemp);
                end;
            4:
                begin
                    //CurrPage.OBTItems.PAGE.OBTQtyBufferLine(OBTGetPostBufferTemp);
                    ItemList2.OBTQtyBufferLine(OBTGetPostBufferTemp);
                    AddLinesOBTBuffer(OBTGetPostBufferTemp);
                end;
            5:
                begin
                    CurrPage.OBTItemsAssortment.PAGE.OBTQtyBufferLine(OBTGetPostBufferTemp);
                    AddLinesOBTBuffer(OBTGetPostBufferTemp);
                end;
        end;
        Clear(CopyDocMgt);

        IsHandled := false;
        OnCopyLineToDocOnBeforeMessage(ToSalesHeader, IsHandled);
        if not IsHandled then
            if LinesNotCopied <> 0 then
                Message(Text000);
    end;

    /// <summary>
    /// ChangeSubMenu.
    /// </summary>
    /// <param name="NewMenuType">Integer.</param>
    procedure ChangeSubMenu(NewMenuType: Integer)
    begin
        if OldMenuType <> NewMenuType then
            SetSubMenu(OldMenuType, false);
        SetSubMenu(NewMenuType, true);
        OldMenuType := NewMenuType;
        CurrentMenuType := NewMenuType;
    end;

    /// <summary>
    /// GetCurrentMenuType.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetCurrentMenuType(): Integer
    begin
        exit(CurrentMenuType);
    end;

    local procedure SetSubMenu(MenuType: Integer; Visible: Boolean)
    begin
        if ShowRevLinesOnly and (MenuType in [0, 1]) then
            ShowRevLinesOnly :=
              CopyDocMgt.IsSalesFillExactCostRevLink(ToSalesHeader, MenuType, ToSalesHeader."Currency Code");
        ShowRevLineEnable := MenuType in [0, 1];
        case MenuType of
            0:
                begin
                    PostedShptsVisible := Visible;
                    CurrPage.PostedShpts.PAGE.Initialize(
                      ToSalesHeader, ShowRevLinesOnly,
                      CopyDocMgt.IsSalesFillExactCostRevLink(
                        ToSalesHeader, MenuType, ToSalesHeader."Currency Code"), Visible);
                end;
            1:
                begin
                    PostedInvoicesVisible := Visible;
                    CurrPage.PostedInvoices.PAGE.Initialize(
                      ToSalesHeader, ShowRevLinesOnly,
                      CopyDocMgt.IsSalesFillExactCostRevLink(
                        ToSalesHeader, MenuType, ToSalesHeader."Currency Code"), Visible);
                end;
            2:
                PostedReturnRcptsVisible := Visible;
            3:
                PostedCrMemosVisible := Visible;
            4:
                begin
                    CurrPage.OBTItems.PAGE.Initialize(ToSalesHeader);
                    rec.SetRange("OBT Assortment Filter");
                    rec.SetRange("OBT In Assortment", false);
                    gItemListVisible := Visible;
                end;
            5:
                begin
                    SetAssortmentFilter(rec);
                    gItemListVisibleAssortment := Visible;
                end;
        end;
    end;

    /// <summary>
    /// SetToSalesHeader.
    /// </summary>
    /// <param name="NewToSalesHeader">Record "Sales Header".</param>
    procedure SetToSalesHeader(NewToSalesHeader: Record "Sales Header")
    begin
        ToSalesHeader := NewToSalesHeader;
    end;

    local procedure OptionCaptionServiceTier(): Text[70]
    begin
        exit(Text002);
    end;

    local procedure ShowRevLinesOnlyOnAfterValidat()
    begin
        CurrPage.Update(true);
    end;

    local procedure x0CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(0);
    end;

    local procedure x0CurrentMenuTypeOptOnValidate()
    begin
        x0CurrentMenuTypeOptOnPush();
    end;

    local procedure x1CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(1);
    end;

    local procedure x1CurrentMenuTypeOptOnValidate()
    begin
        x1CurrentMenuTypeOptOnPush();
    end;

    local procedure x2CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(2);
    end;

    local procedure x2CurrentMenuTypeOptOnValidate()
    begin
        x2CurrentMenuTypeOptOnPush();
    end;

    local procedure x3CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(3);
    end;

    local procedure x4CurrentMenuTypeOptOnPush()
    begin
        //ChangeSubMenu(4);
        //Page.Run(Page::"OBT Item List2");                                // xxx
        CurrentMenuType := 4;
        ItemList2.LookupMode := true;
        ItemList2.Editable := true;
        if ItemList2.RunModal() = Action::LookupOK then begin
            //ItemList2.OBTQtyBufferLine(OBTGetPostBufferTemp);
            //AddLinesOBTBuffer(OBTGetPostBufferTemp);
        end;
    end;

    local procedure x5CurrentMenuTypeOptOnPush()
    begin
        ChangeSubMenu(5);
    end;

    local procedure x3CurrentMenuTypeOptOnValidate()
    begin
        x3CurrentMenuTypeOptOnPush();
    end;

    local procedure x4CurrentMenuTypeOptOnValidate()
    begin
        x4CurrentMenuTypeOptOnPush();
    end;

    local procedure x5CurrentMenuTypeOptOnValidate()
    begin
        x5CurrentMenuTypeOptOnPush();
    end;

    local procedure NoOfPostedPrepmtInvoices(): Integer
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        SalesInvHeader.SetRange("Sell-to Customer No.", rec."No.");
        SalesInvHeader.SetRange("Prepayment Invoice", true);
        exit(SalesInvHeader.Count);
    end;

    local procedure NoOfPostedPrepmtCrMemos(): Integer
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        SalesCrMemoHeader.SetRange("Sell-to Customer No.", rec."No.");
        SalesCrMemoHeader.SetRange("Prepayment Credit Memo", true);
        exit(SalesCrMemoHeader.Count);
    end;

    /// <summary>
    /// AddItem.
    /// </summary>
    /// <param name="pItem">VAR Record item.</param>    
    procedure AddItem(var pItem: Record item)
    var

        lSL: Record "Sales Line";
        lItem: Record Item;
    begin
        if pItem.FindFirst() then
            repeat
                Clear(lsl);
                lsl."Document Type" := ToSalesHeader."Document Type";
                lsl."Document No." := ToSalesHeader."No.";
                lsl."Line No." := GetSalesDocLineNo();
                lsl.Type := Enum::"Sales Line Type"::Item;
                lsl.Validate("No.", pitem."No.");
                lsl.Insert(true);
            until pitem.next = 0;
    end;

    /// <summary>
    /// AddLinesOBTBuffer.
    /// </summary>
    /// <param name="pOBTGetPostBuffer">VAR record "OBT Get Post Buffer".</param>
    procedure AddLinesOBTBuffer(var pOBTGetPostBuffer: record "OBT Get Post Buffer")
    var
        lSL: Record "Sales Line";
        lItem: Record Item;
    begin
        if pOBTGetPostBuffer.findfirst then
            repeat
                Clear(lsl);
                lsl."Document Type" := ToSalesHeader."Document Type";
                lsl."Document No." := ToSalesHeader."No.";
                lsl."Line No." := GetSalesDocLineNo();
                lsl.Type := pOBTGetPostBuffer."OBT Line Type";
                lsl.Validate("No.", pOBTGetPostBuffer."OBT Item No.");
                lsl.Validate("Unit of Measure Code", pOBTGetPostBuffer."OBT Unit of Measure Code");
                lsl.Validate(lsl.Quantity, pOBTGetPostBuffer."OBT Quantity");
                lsl.Insert(true);
                if lsl.Type = lsl.Type::Item then begin
                    case lsl.Reserve of
                        lsl.Reserve::Always:
                            lsl.AutoReserve();
                    end;
                end;

            until pOBTGetPostBuffer.next = 0;
    end;

    local Procedure GetSalesDocLineNo(): Integer
    var
        lSL: Record "Sales Line";
        lSline: Integer;
    begin
        lsl.reset;
        lsl.setrange("Document Type", ToSalesHeader."Document Type");
        lsl.setrange("Document No.", ToSalesHeader."No.");
        if lsl.FindLast() then
            lSline := lsl."Line No."
        else
            lSline := 0;
        exit(lSline + 10000);
    end;

    local procedure SetAssortmentFilter(var pCustomer: Record Customer)
    var
        CustomerAssortment: Record "OBT Customer Assortment";
        AssortmentFilter: Text;
    begin
        AssortmentFilter := '';
        CustomerAssortment.reset;
        CustomerAssortment.SetRange("OBT Customer No.", ToSalesHeader."Sell-to Customer No.");
        if CustomerAssortment.IsEmpty then begin
            pCustomer.setrange("OBT Assortment Filter", '');
            exit;
        end;
        if CustomerAssortment.FindSet() then
            repeat
                IF AssortmentFilter = '' then
                    AssortmentFilter := '''' + CustomerAssortment."OBT Assortment Code" + ''''
                else
                    AssortmentFilter := AssortmentFilter + '|' + '''' + CustomerAssortment."OBT Assortment Code" + '''';
            until CustomerAssortment.next = 0;
        pCustomer.SetFilter("OBT Assortment Filter", AssortmentFilter);
    end;

    local procedure SetAssortmentFilterItem(var pItem: Record Item)
    var
        CustomerAssortment: Record "OBT Customer Assortment";
        AssortmentFilter: Text;
        lCount: Integer;
    begin
        pItem.Reset;
        AssortmentFilter := '';
        CustomerAssortment.reset;
        CustomerAssortment.SetRange("OBT Customer No.", ToSalesHeader."Sell-to Customer No.");
        if CustomerAssortment.IsEmpty then begin
            pItem.setrange("OBT Assortment Filter", '');
            pItem.Setrange("OBT In Assortment", true);
            exit;
        end;
        if CustomerAssortment.FindSet() then
            repeat
                IF AssortmentFilter = '' then
                    AssortmentFilter := '''' + CustomerAssortment."OBT Assortment Code" + ''''
                else
                    AssortmentFilter := AssortmentFilter + '|' + '''' + CustomerAssortment."OBT Assortment Code" + '''';
            until CustomerAssortment.next = 0;
        pItem.SetFilter("OBT Assortment Filter", AssortmentFilter);
        pItem.Setrange("OBT In Assortment", true);
        lCount := pItem.Count;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyLineToDoc(var CopyDocumentMgt: Codeunit "Copy Document Mgt."; CurrentMenuType: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCopyLineToDocOnBeforeMessage(ToSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
    end;
}

