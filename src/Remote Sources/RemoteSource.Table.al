table 50901 "Remote Source EHO"
{
    Caption = 'Remote Source';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Remote Source List EHO";
    LookupPageId = "Remote Source List EHO";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(3; "Access Token"; Text[250])
        {
            Caption = 'Access Token';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Access Token" <> '' then begin
                    if IsolatedStorage.Delete(FieldCaption("Access Token"), DataScope::Module) then;
                    IsolatedStorage.Set(FieldCaption("Access Token"), "Access Token", DataScope::Module);
                    "Access Token" := '***';
                end else begin
                    IsolatedStorage.Delete(FieldCaption("Access Token"), DataScope::Module);
                    "Access Token" := '';
                end;
            end;
        }

        field(4; "No Of Functions"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Remote Source Function EHO" where("Remote Source Code" = field("Code")));
            Editable = false;
        }

        field(5; "Type"; Enum "Remote Source EHO")
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }


    procedure GetAccessTokenAsBasicAuthText(): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        PAT: Text;
        Usr: Text;
    begin
        if not IsolatedStorage.Get(FieldCaption("Access Token"), DataScope::Module, PAT) then
            exit;


        //PATBase64 := Base64Convert.ToBase64(PAT, TextEncoding::UTF8);


        //PATBase64 := Base64Convert.ToBase64(PAT, false, TextEncoding::UTF8, 1252);

        "Access Token" := '***';

        exit('Basic ' + Base64Convert.ToBase64(Usr + ':' + PAT))
    end;
}