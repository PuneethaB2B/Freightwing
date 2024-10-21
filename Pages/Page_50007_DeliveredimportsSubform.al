page 50007 "Delivered imports Subform"
{
    Editable = false;
    PageType = List;
    SourceTable = "Pre Alert Line";
    ApplicationArea = All;
    UsageCategory=Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Pre Alert No"; Rec."Pre Alert No")
                {
                    Editable = false;
                }
                field("HAWB No"; Rec."HAWB No")
                {
                }
                field("HAWB Date"; Rec."HAWB Date")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                }
                field("Consignee Code"; Rec."Consignee Code")
                {
                }
                field("C&F Agent"; Rec."C&F Agent")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Barcode No"; Rec."Barcode No")
                {
                }
            }
        }
    }

    actions
    {
    }
}

