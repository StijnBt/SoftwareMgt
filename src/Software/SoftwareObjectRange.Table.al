table 50913 "Software Object Range EHO"
{
    Caption = 'Software Object Range';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Software Object Range List EHO";
    LookupPageId = "Software Object Range List EHO";

    fields
    {
        field(1; "Software Code"; Code[30])
        {
            Caption = 'Software Code';
            DataClassification = ToBeClassified;
            TableRelation = "Software EHO";
        }
        field(2; "Object Type"; Option)
        {
            Caption = 'Object Type';
            DataClassification = ToBeClassified;
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension";
            OptionCaption = ',Table,,Report,,Codeunit,XMLport,,Page,Query,,,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension';

            trigger OnValidate()
            begin
                if "Object ID Range" <> '' then
                    Clear("Object ID Range");
            end;

        }
        field(3; "Object ID Range"; Text[100])
        {
            Caption = 'Object ID Range';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Object ID Range" := ValidateFilter("Object ID Range");
            end;
        }
        field(4; "Field ID Range"; Text[100])
        {
            Caption = 'Field ID Range';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Field ID Range" := ValidateFilter("Field ID Range");
            end;
        }

        field(5; "NAV/BC Base Application"; Boolean)
        {
            Caption = 'NAV/BC Base Application';
            FieldClass = FlowField;
            CalcFormula = exist("Software EHO" where("Code" = field("Software Code")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Software Code", "Object Type", "Object ID Range")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestField("Object ID Range");
    end;

    local procedure ValidateFilter(Range: Text) FilterExpression: Text
    var
        "Integer": Record Integer;
        RecRef: RecordRef;
    begin
        "Integer".Reset();
        "Integer".SetFilter(Number, Range);


        exit("Integer".GetFilter(Number));

    end;

}
