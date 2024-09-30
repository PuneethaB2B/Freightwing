report 50089 "Sales Purch Comp"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesPurchComp.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Receipt"; "MAWB Receipt")
        {
            DataItemTableView = WHERE("MAWB No." = FILTER(<> ''));
            RequestFilterFields = "Airline Code", "MAWB No.";
            column(AirlineCode_MAWBReceipt; Airlines.Name)
            {
            }
            column(MAWBNo_MAWBReceipt; "MAWB Receipt"."MAWB No.")
            {
            }
            column(ChargeableWeeight; Weight)
            {
            }
            column(ShowSummary; Summary)
            {
            }
            column(ShowLoss; Losses)
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "MAWB No." = FIELD("MAWB No.");
                RequestFilterFields = "Bill-to Customer No.", "Posting Date";
                column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
                {
                }
                column(SelltoCustomerNo_SalesInvoiceHeader; Customers.Name)
                {
                }
                column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
                {
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending);
                    column(AmountIncludingVAT_SalesInvoiceLine; SalesLCY)
                    {
                    }
                    column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        SalesLCY := 0;
                        IF "Sales Invoice Header"."Currency Factor" <> 0 THEN
                            SalesLCY := "Sales Invoice Line"."Amount Including VAT" / "Sales Invoice Header"."Currency Factor"
                        ELSE
                            SalesLCY := "Sales Invoice Line"."Amount Including VAT";
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Ok := Customers.GET("Sales Invoice Header"."Bill-to Customer No.");
                    DateFilters := "Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date");
                end;
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Payment Voucher No." = FIELD("MAWB No.");
                RequestFilterFields = "Posting Date";
                RequestFilterHeading = 'Purchase Filters';
                column(BuyfromVendorNo_PurchInvLine; Vendors.Name)
                {
                }
                column(DocumentNo_PurchInvLine; "Purch. Inv. Line"."Document No.")
                {
                }
                column(Description_PurchInvLine; "Purch. Inv. Line".Description)
                {
                }
                column(AmountIncludingVAT_PurchInvLine; PurchLCY)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PurchLCY := 0;
                    Ok := PurchInvHeader.GET("Purch. Inv. Line"."Document No.");
                    IF PurchInvHeader."Currency Factor" <> 0 THEN
                        PurchLCY := "Purch. Inv. Line"."Amount Including VAT" / PurchInvHeader."Currency Factor"
                    ELSE
                        PurchLCY := "Purch. Inv. Line"."Amount Including VAT";
                    Ok := Vendors.GET("Purch. Inv. Line"."Buy-from Vendor No.");
                end;

                trigger OnPreDataItem()
                begin
                    IF "Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date") <> '' THEN
                        "Purch. Inv. Line".COPYFILTER("Purch. Inv. Line"."Posting Date", "Sales Invoice Header"."Posting Date");
                    //MESSAGE(DateFilters);
                    //MESSAGE("Purch. Inv. Line".GETFILTER("Purch. Inv. Line"."Posting Date"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Weight := 0;
                MAWBInvoiceCharge.RESET;
                MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.", "MAWB Receipt"."MAWB No.");
                IF MAWBInvoiceCharge.FINDSET THEN BEGIN
                    REPEAT
                        Weight += MAWBInvoiceCharge."Chargeable Weight";
                    UNTIL MAWBInvoiceCharge.NEXT = 0;
                END;
                Ok := Airlines.GET("MAWB Receipt"."Airline Code");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Display)
                {
                    field("Show Summarized"; Summary)
                    {

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            IF NOT Summary THEN
                                Losses := FALSE;
                        end;
                    }
                    field("Show Losses Only"; Losses)
                    {

                        trigger OnValidate()
                        begin
                            IF Losses THEN
                                Summary := TRUE;
                        end;
                    }
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
        SalesLCY: Decimal;
        PurchLCY: Decimal;
        PurchInvHeader: Record 122;
        Ok: Boolean;
        Weight: Decimal;
        MAWBInvoiceCharge: Record 50073;
        Summary: Boolean;
        Losses: Boolean;
        Airlines: Record 50021;
        Customers: Record 18;
        Vendors: Record 23;
        DateFilters: Text;
}

