table 50924 "Project Role Relation EHO"
{
    Caption = 'Project Role Relation';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Project Role Relations EHO";
    LookupPageId = "Project Role Relations EHO";

    fields
    {
        field(1; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
            DataClassification = ToBeClassified;
            TableRelation = "Project EHO";
        }
        field(2; "Project Role"; Code[20])
        {
            Caption = 'Project Role';
            DataClassification = ToBeClassified;
            TableRelation = "Project Role EHO";
        }
        field(3; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact."No." where(Type = const(Person));
        }
        field(4; "Contact Name"; Text[50])
        {
            Caption = 'Contact Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("Contact No.")));
            Editable = false;
        }
        field(5; Note; Text[20])
        {
            Caption = 'Note';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Project Code", "Project Role", "Contact No.")
        {
            Clustered = true;
        }
    }

}
