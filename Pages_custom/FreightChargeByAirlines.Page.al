page 50040 "Freight Charge By Airlines"
{
    CardPageID = "Freight Charge By Airline";
    PageType = List;
    SourceTable = Table50025;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Airline Code"; "Airline Code")
                {
                }
                field("Airline Name"; "Airline Name")
                {
                }
                field("Effective Start Date"; "Effective Start Date")
                {
                }
                field("Effective End Date"; "Effective End Date")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnOpenPage()
    begin
        SETFILTER("Effective End Date", '>=%1', TODAY);
    end;

    var
        G: Record "50025";
        CopyChargesJob: Report "50104";
}

