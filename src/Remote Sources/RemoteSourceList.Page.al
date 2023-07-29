page 50901 "Remote Source List EHO"
{

    ApplicationArea = All;
    Caption = 'Remote Source List';
    PageType = List;
    SourceTable = "Remote Source EHO";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; "Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
                field("Access Token"; Rec."Access Token")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        if IsolatedStorage.Get(FieldCaption("Access Token"), DataScope::Module, "Access Token") then begin
                            Message("Access Token");
                            "Access Token" := '***';
                        end;
                    end;
                }

                field("No Of Functions"; Rec."No Of Functions")
                {
                    ApplicationArea = All;
                }

                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Navigation)
        {
            Action(Functions)
            {
                ApplicationArea = All;
                Caption = 'Functions';
                RunObject = Page "Remote Source Functions EHO";
                RunPageLink = "Remote Source Code" = field("Code");
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
            }
        }
    }

}
