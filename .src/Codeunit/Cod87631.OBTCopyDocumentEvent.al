/// <summary>
/// Codeunit OBT Copy Document Event (ID 87631).
/// </summary>
codeunit 87631 "OBT Copy Document Event"
{
#pragma warning disable AL0104
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterShouldSkipCopyFromDescription', '', true, true)]
    local procedure ShouldSkipCopyFromDescription(var Result: Boolean)
    begin
        Result := OBTNoCopySI.OBTGetNoCopyDocLine();

    end;

    

    var

        OBTNoCopySI: Codeunit "OBT CopyDocument Event SI";

}
