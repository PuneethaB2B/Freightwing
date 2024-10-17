page 50067 "Released Gate Pass Subform"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Gate Pass Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MAWB No."; Rec."MAWB No.")
                {
                    Editable = true;
                }
                field("ULD No."; Rec."ULD No.")
                {
                }
                field("HAWB No"; Rec."HAWB No")
                {
                }
                field("Certificate Of Origin"; Rec."Certificate Of Origin")
                {
                    Editable = false;
                }
                field("Custom Entry No"; Rec."Custom Entry No")
                {
                    Editable = false;
                }
                field("Phyto Certificate"; Rec."Phyto Certificate")
                {
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                Visible = false;
                action(GetLoadingSheetLines)
                {
                    Caption = '&Get Loading Sheet Lines';
                    Image = EntriesList;
                    Visible = false;

                    trigger OnAction()
                    begin
                        GetLoadingSheet();
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                Visible = false;
                action("& ULD Allocation")
                {
                    Caption = '& ULD Allocation';
                    Image = EntriesList;
                    RunObject = Page "Gate Pass ULD Allocations";
                    //RunPageLink ="Booking Sheet No" = FIELD("Gate-Pass No."), "Weight Allocated" = FIELD("Item No.");  //B2BUPG

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }


    procedure GetLoadingSheet()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Loading Sheet", Rec);
    end;
}

