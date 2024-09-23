page 50105 "Archived HAWB Subform"
{
    AutoSplitKey = true;
    Caption = 'House Airway Bill Subform';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = Table50074;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HAWB No."; "HAWB No.")
                {
                }
                field("Item No."; "Item No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                }
                field("Division/Farm Code"; "Division/Farm Code")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Gross Weight"; "Gross Weight")
                {
                }
                field("Rate/Charge"; "Rate/Charge")
                {
                    Visible = false;
                }
                field("Chargeable Weight"; "Chargeable Weight")
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
                action(GetHAWBItemLines)
                {
                    Caption = 'Get &HAWB Items';
                    Ellipsis = true;
                    Image = Shipment;

                    trigger OnAction()
                    begin
                        GetHAWBItem;
                    end;
                }
            }
        }
    }

    [Scope('Internal')]
    procedure GetHAWBItem()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get BS HAWB Item", Rec);
    end;
}

