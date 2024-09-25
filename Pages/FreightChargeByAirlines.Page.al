page 50040 "Freight Charge By Airlines"
{
    CardPageID = "Freight Charge By Airline";
    PageType = List;
    SourceTable = 50025;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Airline Name"; Rec."Airline Name")
                {
                }
                field("Effective Start Date"; Rec."Effective Start Date")
                {
                }
                field("Effective End Date"; Rec."Effective End Date")
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
        Rec.SETFILTER("Effective End Date", '>=%1', TODAY);
    end;

    var
        G: Record 50025;
        CopyChargesJob: Report 50104;
}

