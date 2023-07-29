codeunit 50903 "Validate Object Range Meth EHO"
{
    procedure ValidateObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO");
    var
        Handled: Boolean;
    begin
        OnBeforeValidateObjectRange(SoftwareObjectRangeEHO, Handled);

        DoValidateObjectRange(SoftwareObjectRangeEHO, Handled);

        OnAfterValidateObjectRange(SoftwareObjectRangeEHO);
    end;

    local procedure DoValidateObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO"; var Handled: Boolean);
    var
        DeploymentEHO: Record "Deployment EHO";
        SoftwareEHO: Record "Software EHO";
    begin
        if Handled then
            exit;

        SoftwareEHO.Get(SoftwareObjectRangeEHO."Software Code");

        if SoftwareEHO."Base Application" then
            exit;

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO"; var Handled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateObjectRange(var SoftwareObjectRangeEHO: Record "Software Object Range EHO");
    begin
    end;
}