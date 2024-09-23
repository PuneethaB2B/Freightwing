report 50086 "Update MAWB Archives"
{
    Caption = 'Update MAWB Archives';
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem1000000001; Table50077)
        {
            dataitem(DataItem1000000000; Table50076)
            {
                DataItemLink = MAWB No.=FIELD(No.);

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
        dataitem(DataItem1000000002; Table122)
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
        gRecItem: Record "27";
        gRecPurchInvLine: Record "123";
        gRecCurrency: Record "330";
}

