page 50924 "Project Roles EHO"
{

    ApplicationArea = All;
    Caption = 'Project Roles';
    PageType = List;
    SourceTable = "Project Role EHO";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Project Role"; Rec."Project Role")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
