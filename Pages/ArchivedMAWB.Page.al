page 50078 "Archived MAWB"
{
    Caption = 'Master Airway Bill';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = ' New,Process,Reports,Export Invoicing,Third Party  Invoicing,c6,c7,c8,C9,C10';
    RefreshOnActivate = true;
    ShowFilter = false;
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
                }
                field("Carrier Agent Code"; "Carrier Agent Code")
                {
                }
                field("Agent Code"; "Agent Code")
                {
                }
                field("Source Airport"; "Source Airport")
                {
                }
                field("Destination Airport"; "Destination Airport")
                {
                }
                field(Consolidated; Consolidated)
                {
                }
                field("Consignee Name"; "Consignee Name")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Custom Entry No"; "Custom Entry No")
                {
                }
                field("Phyto Certificate"; "Phyto Certificate")
                {
                }
                field("Euro Form No"; "Euro Form No")
                {
                }
                field("Commercial Invoice No"; "Commercial Invoice No")
                {
                }
                field("Total Weight"; "Total Weight")
                {
                    Editable = false;
                }
                field("Total Quantity"; "Total Quantity")
                {
                }
                field("House Nos"; "House Nos")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Airline Code"; "Airline Code")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Item Description"; "Item Description")
                {
                    Caption = 'Description';
                }
            }
            part(; 50126)
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
                    Visible = true;

                    trigger OnAction()
                    begin
                        // *************************************TBL calc Total Weight *****
                        TBLTW := 0;
                        MAWBLine.RESET;
                        MAWBLine.SETRANGE(MAWBLine."MAWB No.", "No.");
                        IF MAWBLine.FINDSET THEN BEGIN
                            REPEAT
                                TBLTW += MAWBLine."Chargeable Weight";
                            UNTIL MAWBLine.NEXT = 0;
                        END;
                        "Total Weight" := TBLTW;
                        MESSAGE('Total Weight Calculated');
                        // ************************** end ********
                        // *************************************TBL calc houses *****
                        TBLHN := 0;
                        MAWBLine.RESET;
                        MAWBLine.SETRANGE(MAWBLine."MAWB No.", "No.");
                        IF MAWBLine.FINDSET THEN BEGIN
                            REPEAT
                                IF (MAWBLine."HAWB No." <> '') THEN
                                    TBLHN := TBLHN + 1;
                            UNTIL MAWBLine.NEXT = 0;
                        END;
                        "House Nos" := TBLHN;
                        MESSAGE('Houses number Calculated');

                        // ************************** end ********

                        Ammend.ClearCalculatedCharges("No.");
                        Ammend.CalculateMAWBCharges("No.");
                        Ammend.CalculateHandlingFees("No.");
                        MODIFY;
                    end;
                }
                action(CalculateHandlingFees)
                {
                    Caption = 'CalculateHandlingFees';
                    Image = CalculateInvoiceDiscount;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //CalculateMAWBCharges;
                        CalculateHandlingFees;
                    end;
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
                action("MAWB Usage")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        MAWBReceipt.RESET;
                        MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.","No.");
                        IF MAWBReceipt.FINDFIRST THEN
                        BEGIN
                        REPORT.RUNMODAL(50036,TRUE,FALSE,MAWBReceipt);
                        END;
                    end;
                }
                action(Archive)
                {
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF CONFIRM(Text0001+''+FORMAT("No.")) THEN
                        BEGIN
                        Status:=Status::Pending;
                        END;
                    end;
                }
                action(Reset)
                {
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to reset the MAWB to Documentation level?') THEN
                        BEGIN
                          MAWBReceipt.RESET;
                          MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.","No.");
                          IF MAWBReceipt.FINDFIRST THEN BEGIN
                            MAWBReceipt.Prepared:=FALSE;
                            MAWBReceipt.MODIFY;
                            MAWBInvoiceCharge.RESET;
                            MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.","No.");
                            IF MAWBInvoiceCharge.FIND('-') THEN BEGIN
                              MAWBInvoiceCharge.DELETEALL;
                            END;
                            Status:=Status::Submitted;
                            MODIFY();
                            CurrPage.CLOSE();
                            MESSAGE('MAWB Reset Status is Submitted');
                          END;
                        END;
                    end;
                }
                action("Validate Dates")
                {
                    Image = ValidateEmailLoggingSetup;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to Validate All Blank MAWB Dates?') THEN BEGIN
                          MAWBLine.RESET;
                          MAWBLine.SETRANGE(MAWBLine."MAWB No.","No.");
                          IF MAWBLine.FIND('-') THEN BEGIN
                          REPORT.RUNMODAL(50063,FALSE,FALSE,MAWBLine);
                          END;
                        END;
                    end;
                }
                action("Update Booking Sheet")
                {
                    Caption = 'Update Booking Sheet';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TESTFIELD("Flight Code");
                        TESTFIELD("Source Airport");
                        TESTFIELD("Destination Airport");
                        TESTFIELD("Airline Code");
                        IF gBoolModified THEN
                          gCduTBLFunctions.UpdateBookingDetails(Rec);
                        MESSAGE('Booking sheets are updated');
                    end;
                }
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        gBoolModified := TRUE;
    end;

    trigger OnOpenPage()
    begin
        gBoolModified := FALSE;
    end;

    var
        MAWBS: Record "50077";
        Text0001: Label 'Do you want to archive the MAWB No. ';
        Ammend: Codeunit "50031";
        String: Text[250];
        Opt: Integer;
        MAWBReceipt: Record "50039";
        MAWBHeader: Record "50077";
        MAWBLine: Record "50076";
        HAWBHeader: Record "50075";
        HAWBLine: Record "50074";
        MAWBInvoiceCharge: Record "50073";
        UpdateLog: Codeunit "50032";
        BKMawb: Record "50070";
        BKLine: Record "50054";
        BKLine1: Record "50054";
        LoadingSheetLine: Record "50061";
        TBLTW: Decimal;
        TBLHN: Integer;
        gCduTBLFunctions: Codeunit "50018";
        gBoolModified: Boolean;
}

