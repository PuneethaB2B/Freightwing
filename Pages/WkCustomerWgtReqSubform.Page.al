page 50062 "Wk. Customer Wgt. Req. Subform"
{
    Caption = 'Weekly Customer Requirement Subform';
    PageType = ListPart;
    SourceTable = 50048;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Line Weight"; Rec."Line Weight")
                {
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
                action("Weight By Day of Week")
                {
                    Caption = 'Weight By Day of Week';
                    Image = EntriesList;
                    RunObject = Page 50063;
                    RunPageLink = "Good Receipt No." = FIELD("Weekly No."),
                                  "Airline Code" = FIELD("Customer No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
    }
}

