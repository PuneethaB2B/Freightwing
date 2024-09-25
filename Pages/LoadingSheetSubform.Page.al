page 50081 "Loading Sheet Subform"
{
    PageType = ListPart;
    SourceTable = 50061;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Division/Farm Code"; Rec."Division/Farm Code")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Skid Per"; Rec."Skid Per")
                {
                    Caption = 'Boxes per Skid';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'No. Of Boxes';
                }
                field("In Stock"; Rec."In Stock")
                {
                    Editable = false;
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                    Editable = false;
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                    Editable = false;
                }
                field("FWL Docket Weight"; Rec."FWL Docket Weight")
                {
                    Editable = false;
                }
                field("FWL Gross Weight"; Rec."FWL Gross Weight")
                {
                    Caption = 'FWL Received Weight';
                    Editable = false;
                }
                field("Airline Docket Weight"; Rec."Airline Docket Weight")
                {
                }
                field("Volume Metric Weight"; Rec."Volume Metric Weight")
                {
                    Editable = false;
                }
                field(Position; Rec.Position)
                {
                }
                field("Arrival Temperature"; Rec."Arrival Temperature")
                {
                    Editable = false;
                }
                field("Departure Temperature"; Rec."Departure Temperature")
                {
                    ShowMandatory = true;
                }
                field("Vaccum Temperature"; Rec."Vaccum Temperature")
                {
                }
                field("X-Ray"; Rec."X-Ray")
                {
                    Editable = false;
                }
                field("Flight Code"; Rec."Flight Code")
                {
                    Editable = false;
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    Editable = false;
                }
                field("Airline Code"; Rec."Airline Code")
                {
                    Editable = false;
                }
                field(Dimension; Rec.Dimension)
                {
                    Editable = false;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                }
                field(Length; Rec.Length)
                {
                }
                field(Width; Rec.Width)
                {
                }
                field(Height; Rec.Height)
                {
                }
                field("Consignee Code"; Rec."Consignee Code")
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
                action(GetGoodsReceiptLines)
                {
                    AccessByPermission = TableData 120 = R;
                    Caption = '&Get Good Receipt Lines';
                    Image = Receipt;

                    trigger OnAction()
                    begin
                        GetBookingSheetLines();
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
                    RunObject = Page 50085;
                    RunPageLink = "Loading Sheet No." = FIELD("Loading Sheet No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Item No." = FIELD("Item No."),
                                  "MWAB No." = FIELD("MAWB No."),
                                  FAM = FIELD("Division/Farm Code"),
                                  Consignee = FIELD("Consignee Code");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("& Notify Parties")
                {
                    Caption = '& Notify Parties';
                    Image = EntriesList;
                    RunObject = Page 50086;
                    RunPageLink = "Loading Sheet No." = FIELD("Loading Sheet No."),
                                  "Shipper Code" = FIELD("Shipper Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Item No." = FIELD("Item No.");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }


    procedure GetBookingSheetLines()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Goods Receipt", Rec);
    end;
}

