report 50010 "Update Data"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Integer; Integer)
        {

            trigger OnAfterGetRecord()
            begin

                IF gRecEmailBody1.FINDSET THEN
                    REPEAT
                        gRecEmailBody2.INIT;
                        gRecEmailBody2.TRANSFERFIELDS(gRecEmailBody1);
                        gRecEmailBody2.INSERT;
                    UNTIL gRecEmailBody1.NEXT = 0;

                IF gRecParameters1.FINDSET THEN
                    REPEAT
                        gRecParameters2.INIT;
                        gRecParameters2.TRANSFERFIELDS(gRecParameters1);
                        gRecParameters2.INSERT;
                    UNTIL gRecParameters1.NEXT = 0;

                IF gRecMAWBLineChrg1.FINDSET THEN
                    REPEAT
                        gRecMAWBLineChrg2.INIT;
                        gRecMAWBLineChrg2.TRANSFERFIELDS(gRecMAWBLineChrg1);
                        gRecMAWBLineChrg2.INSERT;
                    UNTIL gRecMAWBLineChrg1.NEXT = 0;

                IF gRecMAWBBaseChrg1.FINDSET THEN
                    REPEAT
                        gRecMAWBBaseChrg2.INIT;
                        gRecMAWBBaseChrg2.TRANSFERFIELDS(gRecMAWBBaseChrg1);
                        gRecMAWBBaseChrg2.INSERT;
                    UNTIL gRecMAWBBaseChrg1.NEXT = 0;

                IF gRecUnrecoveredChrg1.FINDSET THEN
                    REPEAT
                        gRecUnrecoveredChrg2.INIT;
                        gRecUnrecoveredChrg2.TRANSFERFIELDS(gRecUnrecoveredChrg1);
                        gRecUnrecoveredChrg2.INSERT;
                    UNTIL gRecUnrecoveredChrg1.NEXT = 0;

                IF gRecImportCharge1.FINDSET THEN
                    REPEAT
                        gRecImportCharge2.INIT;
                        gRecImportCharge2.TRANSFERFIELDS(gRecImportCharge1);
                        gRecImportCharge2.INSERT;
                    UNTIL gRecImportCharge1.NEXT = 0;

                IF gRecShipmentUpdateLine1.FINDSET THEN
                    REPEAT
                        gRecShipmentUpdateLine2.INIT;
                        gRecShipmentUpdateLine2.TRANSFERFIELDS(gRecShipmentUpdateLine1);
                        gRecShipmentUpdateLine2.INSERT;
                    UNTIL gRecShipmentUpdateLine1.NEXT = 0;

                IF gRecImportActivities1.FINDSET THEN
                    REPEAT
                        gRecImportActivities2.INIT;
                        gRecImportActivities2.TRANSFERFIELDS(gRecImportActivities1);
                        gRecImportActivities2.INSERT;
                    UNTIL gRecImportActivities1.NEXT = 0;

                IF gRecIATAPurchaseInv1.FINDSET THEN
                    REPEAT
                        gRecIATAPurchaseInv2.INIT;
                        gRecIATAPurchaseInv2.TRANSFERFIELDS(gRecIATAPurchaseInv1);
                        gRecIATAPurchaseInv2.INSERT;
                    UNTIL gRecIATAPurchaseInv1.NEXT = 0;

                IF gRecBeneficiaryDetails1.FINDSET THEN
                    REPEAT
                        gRecBeneficiaryDetails2.INIT;
                        gRecBeneficiaryDetails2.TRANSFERFIELDS(gRecBeneficiaryDetails1);
                        gRecBeneficiaryDetails2.INSERT;
                    UNTIL gRecBeneficiaryDetails1.NEXT = 0;

                IF gRecPreAlertLine1.FINDSET THEN
                    REPEAT
                        gRecPreAlertLine2.INIT;
                        gRecPreAlertLine2.TRANSFERFIELDS(gRecPreAlertLine1);
                        gRecPreAlertLine2.INSERT;
                    UNTIL gRecPreAlertLine1.NEXT = 0;

                IF gRecPreAlertHeader1.FINDSET THEN
                    REPEAT
                        gRecPreAlertHeader2.INIT;
                        gRecPreAlertHeader2.TRANSFERFIELDS(gRecPreAlertHeader1);
                        gRecPreAlertHeader2.INSERT;
                    UNTIL gRecPreAlertHeader1.NEXT = 0;

                IF gRecHandlingSlabMatrix1.FINDSET THEN
                    REPEAT
                        gRecHandlingSlabMatrix2.INIT;
                        gRecHandlingSlabMatrix2.TRANSFERFIELDS(gRecHandlingSlabMatrix1);
                        gRecHandlingSlabMatrix2.INSERT;
                    UNTIL gRecHandlingSlabMatrix1.NEXT = 0;

                IF gRecGoodReceiptULDAllocation1.FINDSET THEN
                    REPEAT
                        gRecGoodReceiptULDAllocation2.INIT;
                        gRecGoodReceiptULDAllocation2.TRANSFERFIELDS(gRecGoodReceiptULDAllocation1);
                        gRecGoodReceiptULDAllocation2.INSERT;
                    UNTIL gRecGoodReceiptULDAllocation1.NEXT = 0;

                IF gRecGoodReceiptNotifyParty1.FINDSET THEN
                    REPEAT
                        gRecGoodReceiptNotifyParty2.INIT;
                        gRecGoodReceiptNotifyParty2.TRANSFERFIELDS(gRecGoodReceiptNotifyParty1);
                        gRecGoodReceiptNotifyParty2.INSERT;
                    UNTIL gRecGoodReceiptNotifyParty1.NEXT = 0;

                IF gRecGoodReceiptLine1.FINDSET THEN
                    REPEAT
                        gRecGoodReceiptLine2.INIT;
                        gRecGoodReceiptLine2.TRANSFERFIELDS(gRecGoodReceiptLine1);
                        gRecGoodReceiptLine2.INSERT;
                    UNTIL gRecGoodReceiptLine1.NEXT = 0;

                IF gRecGoodReceiptHeader1.FINDSET THEN
                    REPEAT
                        gRecGoodReceiptHeader2.INIT;
                        gRecGoodReceiptHeader2.TRANSFERFIELDS(gRecGoodReceiptHeader1);
                        gRecGoodReceiptHeader2.INSERT;
                    UNTIL gRecGoodReceiptHeader1.NEXT = 0;



                IF gRecDumpCustEnt1.FINDSET THEN
                    REPEAT
                        gRecDumpCustEnt2.INIT;
                        gRecDumpCustEnt2.TRANSFERFIELDS(gRecDumpCustEnt1);
                        gRecDumpCustEnt2.INSERT;
                    UNTIL gRecDumpCustEnt1.NEXT = 0;

                IF gRecShipperConsignee1.FINDSET THEN
                    REPEAT
                        gRecShipperConsignee2.INIT;
                        gRecShipperConsignee2.TRANSFERFIELDS(gRecShipperConsignee1);
                        gRecShipperConsignee2.INSERT;
                    UNTIL gRecShipperConsignee1.NEXT = 0;

                IF gRecShipperNotifyParty1.FINDSET THEN
                    REPEAT
                        gRecShipperNotifyParty2.INIT;
                        gRecShipperNotifyParty2.TRANSFERFIELDS(gRecShipperNotifyParty1);
                        gRecShipperNotifyParty2.INSERT;
                    UNTIL gRecShipperNotifyParty1.NEXT = 0;

                IF gRecMAWBInvoiceNotifyParty1.FINDSET THEN
                    REPEAT
                        gRecMAWBInvoiceNotifyParty2.INIT;
                        gRecMAWBInvoiceNotifyParty2.TRANSFERFIELDS(gRecMAWBInvoiceNotifyParty1);
                        gRecMAWBInvoiceNotifyParty2.INSERT;
                    UNTIL gRecMAWBInvoiceNotifyParty1.NEXT = 0;

                IF gRecMAWBInvoiceCharge1.FINDSET THEN
                    REPEAT
                        gRecMAWBInvoiceCharge2.INIT;
                        gRecMAWBInvoiceCharge2.TRANSFERFIELDS(gRecMAWBInvoiceCharge1);
                        gRecMAWBInvoiceCharge2.INSERT;
                    UNTIL gRecMAWBInvoiceCharge1.NEXT = 0;

                IF gRecHAWBLine1.FINDSET THEN
                    REPEAT
                        gRecHAWBLine2.INIT;
                        gRecHAWBLine2.TRANSFERFIELDS(gRecHAWBLine1);
                        gRecHAWBLine2.INSERT;
                    UNTIL gRecHAWBLine1.NEXT = 0;

                IF gRecHAWBHeader1.FINDSET THEN
                    REPEAT
                        gRecHAWBHeader2.INIT;
                        gRecHAWBHeader2.TRANSFERFIELDS(gRecHAWBHeader1);
                        gRecHAWBHeader2.INSERT;
                    UNTIL gRecHAWBHeader1.NEXT = 0;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Updated');
            end;

            trigger OnPreDataItem()
            begin

                Integer.SETRANGE(Number, 1);
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
        gRecEmailBody1: Record 50157;
        gRecEmailBody2: Record 50000;
        gRecParameters1: Record 50156;
        gRecParameters2: Record 50001;
        gRecMAWBLineChrg1: Record 50152;
        gRecMAWBLineChrg2: Record 50004;
        gRecMAWBBaseChrg1: Record 50151;
        gRecMAWBBaseChrg2: Record 50005;
        gRecUnrecoveredChrg1: Record 50150;
        gRecUnrecoveredChrg2: Record 50006;
        gRecImportCharge1: Record 50149;
        gRecImportCharge2: Record 50007;
        gRecShipmentUpdateLine1: Record 50148;
        gRecShipmentUpdateLine2: Record 50008;
        gRecImportActivities1: Record 50147;
        gRecImportActivities2: Record 50009;
        gRecIATAPurchaseInv1: Record 50140;
        gRecIATAPurchaseInv2: Record 50016;
        gRecBeneficiaryDetails1: Record 50103;
        gRecBeneficiaryDetails2: Record 50003;
        gRecPreAlertLine1: Record 50101;
        gRecPreAlertLine2: Record 50023;
        gRecPreAlertHeader1: Record 50100;
        gRecPreAlertHeader2: Record 50030;
        gRecHandlingSlabMatrix1: Record 50099;
        gRecHandlingSlabMatrix2: Record 50045;
        gRecGoodReceiptULDAllocation1: Record 50098;
        gRecGoodReceiptULDAllocation2: Record 50046;
        gRecGoodReceiptNotifyParty1: Record 50097;
        gRecGoodReceiptNotifyParty2: Record 50049;
        gRecGoodReceiptLine1: Record 50096;
        gRecGoodReceiptLine2: Record 50051;
        gRecGoodReceiptHeader1: Record 50095;
        gRecGoodReceiptHeader2: Record 50052;
        gRecDumpCustEnt1: Record 50092;
        gRecDumpCustEnt2: Record 50062;
        gRecShipperConsignee1: Record 50091;
        gRecShipperConsignee2: Record 50066;
        gRecShipperNotifyParty1: Record 50090;
        gRecShipperNotifyParty2: Record 50067;
        gRecMAWBInvoiceNotifyParty1: Record 50087;
        gRecMAWBInvoiceNotifyParty2: Record 50072;
        gRecMAWBInvoiceCharge1: Record 50086;
        gRecMAWBInvoiceCharge2: Record 50073;
        gRecHAWBLine1: Record 50083;
        gRecHAWBLine2: Record 50074;
        gRecHAWBHeader1: Record 50082;
        gRecHAWBHeader2: Record 50075;
}

