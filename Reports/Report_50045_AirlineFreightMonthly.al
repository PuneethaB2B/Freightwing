report 50045 "Airline Freight Monthly"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/AirlineFreightMonthly.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Header 2"; "MAWB Header 2")
        {
            DataItemTableView = WHERE("Purchase Posting Date"=FILTER(<>''));
            RequestFilterFields = "No.","Airline Code","Purchase Posting Date";
            column(MAWB_AirlineCode;"MAWB Header 2"."Airline Code")
            {
            }
            column(MAWB_AirLine_Name;gRecAirline.Name)
            {
            }
            column(ItemNo;gCodeItemNo)
            {
            }
            column(ItemDescription;gCodeItemDesc)
            {
            }
            column(ItemWeight;gDecItemTotalWeight)
            {
            }
            column(PostingDate;"MAWB Header 2"."Purchase Posting Date")
            {
            }
            column(TotalAmount;gDecItemTotalAmount)
            {
            }
            column(Company_City;gRecCompanyInfo.City)
            {
            }
            column(Company_Address;gRecCompanyInfo.Address)
            {
            }
            column(Company_PostCode;gRecCompanyInfo."Post Code")
            {
            }
            column(Company_Picture;gRecCompanyInfo.Picture)
            {
            }
            column(MAWB_No;"MAWB Header 2"."No.")
            {
            }
            column(IncludeBreakDown;gBoolIncludeBreakDown)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // To Fetch Airline Name
                gRecAirline.GET("MAWB Header 2"."Airline Code");

                //Fetch Item No.
                gDecItemTotalWeight := 0;
                gRecMAWBLine.RESET;
                gRecMAWBLine.SETRANGE("MAWB No.","MAWB Header 2"."No.");
                IF gRecMAWBLine.FINDSET THEN BEGIN
                  gCodeItemNo := gRecMAWBLine."Item No.";
                  gCodeItemDesc := gRecMAWBLine.Description;
                    REPEAT
                      gDecItemTotalWeight += gRecMAWBLine."Chargeable Weight";
                    UNTIL gRecMAWBLine.NEXT = 0;
                END;

                //Calculate Total Amount from Purchase Invoices
                gDecItemTotalAmount := 0;
                gDecPurchInvLine.RESET;
                gDecPurchInvLine.SETRANGE("Posting Date","MAWB Header 2"."Purchase Posting Date");
                gDecPurchInvLine.SETRANGE("Payment Voucher No.","MAWB Header 2"."No.");
                gDecPurchInvLine.SETFILTER("Charge Code",'%1|%2','14','82');
                IF gDecPurchInvLine.FINDSET THEN
                  REPEAT
                    gDecItemTotalAmount += gDecPurchInvLine.Amount;
                  UNTIL gDecPurchInvLine.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                gRecCompanyInfo.GET;
                gRecCompanyInfo.CALCFIELDS(gRecCompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Include Breakdown";gBoolIncludeBreakDown)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        gDecItemTotalWeight: Decimal;
        gDecItemTotalAmount: Decimal;
        gRecAirline: Record 50021;
        gCodeTempMawbNo: Code[20];
        gDecPurchInvLine: Record 123;
        gRecMAWBLine: Record 50076;
        gCodeItemNo: Code[20];
        gCodeItemDesc: Text[50];
        gRecCompanyInfo: Record 79;
        gBoolIncludeBreakDown: Boolean;
}

