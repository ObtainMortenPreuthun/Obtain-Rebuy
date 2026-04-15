namespace Obtain.Rebuy;

permissionset 87610 "OBX_Rebuy"
{
    Assignable = true;
    Caption = 'Obtain Rebuy', Comment = '%';
    Permissions =
        tabledata "OBT Assortment" = RIMD,
        tabledata "OBT Contact Assortment" = RIMD,
        tabledata "OBT Customer Assortment" = RIMD,
        tabledata "OBT Get Post Buffer" = RIMD,
        tabledata "OBT Item Assortment" = RIMD,
        tabledata "OBT Sales Line Attribute Value" = RIMD,
        tabledata "OBT Sales Line Copy Buffer" = RIMD,
        table "OBT Assortment" = X,
        table "OBT Contact Assortment" = X,
        table "OBT Customer Assortment" = X,
        table "OBT Get Post Buffer" = X,
        table "OBT Item Assortment" = X,
        table "OBT Sales Line Attribute Value" = X,
        table "OBT Sales Line Copy Buffer" = X,
        page "OBT Assortment Contacts" = X,
        page "OBT Assortment Customers" = X,
        page "OBT Assortment Items" = X,
        page "OBT Assortments" = X,
        page "OBT Cont. Assortment Factbox" = X,
        page "OBT Copy Sales Doc. Lines" = X,
        page "OBT Cust. Assortment Factbox" = X,
        page "OBT Get Post.Doc - S.InvLn Sub" = X,
        page "OBT Get Post.Doc - S.ShptLn Sp" = X,
        page "OBT Get Post.Doc-S.Cr.MemoLn S" = X,
        page "OBT Get Pst.Doc-RtrnRcptLn Sub" = X,
        page "OBT Item Assortment Factbox" = X,
        page "OBT Item Attributes Factbox" = X,
        page "OBT Item Comment Factbox" = X,
        page "OBT Item Information Factbox" = X,
        page "OBT Item List" = X,
        page "OBT Item List Assortment" = X,
        page "OBT Item List2" = X,
        page "OBT Sales Line Attributes" = X,
        codeunit "OBT Copy Document Event" = X,
        codeunit "OBT CopyDocument Event SI" = X,
        codeunit "OBT Item CalcAvail ItemNo" = X,
        codeunit "OBT Order Promising" = X,
        codeunit "OBT Sales Header Function" = X,
        codeunit "OBTGetDocumentLinesFunction" = X;
}