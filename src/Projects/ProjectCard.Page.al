page 50923 "Project Card EHO"
{

    Caption = 'Project Card';
    PageType = Card;
    SourceTable = "Project EHO";
    //PromotedActionCategories = 'New,Process,Report,Navigate';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        NoSeriesMgtEHO: Codeunit "No. Series Mgt. EHO";
                        RecRef: RecordRef;
                        XRecRef: RecordRef;
                    begin
                        RecRef.getTable(Rec);
                        XRecRef.GetTable(xRec);
                        NoSeriesMgtEHO.AssistEdit(RecRef, XRecRef)
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Customer Contact No."; Rec."Customer Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Contact Name"; Rec."Customer Contact Name")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
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
