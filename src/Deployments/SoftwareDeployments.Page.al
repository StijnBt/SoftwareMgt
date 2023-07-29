page 50922 "Software Deployments EHO"
{

    ApplicationArea = All;
    Caption = 'Software Deployments';
    PageType = List;
    SourceTable = "Software Deployment EHO";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                    Visible = ProjectCodeVisible;
                }
                field("Deployment Code"; Rec."Deployment Code")
                {
                    ApplicationArea = All;
                    Visible = DeploymentCodeVisible;
                }
                field("Software Code"; Rec."Software Code")
                {
                    ApplicationArea = All;
                }
                field(Version; Rec."Version")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        DeploymentCodeVisible: Boolean;
        ProjectCodeVisible: Boolean;

    trigger OnOpenPage()
    begin
        ProjectCodeVisible := GetFilter("Project Code") = '';
        DeploymentCodeVisible := GetFilter("Deployment Code") = '';
    end;

}
