page 50052 "Dl. Weight Dist. By Customer"
{
    Caption = 'Daily Weight Distribution By Customer';
    PageType = List;
    PromotedActionCategories = ' New,Process,Reports,Weight,Notification,C6,C7,C8,C9,C10';
    SourceTable = "Dl. Weight Dist. By Customer";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Shipped Weight"; Rec."Shipped Weight")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Weight By Item")
            {
                Caption = 'Weight By Item';
                Image = Print;
                action("&Weight By Item")
                {
                    Caption = '&Weight By Item';
                    Ellipsis = false;
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Dl. Weight Dist. By Item";
                    RunPageLink = "Daily No." = FIELD("Daily No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Destination Code" = FIELD("Destination Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Customer No." = FIELD("Customer No."),
                                  "Destination Airport" = FIELD("Destination Airport");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
                Image = Email;
                action("&Email")
                {
                    Caption = '&Email';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalesInvHeader: Record "Sales Invoice Header";
                    begin
                        //DailyWeightDistByCustomer := Rec;
                        //CurrPage.SETSELECTIONFILTER(DailyWeightDistByCustomer);
                        IF CONFIRM(Text001, FALSE) THEN BEGIN
                            DailyWeightDistByCustomer.RESET;
                            DailyWeightDistByCustomer.SETRANGE(DailyWeightDistByCustomer."Daily No.", Rec."Daily No.");
                            IF DailyWeightDistByCustomer.FINDSET THEN BEGIN
                                REPEAT
                                    DailyWeightDistByCustomer2.RESET;
                                    DailyWeightDistByCustomer2.COPY(DailyWeightDistByCustomer);
                                    DailyWeightDistByCustomer2.SETRANGE(DailyWeightDistByCustomer2."Customer No.", DailyWeightDistByCustomer."Customer No.");
                                    IF DailyWeightDistByCustomer2.FINDFIRST THEN BEGIN
                                        DailyWeightDistByCustomer2.EmailRecords(FALSE, DailyWeightDistByCustomer2);
                                    END;
                                UNTIL DailyWeightDistByCustomer.NEXT = 0;
                            END;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec.DELETE THEN BEGIN
            WeightByItem.RESET;
            WeightByItem.SETRANGE(WeightByItem."Daily No.", Rec."Daily No.");
            WeightByItem.SETRANGE(WeightByItem."Airline Code", Rec."Airline Code");
            WeightByItem.SETRANGE(WeightByItem."Flight Code", Rec."Flight Code");
            WeightByItem.SETRANGE(WeightByItem."Destination Code", Rec."Destination Code");
            WeightByItem.SETRANGE(WeightByItem."Customer No.", Rec."Customer No.");
            IF WeightByItem.FINDSET THEN BEGIN
                WeightByItem.DELETEALL;
            END;
        END;
    end;

    var
        DailyWeightDistByAirline: Record "Dl. Weight Dist. By Airline";
        DailyWeightDistByCustomer: Record "Dl. Weight Dist. By Customer";
        Text001: Label 'Do you want to send the notifications';
        DailyWeightDistByCustomer2: Record "Dl. Weight Dist. By Customer";
        WeightByItem: Record "Dl. Weight Dist. By Item";
}

