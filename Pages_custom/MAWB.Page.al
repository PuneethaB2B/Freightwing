page 50098 MAWB
{
    Caption = 'Master Airway Bill';
    PageType = Card;
    PromotedActionCategories = ' New,Process,Reports,Export Invoicing,Third Party  Invoicing,c6,c7,c8,C9,C10';
    SourceTable = Table50077;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                }
                field("Agent's IATA Code"; "Agent's IATA Code")
                {
                    Editable = false;
                }
                field("Carrier Agent Code"; "Carrier Agent Code")
                {
                    Editable = false;
                }
                field("Agent Code"; "Agent Code")
                {
                    Visible = false;
                }
                field("Destination Code"; "Destination Code")
                {
                    Editable = false;
                }
                field("Source Airport"; "Source Airport")
                {
                    Editable = false;
                }
                field("Destination Airport"; "Destination Airport")
                {
                    Editable = false;
                }
                field(Consolidated; Consolidated)
                {
                    Editable = false;
                }
                field("Phyto Certificate"; "Phyto Certificate")
                {
                    Caption = 'KEPHIS Phyto Cert.';
                }
                field("Euro Form No"; "Euro Form No")
                {
                }
                field("Preparation Date"; "Preparation Date")
                {
                }
                field("Custom Entry No"; "Custom Entry No")
                {
                }
                field("Commercial Invoice No"; "Commercial Invoice No")
                {
                }
                field("Booked Weight"; "Booked Weight")
                {
                }
                field("Chargeable Weight"; "Chargeable Weight")
                {
                }
                field("Total Docket Weight"; "Total Docket Weight")
                {
                    Editable = false;
                }
                field("Total Gross Weight"; "Total Gross Weight")
                {
                    Editable = false;
                }
                field("Total Volume Metric Weight"; "Total Volume Metric Weight")
                {
                    Editable = false;
                }
                field("Booked Weight"-"Chargeable Weight"; "Booked Weight"-"Chargeable Weight")
                {
                    Caption = 'Weight Difference';
                }
                field("Has Houses"; "Has Houses")
                {
                    Editable = false;
                }
                field("Total Weight"; "Total Weight")
                {
                    Editable = false;
                }
                field("House Nos"; "House Nos")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                    Editable = false;
                }
            }
            part(; 50099)
            {
                SubPageLink = MAWB No.=FIELD(No.);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                Image = Invoice;
                action(CalculateMAWBCharges)
                {
                    Caption = 'Calculate &MAWB Charges';
                    Image = CalculateInvoiceDiscount;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                action(CalculateHandlingFees)
                {
                    Caption = 'CalculateHandlingFees';
                    Image = CalculateInvoiceDiscount;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                action("View Charges")
                {
                    Caption = 'View Charges';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50120;
                    RunPageLink = MAWB No.=FIELD(No.);
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = false;
                }
                action(Process)
                {
                    Image = Production;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TESTFIELD(Status,Status::Submitted);
                        MAWBS.RESET;
                        MAWBS.SETRANGE(MAWBS."No.","No.");
                        IF MAWBS.FINDFIRST THEN
                        BEGIN
                          AmmendCharges.ClearCalculatedCharges("No.");
                          AmmendCharges.CalculateMAWBCharges("No.");
                          AmmendCharges.CalculateHandlingFees("No.");
                          IF MAWBS."Has Houses" THEN
                          BEGIN
                            MAWBLine.RESET;
                            MAWBLine.SETRANGE(MAWBLine."MAWB No.","No.");
                            IF MAWBLine.FINDSET THEN
                            BEGIN
                              REPEAT
                                MAWBLine.TESTFIELD(MAWBLine."HAWB No.");
                                MAWBLine.TESTFIELD(MAWBLine."Chargeable Weight");
                              UNTIL MAWBLine.NEXT = 0;
                            END;
                            MAWBS.ArchiveHouses(MAWBS."No.");
                          END;
                          MAWBS.Status:=MAWBS.Status::Archived;
                          MAWBS."Processed By":=USERID;
                          MAWBS."Processed At":=TIME;
                          MAWBS.MODIFY;
                          MAWBReceipt.RESET;
                          MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.","No.");
                          IF MAWBReceipt.FINDFIRST THEN BEGIN
                            MAWBReceipt.Prepared:=TRUE;
                            MAWBReceipt."Prepared Date":=TODAY;
                            MAWBReceipt.MODIFY;
                          END;
                          MESSAGE('Archived');
                          CurrPage.CLOSE;
                        END;
                    end;
                }
                action(Submit)
                {
                    Image = ValidateEmailLoggingSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // *************************************TBL calc Total Weight *****
                        TESTFIELD("Preparation Date");
                        TBLTW := 0;
                        MAWBLine.RESET;
                        MAWBLine.SETRANGE(MAWBLine."MAWB No.","No.");
                        IF MAWBLine.FINDSET THEN BEGIN
                          REPEAT
                           TBLTW := TBLTW + MAWBLine."Chargeable Weight";
                          UNTIL MAWBLine.NEXT = 0;
                        END;
                        "Total Weight" := TBLTW;
                        MESSAGE('Total Weight Calculated');
                        // ************************** end ********
                        // *************************************TBL calc houses *****
                        TBLHN := 0;
                        MAWBLine.RESET;
                        MAWBLine.SETRANGE(MAWBLine."MAWB No.","No.");
                        IF MAWBLine.FINDSET THEN BEGIN
                          REPEAT
                            IF (MAWBLine."HAWB No." <> '') THEN
                                  TBLHN := TBLHN + MAWBLine."Chargeable Weight";
                          UNTIL MAWBLine.NEXT = 0;
                        END;
                        "House Nos" := TBLHN;
                        MESSAGE('Houses number Calculated');

                        // ************************** end ********

                        MAWBLine.RESET;
                        MAWBLine.SETRANGE(MAWBLine."MAWB No.","No.");
                        IF MAWBLine.FINDSET THEN BEGIN
                          REPEAT
                           MAWBLine.TESTFIELD(MAWBLine."Chargeable Weight");
                          UNTIL MAWBLine.NEXT = 0;
                        END;
                        IF NOT "Has Houses" THEN
                        BEGIN
                        IF Status= Status::Pending THEN
                        BEGIN
                          TESTFIELD("Custom Entry No");
                          IF CONFIRM('Do you want to Submit the MAWB for Processing?') THEN
                          BEGIN
                          Status:=Status::Submitted;
                          MODIFY();
                          MESSAGE('Submitted');
                          CurrPage.CLOSE;
                          END;

                        END ELSE BEGIN
                          TESTFIELD("Phyto Certificate");
                          //TESTFIELD("Custom Entry No");
                          IF CONFIRM('Do you want to Submit the MAWB for Processing?') THEN
                          BEGIN
                          Status:=Status::Pending;
                          MODIFY();
                          MESSAGE('Submitted');
                          CurrPage.CLOSE;
                          END;

                        END;
                        END ELSE BEGIN
                          IF CONFIRM('Do you want to Submit the MAWB for Processing?') THEN
                          BEGIN
                          Status:=Status::Submitted;
                          MODIFY();
                          MESSAGE('Submitted');
                          CurrPage.CLOSE;
                          END;

                        END;
                    end;
                }
                action(Calc)
                {
                    Visible = false;

                    trigger OnAction()
                    begin
                        CalculateMAWBCharges;
                    end;
                }
                action("MAWB Status")
                {
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        PAGE.RUNMODAL(50127);
                    end;
                }
                action("Reset MAWB to Loadingsheet")
                {
                    Caption = 'Reset MAWB to Loadingsheet';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to delete all related Information and Reopen Loadiing Sheet?') THEN
                        BEGIN
                          LoadingSheet.RESET;
                          LoadingSheet.SETRANGE(LoadingSheet."MAWB No.","No.");
                          IF LoadingSheet.FINDFIRST THEN
                          BEGIN
                          MESSAGE('Reseting Loading sheet No. %1',LoadingSheet."No.");
                            LoadingSheetLine.RESET;
                            LoadingSheetLine.SETRANGE(LoadingSheetLine."Loading Sheet No.",LoadingSheet."No.");
                            IF LoadingSheetLine.FINDSET THEN
                            BEGIN
                              ImportExportSetup.GET();
                              JournalTemplate:=ImportExportSetup."Item Journal Template";
                              JournalBatch:=ImportExportSetup."Item Journal Batch";
                              ItemJnline.RESET;
                              ItemJnline.SETRANGE(ItemJnline."Journal Template Name",JournalTemplate);
                              ItemJnline.SETRANGE(ItemJnline."Journal Batch Name",JournalBatch);
                              ItemJnline.DELETEALL;
                              REPEAT
                                LoadingSheetLine.CALCFIELDS(LoadingSheetLine.Quantity);
                                IF LoadingSheetLine.Quantity<>0 THEN
                                BEGIN
                                  //MESSAGE('Here');
                                  ItemJnline."Journal Template Name":=ImportExportSetup."Item Journal Template";
                                  ItemJnline."Journal Batch Name":=ImportExportSetup."Item Journal Batch";
                                  ItemJnline."Line No.":=ItemJnline."Line No."+1000;
                                  ItemJnline."Entry Type":=ItemJnline."Entry Type"::"Positive Adjmt.";
                                  ItemJnline."Source Code":= 'ITEMJNL';
                                  ItemJnline."Document No.":=LoadingSheetLine."Loading Sheet No.";
                                  ItemJnline."Item No.":=LoadingSheetLine."Item No.";
                                  ItemJnline.VALIDATE("Item No.");
                                  ItemJnline."Posting Date":= LoadingSheet."Loading Date";
                                  ItemJnline.Description:='Reversal of AWB by Documentation user '+USERID;
                                  ItemJnline."Unit of Measure Code":=LoadingSheetLine."Unit of Measure Code";
                                  ItemJnline.Quantity:=LoadingSheetLine.Quantity;
                                  ItemJnline.VALIDATE(Quantity);
                                  ItemJnline.VALIDATE("Unit Amount");
                                  ItemJnline."Shipper Code":="Shipper Code";
                                  ItemJnline.Weight:=LoadingSheetLine."FWL Gross Weight";
                                  ItemJnline."Location Code":=LoadingSheetLine."Location Code";
                                  ItemJnline.INSERT;
                                END;
                              UNTIL LoadingSheetLine.NEXT = 0;
                            END; //Loading Sheet Line
                            ItemJnline.RESET;
                            ItemJnline.SETRANGE(ItemJnline."Journal Template Name",JournalTemplate);
                            ItemJnline.SETRANGE(ItemJnline."Journal Batch Name",JournalBatch);
                            IF  ItemJnline.FIND('-') THEN
                            BEGIN
                              CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItemJnline);
                            END;
                            LoadingSheet.Shipped:=FALSE;
                            LoadingSheet.Status:=LoadingSheet.Status::Submitted;
                            LoadingSheet.MODIFY;
                            MAWBLine.RESET;
                            MAWBLine.SETRANGE(MAWBLine."MAWB No.","No.");
                            IF MAWBLine.FIND('-') THEN
                            BEGIN
                              MAWBLine.DELETEALL;
                            END;
                            HAWBLine.RESET;
                            HAWBLine.SETRANGE(HAWBLine."MAWB No.","No.");
                            IF HAWBLine.FIND('-') THEN
                            BEGIN
                              HAWBLine.DELETEALL;
                            END;
                            MAWBS.RESET;
                            MAWBS.SETRANGE(MAWBS."No.","No.");
                            IF MAWBS.FIND('-') THEN BEGIN
                            MAWBS.DELETEALL;
                            END;
                            MAWBInv.RESET;
                            MAWBInv.SETRANGE(MAWBInv."MAWB No.","No.");
                            IF MAWBInv.FIND('-') THEN BEGIN
                              MAWBInv.DELETEALL;
                            END;
                            CurrPage.CLOSE;
                          END;
                        END;
                    end;
                }
                action("Validate Dates")
                {

                    trigger OnAction()
                    begin
                        MAWBLine.RESET;
                        MAWBLine.SETRANGE(MAWBLine."MAWB No.","No.");
                        IF MAWBLine.FINDSET THEN BEGIN
                          REPORT.RUN(50063,FALSE,FALSE,MAWBLine);
                        END;
                    end;
                }
            }
        }
    }

    var
        MAWBS: Record "50077";
        Text0001: Label 'Do you want to archive the MAWB No. ';
        MAWBLine: Record "50076";
        MAWBCheck: Codeunit "50031";
        MAWBStr: Code[50];
        Input: Dialog;
        LoadingSheet: Record "50060";
        LoadingSheetLine: Record "50061";
        ImportExportSetup: Record "50010";
        JournalTemplate: Code[50];
        JournalBatch: Code[50];
        ItemJnline: Record "83";
        ItemLedgerEntry: Record "32";
        HAWBLine: Record "50074";
        AmmendCharges: Codeunit "50031";
        MAWBInv: Record "50073";
        MAWBReceipt: Record "50039";
        TBLTW: Decimal;
        TBLHN: Decimal;
}

