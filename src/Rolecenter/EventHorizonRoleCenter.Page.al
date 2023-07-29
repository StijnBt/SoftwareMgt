page 50903 "Event Horizon Role Center EHO"
{

    PageType = RoleCenter;
    Caption = 'Event Horizon Role Center';

    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Event Horizon Headline RC EHO")
            {
                ApplicationArea = Basic, Suite;
            }

            part(EHOCue; "Event Horizon RC Cue Page EHO")
            {
                AccessByPermission = TableData "Event Horizon RC Cue EHO" = I;
                ApplicationArea = Basic, Suite;
            }


            part(Control16; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            part(Control55; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
                Caption = '';
                Visible = false;
            }


            part(MyJobs; "My Jobs")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            part(MyCustomers; "My Customers")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }


            part(PowerBi; "Power BI Report Spinner Part")
            {
                AccessByPermission = TableData "Power BI User Configuration" = I;
                ApplicationArea = Basic, Suite;
            }
            part(ReportInbox; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Suite;
            }
        }


    }

    actions
    {
        area(Sections)
        {
            group(Software)
            {
                Caption = 'Software Mgt.';

                Action("Software List")
                {
                    ApplicationArea = All;
                    Caption = 'Software';
                    RunObject = Page "Software List EHO";
                }

                Action("Object Ranges")
                {
                    ApplicationArea = All;
                    Caption = 'Object Ranges';
                    RunObject = Page "Software Object Range List EHO";
                }

                Action("Software Versions")
                {
                    ApplicationArea = All;
                    Caption = 'Software Versions';
                    RunObject = Page "Software Versions List EHO";
                }

            }

            group(Projects)
            {
                Caption = 'Projects';

                Action("Project List EHO")
                {
                    ApplicationArea = All;
                    Caption = 'Projects';
                    RunObject = Page "project List EHO";
                }

                Action("Project Software List EHO")
                {
                    ApplicationArea = All;
                    Caption = 'Project software';
                    RunObject = Page "Project Software List EHO";
                }
            }

            group(Deployments)
            {
                Caption = 'Deployments';

                Action("Deployment List EHO")
                {
                    ApplicationArea = All;
                    Caption = 'Deployments';
                    RunObject = Page "Deployment List EHO";
                }

                Action("Software Deployments")
                {
                    ApplicationArea = All;
                    Caption = 'Software Deployments';
                    RunObject = Page "Software Deployments EHO";
                }
            }
            group(Crm)
            {
                Caption = 'Crm';
                Visible = false;

                Action("Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'Contacts';
                    RunObject = Page "Contact List";
                }
            }

            group(Hrm)
            {
                Caption = 'Hrm';
                Visible = false;

                Action("Internal Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Contacts';
                    RunObject = Page "Contact List";
                    RunPageLink = "Internal" = const(true);
                }

                Action("Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Employees';
                    RunObject = Page "Employee List";
                }
            }

            group(Admin)
            {
                Caption = 'Administration';

                Action("Remote Source List")
                {
                    ApplicationArea = All;
                    Caption = 'Remote Sources';
                    RunObject = Page "Remote Source List EHO";
                }

                Action("Project Roles")
                {
                    ApplicationArea = All;
                    Caption = 'Project Roles';
                    RunObject = Page "Project Roles EHO";
                }

                Action("Configuration Packages")
                {
                    ApplicationArea = All;
                    Caption = 'Configuration Packages';
                    RunObject = Page "Config. Packages";
                }

                Action("Event Horizon Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Event Horizon Setup';
                    RunObject = Page "Event Horizon Setup EHO";
                }

                group(Setup)
                {
                    Action("Marketing Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Marketing Setup';
                        RunObject = Page "Marketing Setup";
                    }
                }

            }
        }

        area(processing)
        {
            group(NewGroup)
            {
                Caption = 'New';
                action("SoftwareAct")
                {
                    ApplicationArea = All;
                    Caption = 'Software';
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Software Card EHO";
                    RunPageMode = Create;
                }
                action("ProjectAct")
                {
                    ApplicationArea = All;
                    Caption = 'Project';
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = page "Project Card EHO";
                    RunPageMode = Create;
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks';

                action("ServiceMgr")
                {
                    ApplicationArea = All;
                    Caption = 'Service Manager';
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = page "Service Manager EHO";
                    RunPageMode = Create;
                }

            }
        }



    }

}
