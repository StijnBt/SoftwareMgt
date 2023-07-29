table 50903 "Service Mgr. EHO"
{
    Caption = 'Service';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Status; Text[50])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }

        field(4; "Service Name"; Text[200])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    [Scope('OnPrem')]
    procedure GetServices()
    var
        EventHorizonSetup: Record "Event Horizon Setup EHO";
        ServiceCounter: Integer;
        DotArray: DotNet DotNet_Array;
        ServiceController: DotNet DotNet_ServiceController;
        ServiceControllerStatus: DotNet DotNet_ServiceControllerStatus;
    begin
        EventHorizonSetup.Get();

        Rec.DeleteAll();

        ServiceCounter := 1;

        DotArray := ServiceController.GetServices();

        foreach ServiceController in DotArray do begin
            if ServiceController.DisplayName.Contains(EventHorizonSetup."Serv. Mgr. Service Filter") then begin
                Init();
                "Entry No." := ServiceCounter;
                Name := ServiceController.DisplayName;
                ServiceControllerStatus := ServiceController.Status;
                Status := ServiceControllerStatus.ToString();
                "Service Name" := ServiceController.ServiceName;
                Insert();
                ServiceCounter += 1;
            end;
        end;

        Clear(DotArray);
        Clear(ServiceControllerStatus);
        Clear(ServiceController);
    end;

    [Scope('OnPrem')]
    procedure StartService()
    var
        ServiceCounter: Integer;
        DotArray: DotNet DotNet_Array;
        ServiceController: DotNet DotNet_ServiceController;
        ServiceControllerStatus: DotNet DotNet_ServiceControllerStatus;
    begin
        ServiceCounter := 1;

        DotArray := ServiceController.GetServices();

        foreach ServiceController in DotArray do begin
            if ServiceController.ServiceName = "Service Name" then begin
                ServiceControllerStatus := ServiceController.Status;

                if (ServiceControllerStatus.ToString() = 'Stopped') then
                    ServiceController.Start();

                exit;
            end;
        end;

        Clear(DotArray);
        Clear(ServiceControllerStatus);
        Clear(ServiceController);
    end;

    [Scope('OnPrem')]
    procedure StopService()
    var
        ServiceCounter: Integer;
        DotArray: DotNet DotNet_Array;
        ServiceController: DotNet DotNet_ServiceController;
        ServiceControllerStatus: DotNet DotNet_ServiceControllerStatus;
    begin
        ServiceCounter := 1;

        DotArray := ServiceController.GetServices();

        foreach ServiceController in DotArray do begin
            if ServiceController.ServiceName = "Service Name" then begin
                ServiceControllerStatus := ServiceController.Status;

                if (ServiceControllerStatus.ToString() = 'Started') and (ServiceController.CanStop) then
                    ServiceController.Stop();

                exit;
            end;
        end;

        Clear(DotArray);
        Clear(ServiceControllerStatus);
        Clear(ServiceController);
    end;

    [Scope('OnPrem')]
    procedure RestartService()
    var
        ServiceCounter: Integer;
        DotArray: DotNet DotNet_Array;
        ServiceController: DotNet DotNet_ServiceController;
        ServiceControllerStatus: DotNet DotNet_ServiceControllerStatus;
    begin
        ServiceCounter := 1;

        DotArray := ServiceController.GetServices();

        foreach ServiceController in DotArray do begin
            if ServiceController.ServiceName = "Service Name" then begin
                ServiceControllerStatus := ServiceController.Status;

                if (ServiceControllerStatus.ToString() = 'Started') and (ServiceController.CanStop) then begin
                    ServiceController.Stop();
                    Sleep(30000);
                    ServiceController.Start();
                end;

                exit;
            end;
        end;

        Clear(DotArray);
        Clear(ServiceControllerStatus);
        Clear(ServiceController);
    end;

}
