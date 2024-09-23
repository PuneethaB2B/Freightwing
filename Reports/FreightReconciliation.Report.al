report 50082 "Freight Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FreightReconciliation.rdlc';

    dataset
    {
        dataitem(DataItem1000000009; Table50077)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.";
            dataitem(DataItem1000000000; Table123)
            {
                DataItemLink = Payment Voucher No.=FIELD(No.);
                column(AirLineCode; "Purch. Inv. Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ItemDescription; gRecMAWBLine.Description)
                {
                }
                column(Destination; gRecDestination)
                {
                }
                column(VendorInvoiceNo; gRecPurchInvHr."Vendor Invoice No.")
                {
                }
                column(IsCreditMemo; gBoolIsCreditMemo)
                {
                }
                column(PostingDate; "Purch. Inv. Line"."Posting Date")
                {
                }
                column(MAWBNo; "Purch. Inv. Line"."Payment Voucher No.")
                {
                }
                column(WeightAsPerFWL; "MAWB Header 2"."Total Weight")
                {
                }
                column(MasterRate; gDecMasterRate)
                {
                }
                column(AmountPerFWL; gDecFWLAmount)
                {
                }
                column(WeightasPerAirline; "Purch. Inv. Line".Quantity)
                {
                }
                column(AirlineRate; gDecAirLineRate)
                {
                }
                column(AirlineAmount; "Purch. Inv. Line"."Amount Including VAT")
                {
                }
                column(CreditMemoAmount; gRecPurchCrLine."Amount Including VAT")
                {
                }
                column(DiffWeight; gDecDifferenceWeight)
                {
                }
                column(DiffAmount; gDecDiffAmount)
                {
                }
                column(BillToName; gTextBilltoName)
                {
                }
                column(AgreedRate; gRecSalesInvHr."Agreed Rate")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //Fetch Item Name
                    gRecMAWBLine.RESET;
                    gRecMAWBLine.SETRANGE("MAWB No.", "Purch. Inv. Line"."Payment Voucher No.");
                    gRecMAWBLine.SETFILTER("Item No.", '<>%1', '');
                    IF gRecMAWBLine.FINDFIRST THEN;

                    //Fetch Destinations
                    IF gRecAirport.GET("MAWB Header 2"."Destination Code", "MAWB Header 2"."Destination Airport") THEN
                        gRecDestination := COPYSTR(gRecAirport.Name, 1, 50);

                    //Fetch Invoice No.
                    IF gRecPurchInvHr.GET("Purch. Inv. Line"."Document No.") THEN;

                    //IsCreditMemo Existed or Not
                    gRecPurchCrLine.RESET;
                    gRecPurchCrLine.SETRANGE("Payment Voucher No.", "Purch. Inv. Line"."Payment Voucher No.");
                    IF gRecPurchCrLine.FINDFIRST THEN
                        gBoolIsCreditMemo := TRUE
                    ELSE
                        gBoolIsCreditMemo := FALSE;


                    //Calculate Master Rate
                    gRecFreightItemChargeMatrix.RESET;
                    gRecFreightItemChargeMatrix.SETFILTER("Freight Charge Code", '%1|%2', '14', '82');
                    gRecFreightItemChargeMatrix.SETRANGE("Item No.", gRecMAWBLine."Item No.");
                    gRecFreightItemChargeMatrix.SETRANGE("Airline Code", "MAWB Header 2"."Airline Code");
                    gRecFreightItemChargeMatrix.SETRANGE("Flight Code", "MAWB Header 2"."Flight Code");
                    gRecFreightItemChargeMatrix.SETRANGE("Destination Airport", "MAWB Header 2"."Destination Airport");
                    gRecFreightItemChargeMatrix.SETFILTER("From Weight", '<=%1', gRecMAWBLine."Chargeable Weight");
                    gRecFreightItemChargeMatrix.SETFILTER("To Weight", '>=%1', gRecMAWBLine."Chargeable Weight");
                    gRecFreightItemChargeMatrix.SETFILTER("Effective Start Date", '<=%2', gRecMAWBLine."Flight Date");
                    gRecFreightItemChargeMatrix.SETFILTER("Effective End Date", '>=%2', gRecMAWBLine."Flight Date");
                    IF gRecFreightItemChargeMatrix.FINDFIRST THEN
                        gDecMasterRate := gRecFreightItemChargeMatrix."Rate Amount";


                    //Calculate Amount per FWL and Bill to Name
                    gRecSalesInvHr.RESET;
                    gRecSalesInvHr.SETRANGE("MAWB No.", "Purch. Inv. Line"."Payment Voucher No.");
                    IF gRecSalesInvHr.FINDFIRST THEN BEGIN
                        //gDecFWLAmount := gRecSalesInvHr."Agreed Rate" * gRecSalesInvHr."Total Weight";
                        //FWL Amount is changed it should calculate from Master Rate and Total Weight
                        IF gRecSalesInvHr."Agreed Rate" = 0 THEN
                            gDecFWLAmount := gDecMasterRate * "MAWB Header 2"."Total Weight"
                        ELSE
                            gDecFWLAmount := gRecSalesInvHr."Agreed Rate";
                        gTextBilltoName := gRecSalesInvHr."Bill-to Name";
                    END;

                    //Calculate Airline Rate
                    //Quantity is considered as a Line Weight
                    IF "Purch. Inv. Line".Quantity <> 0 THEN
                        gDecAirLineRate := "Purch. Inv. Line"."Amount Including VAT" / "Purch. Inv. Line".Quantity;

                    //Calculate Difference Weight
                    gDecDifferenceWeight := "MAWB Header 2"."Total Weight" - "Purch. Inv. Line".Quantity;

                    //Calculate Difference Amount
                    gDecDiffAmount := ("MAWB Header 2"."Total Weight" * gRecSalesInvHr."Agreed Rate") - "Purch. Inv. Line"."Amount Including VAT";
                end;

                trigger OnPreDataItem()
                begin
                    "Purch. Inv. Line".SETCURRENTKEY("Purch. Inv. Line"."Shortcut Dimension 1 Code");
                    "Purch. Inv. Line".SETFILTER("Payment Voucher No.", '<>%1', '');
                    "Purch. Inv. Line".SETFILTER("Charge Code", '%1|%2', '14', '82');

                    gRecDestination := '';
                    gBoolIsCreditMemo := FALSE;
                    gDecMasterRate := 0;
                    gDecFWLAmount := 0;
                    gDecAirLineRate := 0;
                    gDecDifferenceWeight := 0;
                    gDecDiffAmount := 0;
                    CLEAR(gRecVendor);
                    CLEAR(gRecCountry);
                    CLEAR(gRecPurchInvHr);
                    CLEAR(gRecPurchCrLine);
                    CLEAR(gRecFreightItemChargeMatrix);
                end;
            }
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
        gRecMAWBLine: Record "50076";
        gRecCountry: Record "9";
        gRecDestination: Text[50];
        gRecPurchInvHr: Record "122";
        gRecPurchCrLine: Record "125";
        gBoolIsCreditMemo: Boolean;
        gRecFreightItemChargeMatrix: Record "50029";
        gDecMasterRate: Decimal;
        gDecFWLAmount: Decimal;
        gDecDifferenceWeight: Decimal;
        gDecDiffAmount: Decimal;
        gRecVendor: Record "23";
        gCodeTempMawbNo: Code[30];
        gRecSalesInvHr: Record "112";
        gDecAirLineRate: Decimal;
        gRecCustomer: Record "18";
        gTextBilltoName: Text[50];
        gRecAirport: Record "50019";
}

