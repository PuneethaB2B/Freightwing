page 50025 "Notify Party Card"
{
    PageType = Card;
    SourceTable = Table50017;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Type; Type)
                {
                }
                field("Type Code"; "Type Code")
                {
                }
                field(Name; Name)
                {
                }
                field("Home Page"; "Home Page")
                {
                    Caption = 'Home Page';
                }
                field(Address; Address)
                {
                }
                field("Address 2"; "Address 2")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field(City; City)
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field(Blocked; Blocked)
                {
                }
            }
        }
    }

    actions
    {
    }
}

