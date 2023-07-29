page 50921 "Deployment List EHO"
{

    ApplicationArea = All;
    Caption = 'Deployment List';
    PageType = List;
    SourceTable = "Deployment EHO";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
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

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                    Visible = ProjectCodeVisible;
                }

                field("No. Of Software"; Rec."No. Of Software")
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
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    var
        ProjectCodeVisible: Boolean;

    trigger OnOpenPage()
    begin
        ProjectCodeVisible := GetFilter("Project Code") = '';
    end;

}
