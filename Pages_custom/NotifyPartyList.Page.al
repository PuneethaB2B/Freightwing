page 50026 "Notify Party List"
{
    CardPageID = "Notify Party Card";
    PageType = List;
    SourceTable = Table50017;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
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

