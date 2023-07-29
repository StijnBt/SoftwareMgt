codeunit 50908 "RefreshVersion Meth EHO"
{
    internal procedure RefreshVersion(var Software: Record "Software EHO"; HideDialog: Boolean);
    var
        Handled: Boolean;
    begin
        if not ConfirmRefreshVersion(Software, HideDialog) then exit;

        OnBeforeRefreshVersion(Software, Handled);
        DoRefreshVersion(Software, Handled);
        OnAfterRefreshVersion(Software);

        AcknowledgeRefreshVersion(Software, HideDialog)
    end;

    local procedure DoRefreshVersion(var Software: Record "Software EHO"; Handled: Boolean);
    var
        RemoteSource: Record "Remote Source EHO";
        SoftwareVersion: Record "Software Version EHO";
        IRemoteSource: interface "IRemote Source EHO";
        MsgRefresh: Label 'Last refresh was less than 1 minute ago.\Do you wish to proceed?';
    begin
        if Handled then
            exit;

        if not RemoteSource.Get(Software."Remote Source") then
            exit;

        if Software."Last Version Update" <> 0DT then
            if Abs(CurrentDateTime - Software."Last Version Update") < 60000 then
                if GuiAllowed then
                    if not Confirm(MsgRefresh, false) then
                        exit;

        IRemoteSource := RemoteSource.Type;
        IRemoteSource.UpdateVersions(Software, SoftwareVersion);

        Software."Last Version Update" := CurrentDateTime;
        Software.Modify(true);

    end;

    local procedure ConfirmRefreshVersion(var Software: Record "Software EHO"; HideDialog: Boolean): Boolean
    var
        ConfirmQst: label 'Are You Sure?';
    begin
        if Not GuiAllowed or HideDialog then exit(true);
        exit(Confirm(ConfirmQst));
    end;

    local procedure AcknowledgeRefreshVersion(var Software: Record "Software EHO"; HideDialog: Boolean)
    var
        AcknowledgeMsg: label 'You successfully executed "RefreshVersion"';
    begin
        if Not GuiAllowed or HideDialog then exit;
        Message(AcknowledgeMsg);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRefreshVersion(var Software: Record "Software EHO"; var Handled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRefreshVersion(var Software: Record "Software EHO");
    begin
    end;
}