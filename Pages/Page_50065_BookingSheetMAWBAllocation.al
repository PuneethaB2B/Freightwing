page 50065 "Booking Sheet MAWB Allocation"
{
    PageType = List;
    SourceTable = "Booking Sheet MAWB Allocation";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Booking Sheet No"; Rec."Booking Sheet No")
                {
                    Visible = false;
                }
                field("Item No"; Rec."Item No")
                {
                    Visible = false;
                }
                field("MAWB No"; Rec."MAWB No")
                {
                }
                field("Weight Allocated"; Rec."Weight Allocated")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Flight No"; Rec."Flight No")
                {
                    Visible = false;
                }
                field("Airline Code"; Rec."Airline Code")
                {
                    Visible = false;
                }
                field(BSA; Rec.BSA)
                {
                }
                field(Houses; Rec.Houses)
                {
                }
                field(Comment; Rec.Comment)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Consignees)
            {
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Booking Sheet Consignee Alloca";
                RunPageLink = "Booking Sheet No." = FIELD("Booking Sheet No"),
                              "Airline Code" = FIELD("Airline Code"),
                              "Destination Airport" = FIELD("Destination Airport"),
                              "Source Airport" = FIELD("Source Airport"),
                              "MAWB No." = FIELD("MAWB No"),
                              "Shipper Code" = FIELD("Shipper Code");
            }
        }
    }
}

