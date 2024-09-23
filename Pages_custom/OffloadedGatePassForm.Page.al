page 50112 "Offloaded Gate Pass Form"
{
    PageType = Card;
    SourceTable = Table50071;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                }
                field("Gate Pass No"; "Gate Pass No")
                {
                }
                field(Description; Description)
                {
                }
                field("Total Loaded Boxes"; "Total Loaded Boxes")
                {
                }
                field("Total Loaded Docket Weight"; "Total Loaded Docket Weight")
                {
                }
                field("Total Offloaded Boxes"; "Total Offloaded Boxes")
                {
                }
                field("Total Offloaded Weight"; "Total Offloaded Weight")
                {
                }
                field("Diffrence- Boxes"; "Total Loaded Boxes" - "Total Offloaded Boxes")
                {
                }
                field("Difference-Weights"; "Total Loaded Docket Weight" - "Total Offloaded Weight")
                {
                }
                field("Created By"; "Created By")
                {
                    Editable = false;
                }
                field("Created On"; "Created On")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                    Editable = false;
                }
            }
            part(; 50113)
            {
                SubPageLink = Gate-Pass No.=FIELD(Gate Pass No),
                              No=FIELD(No);
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
                        Status := Status::Submitted;
                        MODIFY;
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
                    CALCFIELDS("Total Offloaded Boxes");
                    TESTFIELD("Total Offloaded Boxes");
                    TESTFIELD(Status, Status::Submitted);
                    IF CONFIRM('Do you want to Post The Offload?') THEN BEGIN
                        Process;
                        //MESSAGE('Posted');
                        CurrPage.CLOSE;
                    END;
                end;
            }
        }
    }
}

