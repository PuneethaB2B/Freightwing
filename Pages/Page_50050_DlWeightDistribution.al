page 50050 "Dl. Weight Distribution"
{
    Caption = 'Daily Weight Distribution';
    PageType = Card;
    PromotedActionCategories = ' New,Posting,Reports,Notification,C5,C6,C7,C8,C9,C10';
    SourceTable = "Dl. Weight Dist. Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Distribution Date"; Rec."Distribution Date")
                {
                }
                field("Day of Week"; Rec."Day of Week")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
            part(Page; "Dl. Weight Dist. By Airline")
            {
                SubPageLink = "Daily No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Validate Shipped Weights")
            {
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Validate?') THEN BEGIN
                        DlWeightDistByItem.RESET;
                        DlWeightDistByItem.SETRANGE(DlWeightDistByItem."Daily No.", Rec."No.");
                        REPORT.RUNMODAL(Report::"Validate Dl. Dist", FALSE, FALSE, DlWeightDistByItem);
                    END;
                end;
            }
        }
    }

    var
        DailyWeightDistByCustomer: Record "Dl. Weight Dist. By Customer";
        DlWeightDistByItem: Record "Dl. Weight Dist. By Item";
}

