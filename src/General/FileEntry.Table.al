table 50905 "File Entry EHO"
{
    Caption = 'File Entry EHO';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Full Path"; Text[500])
        {
            Caption = 'Path';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                FileManagement: Codeunit "File Management";
                PathSplit: List of [Text];
            begin
                If ("Full Path" = '') then
                    exit;

                Level := strlen(DelChr("Full Path", '=', DelChr("Full Path", '=', '/'))) - 1;

                case Folder of
                    true:
                        begin
                            PathSplit := "Full Path".Split('/');
                            PathSplit.Get(PathSplit.Count, Name);
                            "Sort Path" := "Full Path";
                        end;
                    false:
                        begin
                            "Name" := FileManagement.GetFileName("Full Path");
                            "File Extension" := CopyStr("Name", StrLen(FileManagement.GetFileNameWithoutExtension("Name")) + 2);
                            "Sort Path" := CopyStr("Full Path", 1, StrLen("Full Path") - StrLen("Name"));
                        end;
                end;


            end;
        }
        field(3; "Name"; Text[500])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(4; "File Extension"; Text[10])
        {
            Caption = 'File Extension';
            DataClassification = ToBeClassified;
        }
        field(5; Folder; Boolean)
        {
            Caption = 'Folder';
            DataClassification = ToBeClassified;
        }
        field(6; Level; Integer)
        {
            Caption = 'Level';
            DataClassification = ToBeClassified;
        }

        field(7; "External Id"; Text[100])
        {
            Caption = 'External Id';
            DataClassification = ToBeClassified;
        }

        field(8; "Sort Path"; Text[500])
        {
            Caption = 'Sort Path';
            DataClassification = ToBeClassified;
        }

        field(9; "Software Code"; code[30])
        {
            Caption = 'Software Code';
            DataClassification = ToBeClassified;
            TableRelation = "Software EHO";
        }

        field(10; "Version"; Text[30])
        {
            Caption = 'Version';
            DataClassification = ToBeClassified;
            TableRelation = "Software Version EHO"."Version" where("Software Code" = field("Software Code"));
        }

        field(11; "Hide"; Boolean)
        {
            Caption = 'Hide';
            DataClassification = ToBeClassified;
        }

        field(12; "Blob Content"; Blob)
        {
            Caption = 'Blob Content';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Sort1; "Sort Path", Level)
        {
        }
    }

    var
        DownloadDialogTitle: Label 'Download file...';
        FileFilter: Label '%1 Files (*%1)|*%1';

    procedure GetEntryNo(): Integer
    begin
        Reset();
        if not FindLast() then
            Clear(Rec);

        exit("Entry No." + 1);
    end;

    procedure GetFile()
    var
        RemoteSource: Record "Remote Source EHO";
        Software: Record "Software EHO";
        IRemoteSource: interface "IRemote Source EHO";
        DownloadLink: Text;
    begin
        if not Software.Get("Software Code") then
            Clear(Software);

        if not RemoteSource.get(Software."Remote Source") then
            Clear(RemoteSource);

        IRemoteSource := RemoteSource.Type;
        IRemoteSource.GetFile(Software, Rec);
    end;



    procedure Download(var FileEntry: Record "File Entry EHO")
    var
        TempBlob: Codeunit "Temp Blob";
        CommonFunctions: Codeunit "Common Functions EHO";
        InStr: InStream;
        FileManagement: Codeunit "File Management";
        FileName: Text;
    begin

        case FileEntry.Count of
            0:
                exit;
            1:
                begin
                    if Folder then
                        exit;

                    GetFile();

                    CalcFields("Blob Content");
                    "Blob Content".CreateInStream(InStr);

                    File.DownloadFromStream(InStr, DownloadDialogTitle, '', StrSubstNo(FileFilter, "File Extension"), Name);
                end;
            else begin
                    CommonFunctions.GetZipFileFromFileEntries(FileEntry, TempBlob);
                    TempBlob.CreateInStream(InStr);

                    FileName := FileManagement.GetSafeFileName(format(CurrentDateTime) + '.zip');
                    DownloadFromStream(InStr, DownloadDialogTitle, '', StrSubstNo(FileFilter, 'Zip'), FileName);
                end;
        end;


    end;

}
