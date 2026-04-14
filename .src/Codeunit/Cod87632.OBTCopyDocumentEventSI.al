/// <summary>
/// Codeunit OBT CopyDocument Event SI (ID 87632).
/// </summary>
codeunit 87632 "OBT CopyDocument Event SI"
{
    SingleInstance = true;

    /// <summary>
    /// OBTSetNoCopyDocLine.
    /// </summary>
    /// <param name="pVar">boolean.</param>
    procedure OBTSetNoCopyDocLine(pVar: boolean)
    begin
        gNoCopyDocLine := pVar;
    end;

    /// <summary>
    /// OBTGetNoCopyDocLine.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure OBTGetNoCopyDocLine(): Boolean;
    begin
        Exit(gNoCopyDocLine);
    end;

    var
        gNoCopyDocLine: Boolean;

}
