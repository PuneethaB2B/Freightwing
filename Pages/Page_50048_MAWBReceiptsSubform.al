page 50048 "MAWB Receipts Subform"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "MAWB Receipt";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field(Prepared; Rec.Prepared)
                {
                    Editable = false;
                }
                field(Assigned; Rec.Assigned)
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
                        MAWBByAirline.GET(Rec."Airline Code");
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
                    /* RunObject = Page 50229;
                    RunPageLink = Field5 = FIELD("Airline Code"),
                                  Field6 = FIELD("MAWB No.");  */ //B2BUPG due to Page 50229 is not found in client db

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(Reset)
                {

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Invoiced, FALSE);
                        IF CONFIRM('Do you want to reset the MAWB to Documentation?') THEN BEGIN
                            Rec.Prepared := FALSE;
                            Rec.MODIFY();
                        END;
                    end;
                }
                action("Reopen for Invoice")
                {

                    trigger OnAction()
                    begin
                        IF CONFIRM('') THEN BEGIN
                            Rec.Invoiced := FALSE;
                            Rec."Invioced Date" := 0D;
                            Rec.MODIFY;
                        END;
                    end;
                }
            }
        }
    }

    var
        MAWBByAirline: Record "MAWB By Airline";
        Airline: Record Airline;
}

