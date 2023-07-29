page 50912 "Software Versions List EHO"
{

    PageType = List;
    SourceTable = "Software Version EHO";
    Caption = 'Software Versions';
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTableView = sorting("Software Code", "Version") order(descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Software Code"; "Software Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Software Code';
                    Visible = ShowProjectCode;
                }
                field(Version; "Version")
                {
                    ApplicationArea = All;
                    ToolTip = 'Version';
                }
                field("Release Date"; "Release Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Release Date';
                }

                field(Description; "Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                    Visible = false;
                }

                field(Url; "Url")
                {
                    ApplicationArea = All;
                    ToolTip = 'Url';
                    ExtendedDatatype = URL;

                    trigger OnDrillDown()
                    begin
                        Hyperlink(Url);
                    end;
                }

                field("Docker Path"; "Docker Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docker Path';
                    Visible = false;
                }


            }
        }

        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }

        }

    }

    actions
    {

        area(Processing)
        {
            action(Showfiles)
            {
                ApplicationArea = All;
                Caption = 'Files';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                begin
                    Rec.ShowFiles();
                end;
            }
        }

        area(Navigation)
        {

        }
    }


    var
        ShowProjectCode: Boolean;

    trigger OnOpenPage()
    begin
        ShowProjectCode := (Rec.GetFilter("Software Code") = '');
    end;


}
