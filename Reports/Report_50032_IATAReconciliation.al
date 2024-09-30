report 50032 "IATA Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/IATAReconciliation.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("IATA Purchase Invoice"; "IATA Purchase Invoice")
        {
            RequestFilterFields = "Airline Invoice No", "MAWB No.";
            column(IATAInvoiceDate_IATAPurchaseInvoice; "IATA Purchase Invoice"."Airline Invoice Date")
            {
            }
            column(MAWBNo_IATAPurchaseInvoice; "IATA Purchase Invoice"."MAWB No.")
            {
            }
            column(WeightAsPerFWL_IATAPurchaseInvoice; "IATA Purchase Invoice"."Weight As Per FWL")
            {
            }
            column(AmountAsPerFWL_IATAPurchaseInvoice; "IATA Purchase Invoice"."Amount As Per FWL")
            {
            }
            column(RatePerKiloAsPerFWL_IATAPurchaseInvoice; "IATA Purchase Invoice"."Rate Per Kilo As Per FWL")
            {
            }
            column(WeightAsPerIATA_IATAPurchaseInvoice; "IATA Purchase Invoice"."Weight as per Airline")
            {
            }
            column(AmountAsPerIATA_IATAPurchaseInvoice; "IATA Purchase Invoice"."Amount as per Airline")
            {
            }
            column(RatePerKiloAsPerIATA_IATAPurchaseInvoice; "IATA Purchase Invoice"."Airline Kilo Rate")
            {
            }
            column(DifferenceinWeight_IATAPurchaseInvoice; "IATA Purchase Invoice"."Difference in Weight")
            {
            }
            column(RateDifference_IATAPurchaseInvoice; "IATA Purchase Invoice"."Rate Difference")
            {
            }
            column(DifferenceInAmount_IATAPurchaseInvoice; "IATA Purchase Invoice"."Difference In Amount")
            {
            }
            column(Comments_IATAPurchaseInvoice; "IATA Purchase Invoice".Comments)
            {
            }
            column(LineNo_IATAPurchaseInvoice; "IATA Purchase Invoice"."Line No.")
            {
            }
            column(VendorNo_IATAPurchaseInvoice; "IATA Purchase Invoice"."Vendor No.")
            {
            }
            column(VendorName_IATAPurchaseInvoice; "IATA Purchase Invoice"."Vendor Name")
            {
            }
            column(BillingStartDate_IATAPurchaseInvoice; "IATA Purchase Invoice"."Billing Start Date")
            {
            }
            column(BillingEndDate_IATAPurchaseInvoice; "IATA Purchase Invoice"."Billing End Date")
            {
            }
            column(IATAInvoiceNo_IATAPurchaseInvoice; "IATA Purchase Invoice"."Airline Invoice No")
            {
            }
            column(Converted_IATAPurchaseInvoice; "IATA Purchase Invoice".Converted)
            {
            }
            column(PurchaseInvoiceNo_IATAPurchaseInvoice; "IATA Purchase Invoice"."Purchase Invoice No.")
            {
            }
            column(AirlineCode_IATAPurchaseInvoice; "IATA Purchase Invoice"."Airline Code")
            {
            }
            column(PurchaseACCode_IATAPurchaseInvoice; "IATA Purchase Invoice"."Purchase A/C Code")
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(PageCaption; PageCaptionCap)
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(PostCode; CompInfo."Post Code")
            {
            }
            column(CustomerName; Customer.Name)
            {
            }
            column(ItemName; Item.Description)
            {
            }
            column(CustType; Customer."Customer Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                BookingSheetMAWBAllocation.RESET;
                BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", "IATA Purchase Invoice"."MAWB No.");
                IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
                    Customer.GET(BookingSheetMAWBAllocation."Shipper Code");
                    Item.GET(BookingSheetMAWBAllocation."Item No");
                END;
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

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        PageCaptionCap: Label 'Page %1 of %2';
        LoadingSheetHeader: Record "Loading Sheet Header";
        BookingSheetMAWBAllocation: Record "Booking Sheet MAWB Allocation";
        Customer: Record Customer;
        Item: Record Item;
}

