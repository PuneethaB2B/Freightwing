page 50090 "Gate Pass Subform"
{
    PageType = ListPart;
    SourceTable = Table50069;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MAWB No."; "MAWB No.")
                {
                    Editable = true;
                }
                field("ULD No."; "ULD No.")
                {
                }
                field("HAWB No"; "HAWB No")
                {
                }
                field("Certificate Of Origin"; "Certificate Of Origin")
                {
                    Editable = false;
                }
                field("Custom Entry No"; "Custom Entry No")
                {
                    Editable = false;
                }
                field("Phyto Certificate"; "Phyto Certificate")
                {
                    Editable = false;
                }
                field(Remarks; Remarks)
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
                action("& ULD Allocation")
                {
                    Caption = '& ULD Allocation';
                    Image = EntriesList;
                    RunObject = Page 50093;
                    RunPageLink = Booking Sheet No=FIELD(Gate-Pass No.),
                                  Weight Allocated=FIELD(Item No.);

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
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Loading Sheet",Rec);
    end;
}

