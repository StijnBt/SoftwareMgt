page 50915 "Software Inf. FactBox EHO"
{
    Caption = 'Software Information';
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Software EHO";

    layout
    {
        area(Content)
        {
            cuegroup(CueGroup1)
            {
                ShowCaption = false;

                field("No Of Versions"; "No Of Versions")
                {
                    ApplicationArea = All;
                }

                field("No Of Ranges"; "No Of Ranges")
                {
                    ApplicationArea = All;
                }

                field("No. Of Deployments"; "No. Of Deployments")
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
            Action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}