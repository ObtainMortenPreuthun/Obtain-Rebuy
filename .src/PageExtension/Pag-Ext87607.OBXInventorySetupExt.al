namespace Obtain.Rebuy;

using Microsoft.Inventory.Setup;

pageextension 87607 "OBX Inventory Setup Ext." extends "Inventory Setup"
{
    layout
    {

    }
    actions
    {
        addafter("Journal Templates")
        {
            action(OBXGetItems)
            {
                ApplicationArea = All;
                Caption = 'Get Items';
                Image = Setup;
                ToolTip = 'Open OBT Inventory List';
                RunObject = Page "OBT Item List";

            }
        }
    }
}
