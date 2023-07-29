page 50900 "Event Horizon Setup EHO"
{

    Caption = 'Event Horizon Setup';
    PageType = Card;
    SourceTable = "Event Horizon Setup EHO";
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Company Contact No."; Rec."Company Contact No.")
                {
                    ApplicationArea = All;
                }

                field("Microsoft Contact No."; Rec."Microsoft Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Serv. Mgr. Service Filter"; Rec."Serv. Mgr. Service Filter")
                {
                    ApplicationArea = All;
                }
                field("Version No. Date Format"; Rec."Version No. Date Format")
                {
                    ApplicationArea = All;
                }

                field("Current Base Roll-out Version"; Rec."Current Base Roll-out Version")
                {
                    ApplicationArea = All;
                }
            }

            group("No. Series")
            {
                field("Software No. Series"; "Software No. Series")
                {
                    ApplicationArea = All;
                }
                field("Project No. Series"; "Project No. Series")
                {
                    ApplicationArea = All;
                }
                field("Deployment No. Series"; "Deployment No. Series")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        InitSetup();
    end;

}
