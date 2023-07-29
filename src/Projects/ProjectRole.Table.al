table 50923 "Project Role EHO"
{
    Caption = 'Project Role';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project Role"; Code[20])
        {
            Caption = 'Project Role';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Project Role")
        {
            Clustered = true;
        }
    }

}
