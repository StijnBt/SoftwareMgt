codeunit 50904 "Create DTAP Deplmts. Meth. EHO"
{
    internal procedure CreateDTAPDeployments(var ProjectEHO: Record "Project EHO"; HideDialog: Boolean);
    var
        Handled: Boolean;
    begin
        if not ConfirmCreateDTAPDeployments(ProjectEHO, HideDialog) then
            exit;
        OnBeforeCreateDTAPDeployments(ProjectEHO, Handled);
        DoCreateDTAPDeployments(ProjectEHO, Handled);
        OnAfterCreateDTAPDeployments(ProjectEHO);

        AcknowledgeCreateDTAPDeployments(ProjectEHO, HideDialog)
    end;

    local procedure DoCreateDTAPDeployments(var ProjectEHO: Record "Project EHO"; Handled: Boolean);
    var
        Deployment: Record "Deployment EHO";
        i: integer;
    begin
        if Handled then
            exit;

        for i := 1 to 4 do begin
            Clear(Deployment);
            Deployment.Init();

            case i of
                1:
                    begin
                        Deployment."Code" := 'DEV';
                        Deployment.Location := Deployment.Location::Internal;
                        Deployment.Type := Deployment.Type::Development;
                    end;
                2:
                    begin
                        Deployment."Code" := 'TEST';
                        Deployment.Location := Deployment.Location::External;
                        Deployment.Type := Deployment.Type::test;
                    end;
                3:
                    begin
                        Deployment."Code" := 'ACCP';
                        Deployment.Location := Deployment.Location::External;
                        Deployment.Type := Deployment.Type::Acceptance;
                    end;
                4:
                    begin
                        Deployment."Code" := 'PROD';
                        Deployment.Location := Deployment.Location::External;
                        Deployment.Type := Deployment.Type::Production;
                    end;
            end;

            Deployment."Project Code" := ProjectEHO."Code";
            Deployment."Starting Date" := Today;
            Deployment.Active := true;
            Deployment.Insert(true);
        end;
    end;

    local procedure ConfirmCreateDTAPDeployments(var ProjectEHO: Record "Project EHO"; HideDialog: Boolean): Boolean
    var
        ConfirmQst: label 'Are You Sure?';
    begin
        if Not GuiAllowed or HideDialog then exit(true);
        exit(Confirm(ConfirmQst));
    end;

    local procedure AcknowledgeCreateDTAPDeployments(var ProjectEHO: Record "Project EHO"; HideDialog: Boolean)
    var
        AcknowledgeMsg: label 'You successfully executed "Create DTAP Deployments"';
    begin
        if Not GuiAllowed or HideDialog then exit;
        Message(AcknowledgeMsg);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateDTAPDeployments(var ProjectEHO: Record "Project EHO"; var Handled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateDTAPDeployments(var ProjectEHO: Record "Project EHO");
    begin
    end;
}