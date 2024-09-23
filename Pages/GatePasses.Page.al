page 50091 "Gate Passes"
{
    CardPageID = "Gate Pass";
    PageType = List;
    SourceTable = Table50068;
    SourceTableView = WHERE (Status = FILTER (<> Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Gate-Pass Date"; "Gate-Pass Date")
                {
                }
                field("Vehicle No."; "Vehicle No.")
                {
                }
                field("Driver Name"; "Driver Name")
                {
                }
                field("Escort Vehicle No."; "Escort Vehicle No.")
                {
                }
                field("Supervisor Name"; "Supervisor Name")
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field(Status; Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

