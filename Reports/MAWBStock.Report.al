report 50041 "MAWB Stock"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MAWBStock.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50038)
        {
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyPostalCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyPostalCity; CompanyInfo.City)
            {
            }
            column(AirlineCode_MAWBByAirline; "MAWB By Airline"."Airline Code")
            {
            }
            column(AirlineName_MAWBByAirline; "MAWB By Airline"."Airline Name")
            {
            }
            column(MAWBFees_MAWBByAirline; "MAWB By Airline"."MAWB Fees")
            {
            }
            column(FreightChargeCode_MAWBByAirline; "MAWB By Airline"."Freight Charge Code")
            {
            }
            column(KAAFees_MAWBByAirline; "MAWB By Airline"."KAA Fees")
            {
            }
            dataitem(DataItem1000000006; Table50039)
            {
                DataItemLink = Airline Code=FIELD(Airline Code);
                DataItemTableView = SORTING(Airline Code, MAWB No.)
                                    ORDER(Ascending)
                                    WHERE(MAWB No.=FILTER(<>''));
                column(AirlineCode_MAWBReceipt;"MAWB Receipt"."Airline Code")
                {
                }
                column(MAWBNo_MAWBReceipt;"MAWB Receipt"."MAWB No.")
                {
                }
                column(ReceiptDate_MAWBReceipt;"MAWB Receipt"."Receipt Date")
                {
                }
                column(MAWBFees_MAWBReceipt;"MAWB Receipt"."MAWB Fees")
                {
                }
                column(Assigned_MAWBReceipt;"MAWB Receipt".Assigned)
                {
                }
                column(FreightChargeCode_MAWBReceipt;"MAWB Receipt"."Freight Charge Code")
                {
                }
                column(Prepared_MAWBReceipt;"MAWB Receipt".Prepared)
                {
                }
                column(PrefixCode_MAWBReceipt;"MAWB Receipt"."Prefix Code")
                {
                }
                column(BillNo_MAWBReceipt;"MAWB Receipt"."Bill No.")
                {
                }
                column(StartNo_MAWBReceipt;"MAWB Receipt"."Start No.")
                {
                }
                column(EndNo_MAWBReceipt;"MAWB Receipt"."End No.")
                {
                }
                column(KAAFees_MAWBReceipt;"MAWB Receipt"."KAA Fees")
                {
                }

                trigger OnPreDataItem()
                begin
                    SETFILTER("MAWB Receipt".Assigned,'=%1',FALSE);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInfo: Record "79";
}

