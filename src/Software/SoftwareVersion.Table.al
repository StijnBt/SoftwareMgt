table 50912 "Software Version EHO"
{
    Caption = 'Software Version';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Software Versions List EHO";
    LookupPageId = "Software Versions List EHO";


    fields
    {
        field(1; "Software Code"; Code[30])
        {
            Caption = 'Software Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Version"; Text[30])
        {
            Caption = 'Version';
            DataClassification = ToBeClassified;
        }
        field(3; "Release Date"; Date)
        {
            Caption = 'Release Date';
            DataClassification = ToBeClassified;
        }

        field(4; Url; Text[80])
        {
            Caption = 'Url';
            ExtendedDatatype = URL;
            DataClassification = ToBeClassified;
        }

        field(5; "Docker Path"; Text[80])
        {
            Caption = 'Docker Path';
            DataClassification = ToBeClassified;
        }

        field(6; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(7; Manual; Boolean)
        {
            Caption = 'Manual';
            DataClassification = ToBeClassified;
        }

        field(11; "External Id"; Text[100])
        {
            Caption = 'Remote Id';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Software Code", "Version")
        {
            Clustered = true;
        }

        key(RemoteId; "External Id")
        {
        }
    }


    trigger OnInsert()
    begin
        Manual := true;
    end;

    procedure ReleaseDateFromVersion() ReleaseDate: Date
    var
        EventHorizonSetup: Record "Event Horizon Setup EHO";
        Helper: List of [Text];
        TypeHelper: Codeunit "Type Helper";
        i: Integer;
        VersionPart: Text;
        DateVar: Variant;
    begin
        EventHorizonSetup.Get();

        if EventHorizonSetup."Version No. Date Format" = '' then
            exit;

        Helper := format("Version").Split('.');

        for i := 1 to Helper.Count() do begin
            VersionPart := Helper.Get(i);
            if strlen(VersionPart) = 8 then begin
                DateVar := ReleaseDate;
                if TypeHelper.Evaluate(DateVar, VersionPart, EventHorizonSetup."Version No. Date Format", '') then begin
                    ReleaseDate := DateVar;
                    exit;
                end;
            end;
        end;
    end;

    procedure ShowFiles()
    var
        RemoteSource: Record "Remote Source EHO";
        Software: Record "Software EHO";
        SoftwareVersion: Record "Software Version EHO";
        FileEntryEHO: Record "File Entry EHO" temporary;
        IRemoteSource: interface "IRemote Source EHO";
        FileEntries: Page "File Entries EHO";
    begin
        if not Software.Get("Software Code") then
            Clear(Software);

        if not RemoteSource.Get(Software."Remote Source") then
            exit;


        IRemoteSource := RemoteSource.Type;
        IRemoteSource.GetFiles(Software, SoftwareVersion, FileEntryEHO);

        FileEntryEHO.ModifyAll("Software Code", "Software Code");
        FileEntryEHO.ModifyAll("Version", "Version");
        //FileEntryEHO.SetFilter("Full Path", '%1', '@*' + "Version" + '*');

        page.Run(Page::"File Entries EHO", FileEntryEHO);
    end;
}
