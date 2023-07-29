codeunit 50905 "Azure Devops Source EHO" implements "IRemote Source EHO"
{
    var
        RemoteSource: Record "Remote Source EHO";
        RemoteSourceFunction: Record "Remote Source Function EHO";
        WebResponse: Text;

    procedure UpdateVersions(var Software: Record "Software EHO"; var SoftwareVersion: Record "Software Version EHO")
    var
        Headers: List of [Text];
        InStr: InStream;
    begin
        if not RemoteSource.Get(Software."Remote Source") then
            exit;

        if not RemoteSourceFunction.get(RemoteSource."Code", 'GITREFS') then
            exit;

        if not SendWebRequest(ComposeUrl(Software."Remote Source Url", RemoteSourceFunction, ''), '', Headers, WebResponse, InStr) then
            exit;

        ProcessUpdateVersions(Software, RemoteSourceFunction, WebResponse);
    end;

    procedure GetFiles(var Software: Record "Software EHO"; var SoftwareVersion: Record "Software Version EHO"; var FileEntryEHO: Record "File Entry EHO")
    var
        Headers: List of [Text];
        InStr: InStream;
    begin
        if not RemoteSource.Get(Software."Remote Source") then
            exit;

        if not RemoteSourceFunction.get(RemoteSource."Code", 'GITITEMS') then
            exit;

        if not SendWebRequest(ComposeUrl(Software."Remote Source Url", RemoteSourceFunction, SoftwareVersion."Version"), '', Headers, WebResponse, InStr) then
            exit;

        ProcessGetFiles(FileEntryEHO, WebResponse);

    end;

    procedure GetFile(var Software: Record "Software EHO"; var FileEntry: Record "File Entry EHO")
    var
        Outstr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        InStr: InStream;
        Headers: List of [Text];
    begin
        if not RemoteSource.Get(Software."Remote Source") then
            exit;

        if not RemoteSourceFunction.get(RemoteSource."Code", 'GITDOWNLOAD') then
            exit;

        if not SendWebRequest(ComposeUrl(Software."Remote Source Url", RemoteSourceFunction, FileEntry."Full Path"), '', Headers, WebResponse, InStr) then
            exit;

        FileEntry."Blob Content".CreateOutStream(Outstr);
        CopyStream(Outstr, InStr);
        FileEntry.Modify();
    end;

    local procedure SendWebRequest(WebReqUrl: Text; ContentType: Text; Headers: List of [Text]; var WebResponse: Text; var Instr: InStream) Success: Boolean
    var
        RESTHelper: Codeunit "REST Helper";
        Header: Text;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
    begin

        RESTHelper.Initialize('GET', WebReqUrl);

        if RemoteSource."Access Token" <> '' then
            RESTHelper.AddRequestHeader('Authorization', RemoteSource.GetAccessTokenAsBasicAuthText());


        If ContentType <> '' then
            RESTHelper.SetContentType(ContentType);


        foreach Header in Headers do begin
            RESTHelper.AddRequestHeader(CopyStr(Header, 1, strpos(Header, ':') - 1), CopyStr(Header, strpos(Header, ':') + 1));
        end;

        if not RESTHelper.Send() then begin
            WebResponse := RESTHelper.GetResponseReasonPhrase();
            Success := false;
        end else begin
            WebResponse := RESTHelper.GetResponseContentAsText();
            RESTHelper.GetResponseContentAsInstream(InStr);
            Success := true;
        end;

    end;




    local procedure ProcessUpdateVersions(Software: Record "Software EHO"; RemoteSourceFunction: record "Remote Source Function EHO"; var WebResponse: Text)
    var
        JsonObj: JsonObject;
        JsonTok: JsonToken;
        JsonTok2: JsonToken;
        JsonArr: JsonArray;
        Name: Text;
        ExternalId: Text;
        IsLocked: Boolean;
    begin
        // release branches are locked = version

        if not JsonObj.ReadFrom(WebResponse) then
            exit;

        if not JsonObj.Get('value', JsonTok) then
            exit;

        JsonArr := JsonTok.AsArray();

        foreach JsonTok in JsonArr do begin
            JsonObj := JsonTok.AsObject();

            Clear(IsLocked);
            Clear(Name);

            if JsonObj.Get('name', JsonTok2) then begin
                Name := JsonTok2.AsValue().AsText();
                ExternalId := Name;
                Name := Text.DelStr(Name, 1, StrLen('refs/heads/'));
            end;

            if JsonObj.Get('isLocked', JsonTok2) then
                IsLocked := JsonTok2.AsValue().AsBoolean();

            if IsLocked then
                Software.AddOrUpdateVersion(Name, 0D, ExternalId);

        end;
    end;

    local procedure ProcessGetFiles(var FileEntryEHO: Record "File Entry EHO"; var WebResponse: Text)
    var
        JsonObj: JsonObject;
        JsonTok: JsonToken;
        JsonTok2: JsonToken;
        JsonArr: JsonArray;
        Path: Text;
        IsFolder: Boolean;
        ObjectId: Text[100];
    begin
        if not JsonObj.ReadFrom(WebResponse) then
            exit;

        if not JsonObj.Get('value', JsonTok) then
            exit;

        JsonArr := JsonTok.AsArray();

        foreach JsonTok in JsonArr do begin
            JsonObj := JsonTok.AsObject();

            Clear(Path);
            Clear(IsFolder);

            if JsonObj.Get('path', JsonTok2) then
                Path := JsonTok2.AsValue().AsText();

            if JsonObj.Get('isFolder', JsonTok2) then
                IsFolder := JsonTok2.AsValue().AsBoolean();

            if JsonObj.Get('objectId', JsonTok2) then
                ObjectId := JsonTok2.AsValue().AsText();

            Clear(FileEntryEHO);
            FileEntryEHO."Entry No." := FileEntryEHO.GetEntryNo();
            FileEntryEHO.Folder := IsFolder;
            FileEntryEHO.validate("Full Path", Path);
            FileEntryEHO."External Id" := ObjectId;

            if FileEntryEHO.Name <> '' then
                FileEntryEHO.Insert();
        end;
    end;

    local procedure ComposeUrl(Repourl: Text; RemoteSourceFunction: Record "Remote Source Function EHO"; Custom1: Text) ComposedUrl: Text
    var
        Org: Text;
        Proj: Text;
        Repo: Text;
        Handled: Boolean;
    begin
        if Handled then
            exit;

        IF Repourl = '' then
            exit;

        if Text.StrPos(RepoUrl, 'https://') > 0 then
            RepoUrl := Text.DelStr(RepoUrl, 1, StrLen('https://'));


        RepoUrl := Text.ConvertStr(RepoUrl, '/', ',');
        Org := SelectStr(2, RepoUrl);
        Proj := SelectStr(3, RepoUrl);
        Repo := SelectStr(5, RepoUrl);

        ComposedUrl := StrSubstNo(RemoteSourceFunction."Function Url", Org, Proj, Repo, Custom1);
    end;
}
