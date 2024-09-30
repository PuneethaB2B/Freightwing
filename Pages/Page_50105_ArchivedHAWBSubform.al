page 50105 "Archived HAWB Subform"
{
    AutoSplitKey = true;
    Caption = 'House Airway Bill Subform';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = 50074;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HAWB No."; Rec."HAWB No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Division/Farm Code"; Rec."Division/Farm Code")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Rate/Charge"; Rec."Rate/Charge")
                {
                    Visible = false;
                }
                field("Chargeable Weight"; Rec."Chargeable Weight")
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


    procedure GetHAWBItem()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get BS HAWB Item", Rec);
    end;
}

