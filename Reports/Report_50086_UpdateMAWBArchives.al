report 50086 "Update MAWB Archives"
{
    Caption = 'Update MAWB Archives';
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Header 2"; "MAWB Header 2")
        {
            dataitem("MAWB Line"; "MAWB Line")
            {
                DataItemLink = "MAWB No." = FIELD("No.");

                trigger OnAfterGetRecord()
                begin
                    gIntTotalHeaderWeight += "MAWB Line"."Chargeable Weight";
                    IF "MAWB Line"."HAWB No." <> '' THEN
                        gIntTotalHouseNos += 1;
                    IF "MAWB Line"."Item No." <> '' THEN BEGIN
                        IF gRecItem.GET("MAWB Line"."Item No.") THEN BEGIN
                            "MAWB Line".Description := gRecItem.Description;
                            "MAWB Line".MODIFY;
                        END;
                    END;
                    gDiaWindow.UPDATE(1, "MAWB Line"."MAWB No.");
                end;

                trigger OnPostDataItem()
                begin
                    "MAWB Header 2"."Total Weight" := gIntTotalHeaderWeight;
                    "MAWB Header 2"."House Nos" := gIntTotalHouseNos;
                    "MAWB Header 2"."Item Description" := "MAWB Line".Description;
                    IF gIntTotalHouseNos > 0 THEN
                        "MAWB Header 2"."Has Houses" := TRUE;
                    "MAWB Header 2".MODIFY;
                end;

                trigger OnPreDataItem()
                begin
                    gIntTotalHeaderWeight := 0;
                    gIntTotalHouseNos := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                gRecPurchInvLine.RESET;
                gRecPurchInvLine.SETRANGE("Payment Voucher No.", "MAWB Header 2"."No.");
                gRecPurchInvLine.SETFILTER("Charge Code", '%1|%2', '14', '82');
                IF gRecPurchInvLine.FINDFIRST THEN
                    "MAWB Header 2"."Purchase Posting Date" := gRecPurchInvLine."Posting Date";
            end;

            trigger OnPostDataItem()
            begin
                gDiaWindow.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                gDiaWindow.OPEN('############1');
            end;
        }
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {

            trigger OnAfterGetRecord()
            begin
                "Purch. Inv. Header"."Currency Factor" := gRecCurrency.ExchangeRate("Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code");
                "Purch. Inv. Header".MODIFY;
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

    trigger OnPostReport()
    begin
        MESSAGE(Text001);
    end;

    var
        Text001: Label 'MAWB Archives are Successfully updated.';
        gIntTotalHeaderWeight: Decimal;
        gIntTotalHouseNos: Integer;
        gDiaWindow: Dialog;
        gRecItem: Record Item;
        gRecPurchInvLine: Record "Purch. Inv. Line";
        gRecCurrency: Record "Currency Exchange Rate";
}

