page 50062 "Wk. Customer Wgt. Req. Subform"
{
    Caption = 'Weekly Customer Requirement Subform';
    PageType = ListPart;
    SourceTable = Table50048;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; "Customer No.")
                {
                }
                field("Customer Name"; "Customer Name")
                {
                }
                field("Line Weight"; "Line Weight")
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
                    RunPageLink = Good Receipt No.=FIELD(Weekly No.),
                                  Airline Code=FIELD(Customer No.);
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
    }
}

