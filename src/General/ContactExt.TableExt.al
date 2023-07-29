tableextension 50900 "ContactExt EHO" extends Contact
{
    fields
    {
        field(50900; "Internal"; Boolean)
        {
            Caption = 'Internal';
            FieldClass = FlowField;
            CalcFormula = exist("Event Horizon Setup EHO" where("Company Contact No." = field("Company No.")));
        }
    }
}
