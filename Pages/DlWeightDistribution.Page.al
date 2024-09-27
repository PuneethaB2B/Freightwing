page 50050 "Dl. Weight Distribution"
{
    Caption = 'Daily Weight Distribution';
    PageType = Card;
    PromotedActionCategories = ' New,Posting,Reports,Notification,C5,C6,C7,C8,C9,C10';
    SourceTable = 50040;
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
            part(Page; 50051)
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
                        REPORT.RUNMODAL(50090, FALSE, FALSE, DlWeightDistByItem);
                    END;
                end;
            }
        }
    }

    var
        DailyWeightDistByCustomer: Record 50042;
        DlWeightDistByItem: Record 50043;
}

