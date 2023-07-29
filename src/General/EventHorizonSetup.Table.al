table 50900 "Event Horizon Setup EHO"
{
    Caption = 'Event Horizon Setup';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }

        field(2; "Company Contact No."; Code[20])
        {
            Caption = 'Company Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Company));

        }

        field(3; "Software No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Software No. Series';
            TableRelation = "No. Series";
        }

        field(4; "Project No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project No. Series';
            TableRelation = "No. Series";
        }

        field(5; "Deployment No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Deployment No. Series';
            TableRelation = "No. Series";
        }

        field(6; "Serv. Mgr. Service Filter"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Manager Service Filter';
        }

        field(7; "Version No. Date Format"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Version No. Date Format';
            InitValue = 'yyyyMMdd';
        }

        field(8; "Current Base Roll-out Version"; code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Base Roll-out Version';
            //TableRelation = "Software Version EHO"."Version" where("Base Application" = const(true));

            trigger OnLookup()
            var
                SoftwareVersion: Record "Software Version EHO";
                Software: Record "Software EHO";
                RecRef: RecordRef;
                FilterText: Text;
                SelectionFilterManagement: Codeunit SelectionFilterManagement;
            begin
                Software.Reset();
                Software.SetRange(Status, Software.Status::Active);
                Software.SetRange("Base Application", true);

                RecRef.GetTable(Software);

                FilterText := SelectionFilterManagement.GetSelectionFilter(RecRef, Software.FieldNo("Code"));

                SoftwareVersion.Reset();
                SoftwareVersion.SetFilter("Software Code", FilterText);

                If Page.RunModal(Page::"Software Versions List EHO", SoftwareVersion) <> Action::LookupOK then
                    exit;

                "Current Base Roll-out Version" := SoftwareVersion."Version";

            end;
        }

        field(9; "Microsoft Contact No."; Code[20])
        {
            Caption = 'Microsoft Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Company));

        }

    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    /// <summary> 
    /// Description for InitSetup.
    /// </summary>
    procedure InitSetup();
    begin
        Reset();
        if Get() then
            exit;

        Init();
        Insert(true);
    end;

}
