table 50925 "Project Software EHO"
{
    Caption = 'Project Software';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
            DataClassification = ToBeClassified;
            TableRelation = "Project EHO"."Code";
        }
        field(2; "Software Code"; Code[30])
        {
            Caption = 'Software Code';
            DataClassification = ToBeClassified;
            TableRelation = "Software EHO"."Code";
        }
        field(3; "Customer Contact No."; Code[20])
        {
            Caption = 'Customer Contact No.';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Project EHO"."Customer Contact No." where("Code" = field("Project Code")));
        }

        field(4; "Software Description"; Text[250])
        {
            Caption = 'Software Description';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Software EHO".Description where("Code" = field("Software Code")));
        }
    }
    keys
    {
        key(PK; "Project Code", "Software Code")
        {
            Clustered = true;
        }
    }

}
