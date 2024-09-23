page 50035 "Freight Charge Flight Subform"
{
    PageType = ListPart;
    SourceTable = Table50026;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Flight Code"; "Flight Code")
                {
                    Editable = false;
                }
                field("Source Country"; "Source Country")
                {
                    Editable = false;
                }
                field("Source Airport"; "Source Airport")
                {
                    Editable = false;
                }
                field("Destination Country"; "Destination Country")
                {
                    Editable = false;
                }
                field("Destination Airport"; "Destination Airport")
                {
                    Editable = false;
                }
                field("Destination Code"; "Destination Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Destination Name"; "Destination Name")
                {
                    Editable = false;
                    Visible = false;
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
                action("& Freight Charge By Item")
                {
                    Caption = '& Freight Charge By Item';
                    Image = ItemLines;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 50036;
                    RunPageLink = Flight Code=FIELD(Flight Code),
                                  Destination Airport=FIELD(Destination Airport),
                                  Source Airport=FIELD(Source Airport),
                                  Airline Code=FIELD(Airline Code),
                                  Effective Start Date=FIELD(Effective Start Date),
                                  Effective End Date=FIELD(Effective End Date);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

