page 50112 "Offloaded Gate Pass Form"
{
    PageType = Card;
    SourceTable = 50071;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No1; Rec.No)
                {
                }
                field("Gate Pass No"; Rec."Gate Pass No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Total Loaded Boxes"; Rec."Total Loaded Boxes")
                {
                }
                field("Total Loaded Docket Weight"; Rec."Total Loaded Docket Weight")
                {
                }
                field("Total Offloaded Boxes"; Rec."Total Offloaded Boxes")
                {
                }
                field("Total Offloaded Weight"; Rec."Total Offloaded Weight")
                {
                }
                field("Diffrence- Boxes"; Rec."Total Loaded Boxes" - Rec."Total Offloaded Boxes")
                {
                }
                field("Difference-Weights"; Rec."Total Loaded Docket Weight" - Rec."Total Offloaded Weight")
                {
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(page; 50113)
            {
                SubPageLink = "Gate-Pass No." = FIELD("Gate Pass No"),
                              No = FIELD(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Submit)
            {
                Image = SuggestField;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Submit this for Processing?') THEN BEGIN
                        Rec.Status := Rec.Status::Submitted;
                        Rec.MODIFY;
                        CurrPage.CLOSE;
                    END;
                end;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = PostedOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CALCFIELDS("Total Offloaded Boxes");
                    Rec.TESTFIELD("Total Offloaded Boxes");
                    Rec.TESTFIELD(Status, Rec.Status::Submitted);
                    IF CONFIRM('Do you want to Post The Offload?') THEN BEGIN
                        Rec.Process;
                        //MESSAGE('Posted');
                        CurrPage.CLOSE;
                    END;
                end;
            }
        }
    }
}

