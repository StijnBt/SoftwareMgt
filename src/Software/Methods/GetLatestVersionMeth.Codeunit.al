codeunit 50909 "GetLatestVersion Meth EHO"
{
    internal procedure GetLatestVersion(var Software: Record "Software EHO"; var FileEntry: Record "File Entry EHO"; HideDialog: Boolean);
    var
        Handled: Boolean;
    begin
        if not ConfirmGetLatestVersion(Software, HideDialog) then exit;

        OnBeforeGetLatestVersion(Software, Handled);
        DoGetLatestVersion(Software, FileEntry, Handled);
        OnAfterGetLatestVersion(Software);

        AcknowledgeGetLatestVersion(Software, HideDialog)
    end;

    local procedure DoGetLatestVersion(var Software: Record "Software EHO"; var FileEntry: Record "File Entry EHO"; Handled: Boolean);
    var
        RemoteSource: Record "Remote Source EHO";
        SoftwareVersion: Record "Software Version EHO";
        IRemoteSource: interface "IRemote Source EHO";
    begin
        if Handled then
            exit;

        if not RemoteSource.Get(Software."Remote Source") then
            exit;

        Software.CalcFields("Latest Version", Product);

        If not SoftwareVersion.Get(Software."Code", Software."Latest Version") then
            exit;

        IRemoteSource := RemoteSource.Type;
        IRemoteSource.GetFiles(Software, SoftwareVersion, FileEntry);

        if Software.Product then
            FileEntry.SetFilter("Full Path", '%1', '@*' + Software."Latest Version" + '*Runtime*');

        if not FileEntry.FindFirst() then
            exit;

        FileEntry.GetFile();
    end;

    local procedure ConfirmGetLatestVersion(var Software: Record "Software EHO"; HideDialog: Boolean): Boolean
    var
        ConfirmQst: label 'Are You Sure?';
    begin
        if Not GuiAllowed or HideDialog then exit(true);
        exit(Confirm(ConfirmQst));
    end;

    local procedure AcknowledgeGetLatestVersion(var Software: Record "Software EHO"; HideDialog: Boolean)
    var
        AcknowledgeMsg: label 'You successfully executed "GetLatestVersion"';
    begin
        if Not GuiAllowed or HideDialog then exit;
        Message(AcknowledgeMsg);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetLatestVersion(var Software: Record "Software EHO"; var Handled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetLatestVersion(var Software: Record "Software EHO");
    begin
    end;
}