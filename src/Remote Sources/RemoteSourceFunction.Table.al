table 50904 "Remote Source Function EHO"
{
    Caption = 'Remote Source Function';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Remote Source Code"; Code[20])
        {
            Caption = 'Remote Source Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Remote Source EHO"."Code";
        }
        field(2; "Function Code"; Code[30])
        {
            Caption = 'Function Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Function Url"; Text[250])
        {
            Caption = 'Function Url';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Remote Source Code", "Function Code")
        {
            Clustered = true;
        }
    }

}
