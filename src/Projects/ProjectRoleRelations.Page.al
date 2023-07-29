page 50925 "Project Role Relations EHO"
{

    ApplicationArea = All;
    Caption = 'Project Role Relations';
    PageType = List;
    SourceTable = "Project Role Relation EHO";
    UsageCategory = Lists;
    PopulateAllFields = true;

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
                field("Project Role"; Rec."Project Role")
                {
                    ApplicationArea = All;
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpression;
                }
                field(Note; Rec.Note)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        StyleExpression: Text;
        ProjectCodeVisible: Boolean;


    trigger OnOpenPage()
    begin
        ProjectCodeVisible := GetFilter("Project Code") = '';
    end;

    trigger OnAfterGetRecord()

    begin
        SetStyle();
    end;

    local procedure SetStyle()
    var
        EventHorizonSetup: Record "Event Horizon Setup EHO";
        Contact: Record Contact;
    begin
        Clear(StyleExpression);

        EventHorizonSetup.Get();

        if EventHorizonSetup."Company Contact No." = '' then
            exit;

        Contact.Reset();
        Contact.SetRange("Company No.", EventHorizonSetup."Company Contact No.");
        Contact.SetRange("No.", Rec."Contact No.");

        if (not Contact.IsEmpty) then
            StyleExpression := 'Strong';
    end;

}
