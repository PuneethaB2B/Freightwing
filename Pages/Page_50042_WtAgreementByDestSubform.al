page 50042 "Wt. Agreement By Dest. Subform"
{
    Caption = 'Weight Agreement By Destination Subform';
    PageType = ListPart;
    SourceTable = 50034;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Code"; Rec."Source Code")
                {
                }
                field("Source Airport"; Rec."Source Airport")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Destination Airport"; Rec."Destination Airport")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("& Weight By Day of Week")
                {
                    Caption = '& Weight By Day of Week';
                    Image = EntriesList;
                    RunObject = Page 50043;
                    RunPageLink = "Airline Code" = FIELD("Airline Code"),
                                  "Source Code" = FIELD("Source Code"),
                                  "Destination Code" = FIELD("Destination Code"),
                                  "Destination Airport" = FIELD("Destination Airport"),
                                  "Source Airport" = FIELD("Source Airport");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

