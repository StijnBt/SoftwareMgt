page 50907 "Remote Source Functions EHO"
{

    ApplicationArea = All;
    Caption = 'Remote Source Functions';
    PageType = List;
    SourceTable = "Remote Source Function EHO";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Remote Source Code"; Rec."Remote Source Code")
                {
                    ApplicationArea = All;
                    Visible = RemoteSourceCodeVisible;
                }
                field("Function Type"; Rec."Function Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Function Url"; Rec."Function Url")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        RemoteSourceCodeVisible: Boolean;

    trigger OnOpenPage()
    begin
        RemoteSourceCodeVisible := (Rec.GetFilter("Remote Source Code") = '');
    end;

}
