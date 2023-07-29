report 50900 "Copy Software Oject Range EHO"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Copy Software Oject Range';

    dataset
    {
        dataitem(SoftwareObjectRangeEHO; "Software Object Range EHO")
        {
            DataItemTableView = sorting("Software Code");
            RequestFilterFields = "Software Code", "Object Type", "Object ID Range";
        }
    }


    requestpage
    {
        layout
        {
            area(content)
            {

                group(Options)
                {
                    Caption = 'Options';
                    field(TargetSoftwareObjectRange; TargetSoftwareObjectRange)
                    {
                        ApplicationArea = All;
                        TableRelation = "Software EHO";
                        Caption = 'Target Software';
                        ToolTip = 'Target Software';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        SourceSoftwareObjectRange: Code[30];
        TargetSoftwareObjectRange: Code[30];

    trigger OnPostReport()
    var
        CopyObjectRangeMethEHO: Codeunit "CopyObjectRange Meth EHO";
        ErrFilters: Label 'Please define filters';
    begin
        if SoftwareObjectRangeEHO.GetFilters = '' then
            Error(ErrFilters);

        CopyObjectRangeMethEHO.CopyObjectRange(SoftwareObjectRangeEHO, TargetSoftwareObjectRange, false);
    end;
}
