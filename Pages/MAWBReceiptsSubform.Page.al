page 50048 "MAWB Receipts Subform"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = Table50039;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MAWB No."; "MAWB No.")
                {
                }
                field("Receipt Date"; "Receipt Date")
                {
                }
                field(Prepared; Prepared)
                {
                    Editable = false;
                }
                field(Assigned; Assigned)
                {
                    Editable = false;
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
                action("&Create MAWB")
                {
                    Caption = '&Create MAWB';
                    Image = CreateSerialNo;

                    trigger OnAction()
                    begin
                        //CLEAR(CreateMAWB);
                        MAWBByAirline.GET("Airline Code");
                        Airline.GET(MAWBByAirline."Airline Code");
                        //Message(Airline."Prefix Code");
                        //CreateMAWB.RUNMODAL;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("&Charges")
                {
                    Caption = '&Charges';
                    Image = EntriesList;
                    RunObject = Page 50229;
                    RunPageLink = Field5 = FIELD (Airline Code),
                                  Field6=FIELD(MAWB No.);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(Reset)
                {

                    trigger OnAction()
                    begin
                        TESTFIELD(Invoiced,FALSE);
                        IF CONFIRM('Do you want to reset the MAWB to Documentation?') THEN BEGIN
                          Prepared:=FALSE;
                          MODIFY();
                        END;
                    end;
                }
                action("Reopen for Invoice")
                {

                    trigger OnAction()
                    begin
                        IF CONFIRM('') THEN BEGIN
                          Invoiced:=FALSE;
                          "Invioced Date":=0D;
                          MODIFY;
                        END;
                    end;
                }
            }
        }
    }

    var
        MAWBByAirline: Record "50038";
        Airline: Record "50021";
}

