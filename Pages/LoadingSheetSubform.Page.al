page 50081 "Loading Sheet Subform"
{
    PageType = ListPart;
    SourceTable = Table50061;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    Editable = false;
                }
                field("Division/Farm Code"; "Division/Farm Code")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Skid Per"; "Skid Per")
                {
                    Caption = 'Boxes per Skid';
                }
                field(Quantity; Quantity)
                {
                    Caption = 'No. Of Boxes';
                }
                field("In Stock"; "In Stock")
                {
                    Editable = false;
                }
                field("Shipper Code"; "Shipper Code")
                {
                    Editable = false;
                }
                field("MAWB No."; "MAWB No.")
                {
                    Editable = false;
                }
                field("FWL Docket Weight"; "FWL Docket Weight")
                {
                    Editable = false;
                }
                field("FWL Gross Weight"; "FWL Gross Weight")
                {
                    Caption = 'FWL Received Weight';
                    Editable = false;
                }
                field("Airline Docket Weight"; "Airline Docket Weight")
                {
                }
                field("Volume Metric Weight"; "Volume Metric Weight")
                {
                    Editable = false;
                }
                field(Position; Position)
                {
                }
                field("Arrival Temperature"; "Arrival Temperature")
                {
                    Editable = false;
                }
                field("Departure Temperature"; "Departure Temperature")
                {
                    ShowMandatory = true;
                }
                field("Vaccum Temperature"; "Vaccum Temperature")
                {
                }
                field("X-Ray"; "X-Ray")
                {
                    Editable = false;
                }
                field("Flight Code"; "Flight Code")
                {
                    Editable = false;
                }
                field("Destination Code"; "Destination Code")
                {
                    Editable = false;
                }
                field("Airline Code"; "Airline Code")
                {
                    Editable = false;
                }
                field(Dimension; Dimension)
                {
                    Editable = false;
                }
                field("Consignee Name"; "Consignee Name")
                {
                }
                field(Length; Length)
                {
                }
                field(Width; Width)
                {
                }
                field(Height; Height)
                {
                }
                field("Consignee Code"; "Consignee Code")
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
                    RunPageLink = Loading Sheet No.=FIELD(Loading Sheet No.),
                                  Airline Code=FIELD(Airline Code),
                                  Item No.=FIELD(Item No.),
                                  MWAB No.=FIELD(MAWB No.),
                                  FAM=FIELD(Division/Farm Code),
                                  Consignee=FIELD(Consignee Code);

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
                                    RunPageLink = Loading Sheet No.=FIELD(Loading Sheet No.),
                                  Shipper Code=FIELD(Shipper Code),
                                  Flight Code=FIELD(Flight Code),
                                  Airline Code=FIELD(Airline Code),
                                  Item No.=FIELD(Item No.);

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
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Goods Receipt",Rec);
    end;
}

