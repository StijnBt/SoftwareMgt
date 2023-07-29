codeunit 50902 "CopyObjectRange Meth EHO"
{
    var
        CountInserts: Integer;


    procedure CopyObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO"; TargetSoftwareCode: Code[30]; HideDialog: Boolean);
    var
        Handled: Boolean;
    begin
        if not ConfirmCopyObjectRange(SoftwareObjectRangeEHO, HideDialog) then exit;

        OnBeforeCopyObjectRange(SoftwareObjectRangeEHO, TargetSoftwareCode, Handled);
        DoCopyObjectRange(SoftwareObjectRangeEHO, TargetSoftwareCode, Handled);
        OnAfterCopyObjectRange(SoftwareObjectRangeEHO);

        AcknowledgeCopyObjectRange(SoftwareObjectRangeEHO, HideDialog)
    end;


    local procedure DoCopyObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO"; TargetSoftwareCode: Code[30]; var Handled: Boolean);
    var
        SoftwareEHO: Record "Software EHO";
        SoftwareObjectRangeEHOTarget: Record "Software Object Range EHO";
    begin
        if Handled then
            exit;

        SoftwareEHO.Get(TargetSoftwareCode);

        if SoftwareObjectRangeEHO.FindSet() then
            repeat
                Clear(SoftwareObjectRangeEHOTarget);
                SoftwareObjectRangeEHOTarget.Init();
                SoftwareObjectRangeEHOTarget := SoftwareObjectRangeEHO;
                SoftwareObjectRangeEHOTarget."Software Code" := SoftwareEHO.Code;
                if SoftwareObjectRangeEHOTarget.Insert() then
                    CountInserts += 1;
            until SoftwareObjectRangeEHO.Next() = 0;

    end;


    local procedure ConfirmCopyObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO"; HideDialog: Boolean): Boolean
    var
        ConfirmQst: Label 'Are You Sure?';
    begin
        if not GuiAllowed() or HideDialog then
            exit(true);

        exit(Confirm(ConfirmQst));
    end;

    local procedure AcknowledgeCopyObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO"; HideDialog: Boolean)
    var
        AcknowledgeMsg: Label '%1 %2 were created';
    begin
        if not GuiAllowed() or HideDialog then
            exit;

        Message(AcknowledgeMsg, CountInserts, SoftwareObjectRangeEHO.TableCaption());
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO"; TargetSoftwareCode: Code[30]; var Handled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO");
    begin
    end;
}