page 50914 "Software Image CardPart EHO"
{

    Caption = 'Image';
    PageType = CardPart;
    SourceTable = "Software EHO";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Image; Image)
                {
                    ApplicationArea = All;
                    ToolTip = 'Image';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            Action(UploadImage)
            {
                ApplicationArea = All;
                Caption = 'Upload Image';
                ToolTip = 'Upload Image';
                Image = Picture;

                trigger OnAction()
                begin
                    UploadImage();
                end;
            }

            Action(DownloadImage)
            {
                ApplicationArea = All;
                Caption = 'Download Image';
                ToolTip = 'Download Image';
                Image = Picture;

                trigger OnAction()
                begin
                    DownloadImage();
                end;
            }

            Action(ClearImage)
            {
                ApplicationArea = All;
                Caption = 'Clear Image';
                ToolTip = 'Clear Image';
                Image = Picture;

                trigger OnAction()
                begin
                    ClearImage();
                end;
            }
        }

    }
}