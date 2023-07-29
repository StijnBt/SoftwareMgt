table 50902 "Event Horizon RC Cue EHO"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PrimaryKey; Code[250])
        {

            DataClassification = ToBeClassified;
        }
        field(2; "Open Jobs"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Job" where(Blocked = filter('<>All')));
        }
        field(3; "Closed Jobs"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Job" where(Blocked = filter('All')));
        }

        field(4; "Available Resources"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count(Resource where(Blocked = const(false), Type = const(Person)));
        }

        field(5; Customers; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count(Customer);
        }

        field(6; Vendors; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count(Vendor);
        }

        field(7; Contacts; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count(Contact);
        }

        field(8; "Software Active Product"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Software EHO" where(Status = filter(Active), Product = const(true)));
        }
        field(9; "Software Active Base"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Software EHO" where(Status = filter(Active | Prospect), "Base Application" = const(true)));
        }

        field(10; "Software Support"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Software EHO" where(Status = const(Support)));
        }

        field(11; "Software Custom"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Software EHO" where(Status = filter(Active), "Base Application" = const(false), Product = const(false)));
        }

        field(12; "External Deployments"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Deployment EHO" where(Active = const(true), Location = const("External")));
        }

        field(13; "Internal Deployments"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Deployment EHO" where(Active = const(true), Location = const("Internal")));
        }

        field(14; "Active Projects"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Project EHO" where(Active = const(true)));
        }

        field(100; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }

    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }


    procedure InitCue();
    begin
        Reset();
        if Get() then
            exit;

        Init();
        Insert(true);
    end;

}