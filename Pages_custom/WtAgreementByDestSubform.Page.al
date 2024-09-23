page 50042 "Wt. Agreement By Dest. Subform"
{
    Caption = 'Weight Agreement By Destination Subform';
    PageType = ListPart;
    SourceTable = Table50034;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Code"; "Source Code")
                {
                }
                field("Source Airport"; "Source Airport")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Destination Airport"; "Destination Airport")
                {
                }
                field("Gross Weight"; "Gross Weight")
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
                    RunPageLink = Airline Code=FIELD(Airline Code),
                                  Source Code=FIELD(Source Code),
                                  Destination Code=FIELD(Destination Code),
                                  Destination Airport=FIELD(Destination Airport),
                                  Source Airport=FIELD(Source Airport);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

