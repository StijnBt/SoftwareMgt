table 50921 "Deployment EHO"
{
    Caption = 'Deployment';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Deployment List EHO";
    LookupPageId = "Deployment List EHO";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;

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

        field(2; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
            DataClassification = ToBeClassified;
            TableRelation = "Project EHO";
        }

        field(3; Type; Enum "Deployment Type EHO")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }

        field(4; Active; Boolean)
        {
            Caption = 'Active';

            trigger OnValidate()
            begin
                if Active and (Format("Starting Date") = '') then
                    "Starting Date" := Today;

                if not Active and (Format("Ending Date") = '') then
                    "Ending Date" := Today;
            end;
        }

        field(5; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; Location; Enum "Deployment Location EHO")
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
        }



        field(8; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Project EHO"."Customer Contact No." where("Code" = field("Project Code")));
        }

        field(9; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Contact.Name where("No." = field("Contact No.")));
        }

        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(11; "No. Of Software"; Integer)
        {
            Caption = 'No. Of Software';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Software Deployment EHO" where("Deployment Code" = field("Code")));
        }

        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Project Code", "Code")
        {
            Clustered = true;
        }
    }

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

}
