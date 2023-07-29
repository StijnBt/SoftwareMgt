page 50905 "Service Manager EHO"
{
    ApplicationArea = All;
    Caption = 'Service Manager';
    PageType = List;
    SourceTable = "Service Mgr. EHO";
    UsageCategory = Lists;
    SourceTableTemporary = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            Action(Refresh)
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Page;
                Image = Refresh;
                trigger OnAction()
                begin
                    GetServices()
                end;
            }
            group(ActionGroup)
            {
                Caption = 'Actions';

                Action(Start)
                {
                    ApplicationArea = All;
                    Caption = 'Start';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    Image = Start;
                    trigger OnAction()
                    var
                        ServiceMgr: Record "Service Mgr. EHO";
                        StartServicesLbl: Label 'Starting service(s)..';
                    begin
                        ServiceMgr := Rec;
                        CurrPage.SetSelectionFilter(ServiceMgr);

                        if ServiceMgr.FindSet() then begin
                            ConfigProgressBar.Init(ServiceMgr.Count, 1, StartServicesLbl);
                            repeat
                                ConfigProgressBar.Update(ServiceMgr.Name);
                                ServiceMgr.StartService();
                            until ServiceMgr.Next() < 1;
                            ConfigProgressBar.Close();
                        end;
                    end;
                }

                Action(Restart)
                {
                    ApplicationArea = All;
                    Caption = 'Restart';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    Image = Restore;
                    Enabled = false;
                    trigger OnAction()
                    var
                        ServiceMgr: Record "Service Mgr. EHO";
                        RestartServicesLbl: Label 'Restarting service(s)..';
                    begin
                        ServiceMgr := Rec;
                        CurrPage.SetSelectionFilter(ServiceMgr);

                        if ServiceMgr.FindSet() then begin
                            ConfigProgressBar.Init(ServiceMgr.Count, 1, RestartServicesLbl);
                            repeat
                                ConfigProgressBar.Update(ServiceMgr.Name);
                                ServiceMgr.RestartService();
                            until ServiceMgr.Next() < 1;
                            ConfigProgressBar.Close();
                        end;
                    end;
                }

                Action(Stop)
                {
                    ApplicationArea = All;
                    Caption = 'Stop';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    Image = Stop;
                    trigger OnAction()
                    var
                        ServiceMgr: Record "Service Mgr. EHO";
                        StopServicesLbl: Label 'Stopping service(s)..';
                    begin
                        ServiceMgr := Rec;
                        CurrPage.SetSelectionFilter(ServiceMgr);

                        if ServiceMgr.FindSet() then begin
                            ConfigProgressBar.Init(ServiceMgr.Count, 1, StopServicesLbl);
                            repeat
                                ConfigProgressBar.Update(ServiceMgr.Name);
                                ServiceMgr.StopService();
                            until ServiceMgr.Next() < 1;
                            ConfigProgressBar.Close();
                        end;
                    end;
                }
            }
        }
    }

    var
        StatusStyle: Text;
        ConfigProgressBar: Codeunit "Config. Progress Bar";

    trigger OnOpenPage()
    begin
        Rec.GetServices();
    end;

    trigger OnAfterGetRecord()
    begin
        case Status of
            'Running':
                StatusStyle := 'Favorable';
            'Stopped':
                StatusStyle := 'Unfavorable';
            'StartPending', 'StopPending':
                StatusStyle := 'Ambiguous';
        end;
    end;



}
