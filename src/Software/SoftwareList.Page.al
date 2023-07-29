page 50911 "Software List EHO"
{

    PageType = List;
    SourceTable = "Software EHO";
    Caption = 'Software List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Software Card EHO";
    //PromotedActionCategories = 'New,Process,Report,Navigate';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                    Style = Strong;
                    StyleExpr = "Base Application";
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }

                field(Description2; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description 2';
                    Visible = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }


                field(OwnerName; "Owner Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner Name';
                }
                field(OwnerNo; "Owner No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Owner No.';
                }

                field(DistributorNo; "Distributor No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Distributor No.';
                }

                field(DistributorName; "Distributor Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Distributor Name';
                }

                field("Base Application"; "Base Application")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Base Application';
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                    ToolTip = 'Product';
                    Visible = false;
                }

                field("NAV/BC Target"; "NAV/BC Target")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'NAV/BC Target';
                }

                field("Last Version Update"; Rec."Last Version Update")
                {
                    ApplicationArea = all;
                    ToolTip = 'Last Version Update';
                }

            }
        }

        area(FactBoxes)
        {
            part("Software Inf. FactBox EHO"; "Software Inf. FactBox EHO")
            {
                SubPageLink = Code = field(Code);
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {

        area(Processing)
        {
            action(RefreshVersions)
            {
                ApplicationArea = All;
                Image = Refresh;
                Caption = 'Refresh Versions';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;
                Enabled = false;
                Description = 'Better do from Job Queue';

                trigger OnAction()
                var
                    Software: Record "Software EHO";
                    RefreshVersionsCfrm: Label 'Are you sure you wish to refresh the versions?';
                begin
                    if not Confirm(RefreshVersionsCfrm, false, "Code") then
                        exit;

                    Software := Rec;
                    CurrPage.SetSelectionFilter(Software);

                    if Software.FindSet(true, false) then
                        repeat
                            Software.RefreshVersions(true);
                        until Software.Next() < 1;
                end;
            }

            action(DownloadLatestVersion)
            {
                ApplicationArea = All;
                Image = MoveDown;
                Caption = 'Download Latest Version';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Software: Record "Software EHO";
                begin
                    Software := Rec;
                    CurrPage.SetSelectionFilter(Software);

                    Rec.DownloadLastestVersion(Software);

                    /* Software.SetAutoCalcFields("Latest Version");

                    if Software.FindSet() then begin
                        ConfigProgressBar.Init(Software.Count, 1, 'Downloading...');
                        repeat
                            ConfigProgressBar.Update(Software.Description + ' - ' + Software."Latest Version");
                        //Software.DownLoadLatestVersion();
                        until Software.Next() < 1;
                        ConfigProgressBar.Close();
                    end; */
                end;
            }
        }
        area(Navigation)
        {
            Action(Versions)
            {
                ApplicationArea = All;
                Caption = 'Versions';
                RunObject = Page "Software Versions List EHO";
                RunPageLink = "Software Code" = field("Code");
                Promoted = true;
                PromotedIsBig = true;
                //PromotedCategory = Category4;
                Image = Versions;
            }

            Action("Object Ranges")
            {
                ApplicationArea = All;
                Caption = 'Object Ranges';
                RunObject = Page "Software Object Range List EHO";
                RunPageLink = "Software Code" = field("Code");
                Promoted = true;
                PromotedIsBig = true;
                //PromotedCategory = Category4;
                Image = Ranges;
            }

        }
    }

    var
        ConfigProgressBar: Codeunit "Config. Progress Bar";
}