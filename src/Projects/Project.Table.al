table 50920 "Project EHO"
{
    Caption = 'Project';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Project List EHO";
    LookupPageId = "Project List EHO";

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
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(5; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                EvaluateDeploymentsActive();
            end;
        }

        field(7; "No. Of Deployments"; Integer)
        {
            Caption = 'No. Of Deployments';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("Deployment EHO" where("Project Code" = field("Code")));
        }

        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(13; "Customer Contact No."; Code[20])
        {
            Caption = 'Customer Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(company));

            trigger OnValidate()
            begin
                CalcFields("Customer Contact Name");
            end;
        }

        field(14; "Customer Contact Name"; Text[100])
        {
            Caption = 'Customer Contact Name';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Contact.Name where("No." = field("Customer Contact No.")));
        }


        field(15; "No. Of Project Role Relations"; Integer)
        {
            Caption = 'No. Of Project Role Relations';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("Project Role Relation EHO" where("Project Code" = field("Code")));
        }

    }
    keys
    {
        key(PK; "Code")
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

    local procedure EvaluateDeploymentsActive()
    var
        DeploymentEHO: Record "Deployment EHO";
        EvaluateDeploymentsActiveHandled: Boolean;
        CfrmSetDeploymentsToNonActive: Label 'Do you wish to set all related %1 to %2 = %3';
    begin
        OnBeforeEvaluateDeploymentsActive(Rec, EvaluateDeploymentsActiveHandled);

        if EvaluateDeploymentsActiveHandled then
            exit;

        if Active then
            exit;

        DeploymentEHO.Reset();
        DeploymentEHO.SetRange("Project Code", "Code");

        if DeploymentEHO.IsEmpty() then
            exit;

        if GuiAllowed() then
            if not Confirm(CfrmSetDeploymentsToNonActive, true, DeploymentEHO.TableCaption(), FieldCaption(Active), Active) then
                exit;

        if DeploymentEHO.FindSet(true, false) then
            repeat
                DeploymentEHO.Validate(Active, Active);
                DeploymentEHO.Modify(true);
            until DeploymentEHO.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeEvaluateDeploymentsActive(var ProjectEHO: Record "Project EHO"; Handled: Boolean)
    begin
    end;

}
