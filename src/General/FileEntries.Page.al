page 50906 "File Entries EHO"
{

    Caption = 'Files';
    PageType = List;
    SourceTable = "File Entry EHO";
    UsageCategory = None;
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    DataCaptionFields = "Full Path";
    LinksAllowed = false;
    SaveValues = false;
    SourceTableView = sorting("Sort Path", "Level");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = Level;
                ShowAsTree = true;
                TreeInitialState = CollapseAll;

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    StyleExpr = Folder;
                    Style = Strong;
                }
                field("Full Path"; Rec."Full Path")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sort Path"; Rec."Sort Path")
                {
                    ApplicationArea = All;
                    Visible = false;
                }


            }
        }
    }

    actions
    {

        area(Processing)
        {
            action(DownloadFile)
            {
                ApplicationArea = All;
                Caption = 'Download file';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Scope = Repeater;
                Image = MoveDown;

                trigger OnAction()
                var
                    FileEntry: Record "File Entry EHO";
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    Rec.Download(Rec);
                    Rec.Reset();
                end;
            }
        }

        area(Navigation)
        {

        }
    }

    trigger OnOpenPage()
    begin
        if FindFirst() then;

    end;

}
