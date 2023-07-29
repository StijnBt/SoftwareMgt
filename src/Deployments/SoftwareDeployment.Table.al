table 50922 "Software Deployment EHO"
{
    Caption = 'Software Deployment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
            NotBlank = true;
            DataClassification = ToBeClassified;
            TableRelation = "Project EHO";
        }
        field(2; "Deployment Code"; Code[20])
        {
            Caption = 'Deployment Code';
            NotBlank = true;
            DataClassification = ToBeClassified;
            TableRelation = "Deployment EHO".Code where("Code" = field("Project Code"));
        }
        field(3; "Software Code"; Code[30])
        {
            Caption = 'Software Code';
            NotBlank = true;
            DataClassification = ToBeClassified;
            TableRelation = "Software EHO";
        }
        field(4; "Version"; Text[30])
        {
            Caption = 'Version';
            NotBlank = true;
            DataClassification = ToBeClassified;
            TableRelation = "Software Version EHO".Version where("Software Code" = field("Software Code"));
        }
    }
    keys
    {
        key(PK; "Project Code", "Deployment Code", "Software Code", Version)
        {
            Clustered = true;
        }
    }


}
