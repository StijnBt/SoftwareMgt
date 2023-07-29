page 50913 "Software Object Range List EHO"
{
    Caption = 'Software Object Range List';
    PageType = List;
    SourceTable = "Software Object Range EHO";
    UsageCategory = Lists;
    ApplicationArea = All;
    DelayedInsert = true;

    layout
    {

        area(content)
        {
            repeater(Group)
            {

                field("Software Code"; Rec."Software Code")
                {
                    ApplicationArea = All;
                    Caption = 'Software Code';
                    Tooltip = 'Specifies the Software Code.';
                    Visible = ShowProjectCode;
                }

                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                    Caption = 'Object Type';
                    Tooltip = 'Specifies the Object Type.';
                }

                field("Object ID Range"; Rec."Object ID Range")
                {
                    ApplicationArea = All;
                    Caption = 'Object ID Range';
                    Tooltip = 'Specifies the Object ID Range.';
                }

                field("Field ID Range"; Rec."Field ID Range")
                {
                    ApplicationArea = All;
                    Caption = 'Field ID Range';
                    Tooltip = 'Specifies the Field ID Range.';
                    Enabled = (("Object Type" = "Object Type"::Table) or ("Object Type" = "Object Type"::"TableExtension"));
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            Action(RunCopyRange)
            {
                Caption = 'Copy Software Oject Range';
                RunObject = Report "Copy Software Oject Range EHO";
                PromotedCategory = Process;
                Promoted = true;
                ApplicationArea = All;
            }
        }
    }

    var
        ShowProjectCode: Boolean;

    trigger OnOpenPage()
    begin
        ShowProjectCode := (Rec.GetFilter("Software Code") = '');
    end;

}