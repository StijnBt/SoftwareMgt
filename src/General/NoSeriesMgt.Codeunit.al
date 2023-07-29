codeunit 50901 "No. Series Mgt. EHO"
{
    procedure InitNo(var RecRef: RecordRef; var xRecRef: RecordRef)
    var
        EventHorizonSetupEHO: Record "Event Horizon Setup EHO";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        NoField: FieldRef;
        NoSeriesField: FieldRef;
        NoSeriesFieldXRec: FieldRef;
        IsHandled: Boolean;
        DefaultNoSeriesCode: Code[20];
        No: Code[20];
        NoSeriesCode: Code[20];
    begin

        OnBeforeInitNo(IsHandled);

        if IsHandled then
            exit;

        //EventHorizonSetupEHO.Get();

        NoField := RecRef.field(1);
        No := NoField.Value();
        NoSeriesField := RecRef.field(12);
        NoSeriesCode := NoSeriesField.Value();

        NoSeriesFieldXRec := xRecRef.field(12);

        if Format(NoField.Value) = '' then
            DefaultNoSeriesCode := GetDefaultNoSeriesCode(RecRef);

        NoSeriesManagement.InitSeries(DefaultNoSeriesCode, Format(NoSeriesFieldXRec.Value()), 0D, No, NoSeriesCode);

        NoSeriesField.Value(NoSeriesCode);
        NoField.Value(No);
    end;

    procedure TestManual(var RecRef: RecordRef; var xRecRef: RecordRef)
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        NoField: FieldRef;
        NoFieldXRec: FieldRef;
    begin
        NoField := RecRef.field(1);
        NoFieldXRec := RecRef.field(1);

        if NoField.Value <> NoFieldXRec.Value then
            NoSeriesManagement.TestManual(GetDefaultNoSeriesCode(RecRef));
    end;

    procedure GetDefaultNoSeriesCode(RecRef: RecordRef) DefaultNoSeriesCode: Code[20]
    var
        EventHorizonSetupEHO: Record "Event Horizon Setup EHO";
        IsHandled: Boolean;
    begin
        OnBeforeGetDefaultNoSeriesCode(IsHandled);

        EventHorizonSetupEHO.Get();

        if IsHandled then
            exit;

        case RecRef.Number of
            Database::"Project EHO":
                begin
                    EventHorizonSetupEHO.TestField("Project No. Series");
                    DefaultNoSeriesCode := EventHorizonSetupEHO."Project No. Series";
                end;
            Database::"Deployment EHO":
                begin
                    EventHorizonSetupEHO.TestField("Deployment No. Series");
                    DefaultNoSeriesCode := EventHorizonSetupEHO."Deployment No. Series";
                end;
            Database::"Software EHO":
                begin
                    EventHorizonSetupEHO.TestField("Software No. Series");
                    DefaultNoSeriesCode := EventHorizonSetupEHO."Software No. Series";
                end;
        end;
    end;

    procedure AssistEdit(RecRef: RecordRef; xRecRef: RecordRef): Boolean
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        NoField: FieldRef;
        NoSeriesField: FieldRef;
        NoSeriesFieldXRec: FieldRef;
        IsHandled: Boolean;
        No: Code[20];
        NoSeriesCode: Code[20];
    begin
        OnBeforeAssistEdit(RecRef, xRecRef, IsHandled);

        NoField := RecRef.field(1);
        No := NoField.Value();

        NoSeriesField := RecRef.field(12);
        NoSeriesCode := NoSeriesField.Value();

        NoSeriesFieldXRec := xRecRef.field(12);

        if NoSeriesManagement.SelectSeries(GetDefaultNoSeriesCode(RecRef), NoSeriesFieldXRec.Value, NoSeriesCode) then begin
            NoSeriesField.Value(NoSeriesCode);
            NoSeriesManagement.SetSeries(No);
            NoField.Value(No);
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInitNo(IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDefaultNoSeriesCode(IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAssistEdit(RecRef: RecordRef; xRecRef: RecordRef; IsHandled: Boolean)
    begin
    end;
}