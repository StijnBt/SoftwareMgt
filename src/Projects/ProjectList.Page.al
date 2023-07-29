page 50920 "Project List EHO"
{

    ApplicationArea = All;
    Caption = 'Project List';
    PageType = List;
    SourceTable = "Project EHO";
    UsageCategory = Lists;
    CardPageId = "Project Card EHO";
    //PromotedActionCategories = 'New,Process,Report,Navigate';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
                field("Contact No."; Rec."Customer Contact No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Contact Name"; Rec."Customer Contact Name")
                {
                    ApplicationArea = All;
                }

                field("No. Of Project Role Relations"; Rec."No. Of Project Role Relations")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("No. Of Deployments"; Rec."No. Of Deployments")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            Action(CreateDtap)
            {
                ApplicationArea = All;
                Caption = 'Create DTAP Deployments';
                Image = New;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CreateDTAPDeploymentsMeth: Codeunit "Create DTAP Deplmts. Meth. EHO";
                begin
                    CreateDTAPDeploymentsMeth.CreateDTAPDeployments(Rec, false);
                end;
            }
        }
        area(Navigation)
        {

            Action(Software)
            {
                ApplicationArea = All;
                Caption = 'Software';
                RunObject = Page "Project Software List EHO";
                RunPageLink = "Project Code" = field("Code");
                Promoted = true;
                PromotedIsBig = true;
                //PromotedCategory = Category4;
                Image = Inventory;
            }



            Action(Roles)
            {
                ApplicationArea = All;
                Caption = 'Roles';
                RunObject = Page "Project Role Relations EHO";
                RunPageLink = "Project Code" = field("Code");
                Promoted = true;
                PromotedIsBig = true;
                //PromotedCategory = Category4;
                Image = Users;
            }

            Action(Deployments)
            {
                ApplicationArea = All;
                Caption = 'Deployments';
                RunObject = Page "Deployment List EHO";
                RunPageLink = "Project Code" = field("Code");
                Promoted = true;
                PromotedIsBig = true;
                //PromotedCategory = Category4;
                Image = WorkCenter;
            }

        }
    }

}
