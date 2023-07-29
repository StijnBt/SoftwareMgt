page 50904 "Event Horizon Headline RC EHO"
{
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group("Event Horizon Headline")
            {
                Visible = AppNameHeadlineVisible;
                ShowCaption = false;
                Editable = false;

                field(FirstInsight; FirstInsightText)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'First Insight';
                    Caption = 'First Insight';
                    trigger OnDrillDown();
                    var
                    begin
                        OnDrillDownFirstInsight();
                    end;

                }
                field(SecondInsight; SecondInsightText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Second Insight';
                    ToolTip = 'Second Insight';
                    trigger OnDrillDown();
                    var
                    begin
                        OnDrillDownSecondInsight();
                    end;
                }

            }
        }
    }

    var
        [InDataSet]
        AppNameHeadlineVisible: Boolean;
        FirstInsightText: Text;
        SecondInsightText: Text;

    trigger OnOpenPage()
    begin
        HandleVisibility();

        HandleFirstInsight();
        HandleSecondInsight();

        OnSetVisibility(AppNameHeadlineVisible);
    end;


    local procedure HandleVisibility()
    var
    begin
        AppNameHeadlineVisible := true;
    end;


    local procedure HandleFirstInsight();
    var
        Headlines: Codeunit Headlines;
        PayloadText: Text;
        QualifierText: Text;
    begin
        PayloadText := Headlines.Emphasize('Some text to highlight') + ' Some other text';
        QualifierText := 'Some name of the insight';
        Headlines.GetHeadlineText(QualifierText, PayloadText, FirstInsightText);

    end;


    local procedure HandleSecondInsight();
    var
        Headlines: Codeunit Headlines;
        PayloadText: Text;
        QualifierText: Text;
    begin
        PayloadText := Headlines.Emphasize('Some text to highlight') + ' Some other text';
        QualifierText := 'Some name of the insight';
        Headlines.GetHeadlineText(QualifierText, PayloadText, SecondInsightText);

    end;


    local procedure OnDrillDownFirstInsight();
    var
    begin

    end;


    local procedure OnDrillDownSecondInsight();
    var
    begin

    end;

    [IntegrationEvent(false, false)]
    local procedure OnSetVisibility(var AppNameHeadlineVisible: Boolean)
    begin
    end;
}