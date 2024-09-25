page 50025 "Notify Party Card"
{
    PageType = Card;
    SourceTable = 50017;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Type; Rec.Type)
                {
                }
                field("Type Code"; Rec."Type Code")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Home Page"; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
    }

    actions
    {
    }
}

