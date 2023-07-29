page 50926 "Project Software List EHO"
{

    ApplicationArea = All;
    Caption = 'Project Software List';
    PageType = List;
    SourceTable = "Project Software EHO";
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
                    Visible = ProjectCustomerVisible;
                }
                field("Software Code"; Rec."Software Code")
                {
                    ApplicationArea = All;
                }
                field("Software Description"; "Software Description")
                {
                    ApplicationArea = all;
                }
                field("Customer Contact No."; Rec."Customer Contact No.")
                {
                    ApplicationArea = All;
                    Visible = ProjectCustomerVisible;
                }
            }
        }
    }

    var
        ProjectCustomerVisible: Boolean;


    trigger OnOpenPage()
    begin
        ProjectCustomerVisible := GetFilter("Project Code") = '';
    end;

}
