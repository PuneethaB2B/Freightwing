page 50035 "Freight Charge Flight Subform"
{
    PageType = ListPart;
    SourceTable = "Freight Charge By Flight";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Flight Code"; Rec."Flight Code")
                {
                    Editable = false;
                }
                field("Source Country"; Rec."Source Country")
                {
                    Editable = false;
                }
                field("Source Airport"; Rec."Source Airport")
                {
                    Editable = false;
                }
                field("Destination Country"; Rec."Destination Country")
                {
                    Editable = false;
                }
                field("Destination Airport"; Rec."Destination Airport")
                {
                    Editable = false;
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Destination Name"; Rec."Destination Name")
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
                    RunObject = Page "Freight Charge By Item";
                    RunPageLink = "Flight Code" = FIELD("Flight Code"),
                                  "Destination Airport" = FIELD("Destination Airport"),
                                  "Source Airport" = FIELD("Source Airport"),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Effective Start Date" = FIELD("Effective Start Date"),
                                  "Effective End Date" = FIELD("Effective End Date");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

