page 50910 "Software Card EHO"
{
    Caption = 'Software Card';
    PageType = Card;
    SourceTable = "Software EHO";
    UsageCategory = None;
    DataCaptionFields = Code, Description;
    //PromotedActionCategories = 'New,Process,Report,Navigate';


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; "Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code';

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

                field("Base Application"; "Base Application")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }

                field("Product"; Rec.Product)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }

                field("NAV/BC Target"; "NAV/BC Target")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'NAV/BC Target';
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Description from the app.json for product software';
                }

                field(Description2; "Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description 2';
                }

                field(Image; Image)
                {
                    ApplicationArea = All;
                    ToolTip = 'Image';
                }

                field("Latest Version"; "Latest Version")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Latest Version';
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Status';
                }
            }

            group(Contact)
            {
                field(OwnerNo; "Owner No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner No.';
                }
                field(OwnerName; "Owner Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Owner Name';
                }

                field(DistributorNo; "Distributor No.")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                    Importance = Additional;
                    Visible = false;
                    ToolTip = 'Distributor No.';
                }

                field(DistributorName; "Distributor Name")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                    Importance = Additional;
                    Visible = false;
                    ToolTip = 'Distributor Name';
                }

            }

            group(Technical)
            {
                field(RemoteSource; "Remote Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Url';
                }
                field(RepositoryUrl; "Remote Source Url")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                    ToolTip = 'Url';
                }
                field(ExtensionGuid; "Extension Guid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Extension Guid';
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
            part(Imagepart; "Software Image CardPart EHO")
            {
                ApplicationArea = All;
                SubPageLink = Code = field(Code);
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

                trigger OnAction()
                begin
                    RefreshVersions(false);
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

}
