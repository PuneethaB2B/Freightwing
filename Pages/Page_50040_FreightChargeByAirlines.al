page 50040 "Freight Charge By Airlines"
{
    CardPageID = "Freight Charge By Airline";
    PageType = List;
    SourceTable = "Freight Charge By Airline";
    ApplicationArea = All;
    UsageCategory = Lists;

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
        G: Record "Freight Charge By Airline";
        CopyChargesJob: Report "Copy Charges -Job";
}

