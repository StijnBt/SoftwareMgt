page 50902 "Event Horizon RC Cue Page EHO"
{
    PageType = CardPart;
    SourceTable = "Event Horizon RC Cue EHO";
    Caption = ' ';

    layout
    {
        area(content)
        {
            cuegroup(JobCueContainer)
            {
                Caption = 'Jobs';
                Visible = false;
                //CuegroupLayout=Wide;
                //ShowCaption = false;
                field(OpenJobs; Rec."Open Jobs")
                {
                    ApplicationArea = All;
                    Caption = 'Open Jobs';
                    DrillDownPageId = "Job List";
                    ToolTip = 'Open Jobs';
                }
                field(ClosedJobs; Rec."Closed Jobs")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Jobs';
                    DrillDownPageId = "Job List";
                    ToolTip = 'Closed Jobs';
                }
            }

            cuegroup(ResourceCueContainer)
            {
                Caption = 'Resources';
                //Visible = false;
                //CuegroupLayout=Wide;
                //ShowCaption = false;
                field(AvailableResources; Rec."Available Resources")
                {
                    ApplicationArea = All;
                    Caption = 'Available Resources';
                    DrillDownPageId = "Resource List";
                    ToolTip = 'Available Resources';
                }
            }

            cuegroup(ContactCueContainer)
            {
                Caption = 'Contacts';
                //CuegroupLayout=Wide;
                //ShowCaption = false;
                //Visible = false;
                field(Customers; Rec."Customers")
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    Visible = false;
                    ToolTip = 'Customers';
                }


                field(VendorsContacts; Rec."Vendors")
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    Visible = false;
                    ToolTip = 'Vendors';
                }


                field(Other; Rec."Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'Contacts';
                    ToolTip = 'Contacts';
                }

            }

            cuegroup(SoftwareCueContainer)
            {
                Caption = 'Software';

                field("Software Active Base"; Rec."Software Active Base")
                {
                    ApplicationArea = All;
                    Caption = 'Base BC/NAV';
                }

                field("Software Active Product"; Rec."Software Active Product")
                {
                    ApplicationArea = All;
                    Caption = 'Product';
                }

                field("Software Support"; Rec."Software Support")
                {
                    ApplicationArea = All;
                    Caption = 'Support';
                    ToolTip = 'Support Software';
                }

                field("Software Custom"; Rec."Software Custom")
                {
                    ApplicationArea = All;
                    Caption = 'Custom';
                    Visible = false;
                }
            }

            cuegroup(DeploymentCueContainer)
            {
                Caption = 'Projects & Deployments';
                field(Projects; Rec."Active Projects")
                {
                    ApplicationArea = All;
                    Caption = 'Active Projects';
                    ToolTip = 'Active Projects';
                }

                field("External Deployments"; Rec."External Deployments")
                {
                    ApplicationArea = All;
                    Caption = 'External Deployments';
                    ToolTip = 'External Deployments';
                }

                field("Internal Deployments"; Rec."Internal Deployments")
                {
                    ApplicationArea = All;
                    Caption = 'Internal Deployments';
                    ToolTip = 'Internal Deployments';
                }
            }

            /*
                        cuegroup(Administration)
                        {
                            Caption = 'Administration';

                            field(DataExchangeDefinitions; "Data Exchange Definitions")
                            {
                                ApplicationArea = All;
                                Caption = 'Data Exchange Definitions';
                                DrillDownPageId = "Data Exch Def List";
                                Visible = false;
                                ToolTip = 'Data Exchange Definitions';
                            }
                        }
            */
            cuegroup("My User Tasks")
            {
                Caption = 'My User Tasks';
                Visible = false;
                field("UserTaskManagement.GetMyPendingUserTasksCount"; UserTaskManagement.GetMyPendingUserTasksCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending User Tasks';
                    Image = Checklist;
                    ToolTip = 'Specifies the number of pending tasks that are assigned to you or to a group that you are a member of.';

                    trigger OnDrillDown()
                    var
                        UserTaskList: Page "User Task List";
                    begin
                        UserTaskList.SetPageToShowMyPendingUserTasks();
                        UserTaskList.Run();
                    end;
                }
            }


        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                    CuesAndKpis: Codeunit "Cues And KPIs";
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }



    trigger OnOpenPage();
    begin
        InitCue();
        SetFilter("User ID Filter", UserId());
    end;

    var
        UserTaskManagement: Codeunit "User Task Management";
}