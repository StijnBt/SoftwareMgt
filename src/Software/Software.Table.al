table 50910 "Software EHO"
{
    Caption = 'Software';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Software List EHO";
    LookupPageId = "Software List EHO";


    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            //NotBlank = true;

            trigger OnValidate()
            var
                NoSeriesMgtEHO: Codeunit "No. Series Mgt. EHO";
                RecRef: RecordRef;
                XRecRef: RecordRef;
            begin
                RecRef.getTable(Rec);
                XRecRef.GetTable(xRec);
                NoSeriesMgtEHO.TestManual(RecRef, XRecRef);
            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(3; Status; Enum "Software Status EHO")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }

        field(4; "Owner No."; Code[20])
        {
            Caption = 'Owner No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Company));
        }
        field(5; "Owner Name"; Text[100])
        {
            Caption = 'Owner Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("Owner No.")));
            Editable = false;
        }

        field(6; "Distributor No."; Code[20])
        {
            Caption = 'Distributor No.';
            TableRelation = Contact where(Type = const(Company));
            DataClassification = ToBeClassified;
        }

        field(7; "Distributor Name"; Text[100])
        {
            Caption = 'Distributor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("Distributor No.")));
            Editable = false;
        }

        field(8; "Latest Version"; Text[30])
        {
            Caption = 'Latest Version';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max("Software Version EHO".Version where("Software Code" = field(Code)));
        }

        field(9; Image; Media)
        {
            Caption = 'Logo';
            DataClassification = ToBeClassified;
        }

        field(10; "Base Application"; Boolean)
        {
            Caption = 'Base Application';
            FieldClass = FlowField;
            CalcFormula = exist("Event Horizon Setup EHO" where("Microsoft Contact No." = field("Owner No.")));
            Editable = false;
        }

        field(11; "NAV/BC Target"; Enum "Software Target EHO")
        {
            Caption = 'Target';
            DataClassification = ToBeClassified;
        }

        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(13; "Description 2"; Text[250])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }

        field(14; "Product"; Boolean)
        {
            Caption = 'Product';
            FieldClass = FlowField;
            CalcFormula = exist("Event Horizon Setup EHO" where("Company Contact No." = field("Owner No.")));
            Editable = false;
        }

        field(100; "Extension Guid"; Guid)
        {
            Caption = 'Extension Guid';
            DataClassification = ToBeClassified;
        }
        field(101; "Remote Source"; Code[10])
        {
            Caption = 'Remote Source';
            TableRelation = "Remote Source EHO";
            DataClassification = ToBeClassified;
        }
        field(102; "Remote Source Url"; Text[250])
        {
            Caption = 'Repo url';
            DataClassification = ToBeClassified;
        }

        field(103; "Last Version Update"; DateTime)
        {
            Caption = 'Last Version Update';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(200; "No Of Versions"; Integer)
        {
            Caption = 'No Of Versions';
            FieldClass = FlowField;
            CalcFormula = Count("Software Version EHO" where("Software Code" = field("Code")));
            Editable = false;
        }

        field(201; "No Of Ranges"; Integer)
        {
            Caption = 'No Of Ranges';
            FieldClass = FlowField;
            CalcFormula = Count("Software Object Range EHO" where("Software Code" = field("Code")));
            Editable = false;
        }

        field(202; "No. Of Deployments"; Integer)
        {
            Caption = 'No. Of Deployments';
            FieldClass = FlowField;
            CalcFormula = Count("Software Deployment EHO" where("Software Code" = field("Code")));
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    var
        DownloadDialogTitle: Label 'Download file...';
        FileFilter: Label '%1 Files (*%1)|*%1';

    trigger OnInsert()
    var
        NoSeriesMgtEHO: Codeunit "No. Series Mgt. EHO";
        RecRef: RecordRef;
        XRecRef: RecordRef;
    begin
        RecRef.getTable(Rec);
        XRecRef.GetTable(xRec);
        NoSeriesMgtEHO.InitNo(RecRef, XRecRef);
        RecRef.SetTable(Rec);
    end;


    procedure UploadImage()
    var
        InStr: InStream;
        FileName: Text;
        SelectImageLbl: Label 'Select a file as image';
    begin
        UploadIntoStream(SelectImageLbl, '', 'Bitmap (*.bmp)|*.bmp|Jpeg (*.jpg)|*.jpg|Gif (*.gif)|*.gif|Png (*.png)|*.png', FileName, InStr);
        Image.ImportStream(InStr, 'Image for ' + TableCaption() + ' ' + Format(Code));
        Modify();
    end;


    procedure DownloadImage()
    var
        TenantMedia: Record "Tenant Media";
        InStr: InStream;
        FileName: Text;
    begin
        if not TenantMedia.Get(Image.MediaId) then
            exit;

        TenantMedia.CalcFields(Content);

        if not TenantMedia.Content.HasValue() then
            exit;

        FileName := delchr(TenantMedia.Description, '=', ' ') + '.' + CopyStr(TenantMedia."Mime Type", StrPos(TenantMedia."Mime Type", '/') + 1, 3);

        TenantMedia.Content.CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', '', FileName);
    end;

    procedure ClearImage()
    var
        TenantMedia: Record "Tenant Media";
    begin
        if not TenantMedia.Get(Image.MediaId) then
            exit;
        TenantMedia.Delete(true);
    end;

    procedure RefreshVersions(HideDialog: Boolean)
    var
        RefreshVersionMeth: Codeunit "RefreshVersion Meth EHO";
    begin
        RefreshVersionMeth.RefreshVersion(Rec, HideDialog);
    end;

    procedure GetLatestVersion(var FileEntry: record "File Entry EHO")
    var
        GetLatestVersionMeth: Codeunit "GetLatestVersion Meth EHO";
    begin
        GetLatestVersionMeth.GetLatestVersion(Rec, FileEntry, false);
    end;

    procedure DownloadLastestVersion(Software: Record "Software EHO")
    var
        TempFileEntry: Record "File Entry EHO" temporary;
        InStr: InStream;
    begin

        Message('%1', Software.Count);

        case Software.Count of
            0:
                exit;
            1:
                begin
                    GetLatestVersion(TempFileEntry);

                    TempFileEntry.CalcFields("Blob Content");
                    TempFileEntry."Blob Content".CreateInStream(InStr);

                    File.DownloadFromStream(InStr, DownloadDialogTitle, '', StrSubstNo(FileFilter, TempFileEntry."File Extension"), TempFileEntry.Name);
                end;
            else begin
                    // GetZipFile(FileEntry, TempBlob);
                    // TempBlob.CreateInStream(InStr);

                    // FileName := FileManagement.GetSafeFileName(format(CurrentDateTime) + '.zip');
                    // DownloadFromStream(InStr, DownloadDialogTitle, '', StrSubstNo(FileFilter, 'Zip'), FileName);
                end;
        end;



    end;

    procedure AddOrUpdateVersion("Version": Text; ReleaseDate: Date; ExternalId: Text)
    var
        SoftwareVersion: Record "Software Version EHO";
    begin
        SoftwareVersion.Reset();
        SoftwareVersion.SetRange("Software Code", "Code");

        if ExternalId <> '' then
            SoftwareVersion.SetRange("External Id", ExternalId)
        else
            SoftwareVersion.SetRange("Version", "Version");

        if SoftwareVersion.FindFirst() then begin
            if SoftwareVersion."Version" <> "Version" then begin
                SoftwareVersion."Version" := "Version";
                SoftwareVersion.Modify(true);
            end;
        end else begin
            Clear(SoftwareVersion);
            SoftwareVersion.Init();
            SoftwareVersion."Software Code" := "Code";
            SoftwareVersion."Version" := copystr("Version", 1, MaxStrLen(SoftwareVersion."Version"));
            SoftwareVersion."Release Date" := ReleaseDate;
            SoftwareVersion.Insert(true);

            SoftwareVersion."External Id" := copystr(ExternalId, 1, MaxStrLen(SoftwareVersion."External Id"));
            SoftwareVersion.Manual := false;

            if format(SoftwareVersion."Release Date") = '' then
                SoftwareVersion."Release Date" := SoftwareVersion.ReleaseDateFromVersion();

            SoftwareVersion.Modify(true);
        end;
    end;




}
