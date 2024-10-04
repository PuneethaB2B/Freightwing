page 50078 "Archived MAWB"
{
    Caption = 'Master Airway Bill';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = ' New,Process,Reports,Export Invoicing,Third Party  Invoicing,c6,c7,c8,C9,C10';
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "MAWB Header 2";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Agent's IATA Code"; Rec."Agent's IATA Code")
                {
                }
                field("Carrier Agent Code"; Rec."Carrier Agent Code")
                {
                }
                field("Agent Code"; Rec."Agent Code")
                {
                }
                field("Source Airport"; Rec."Source Airport")
                {
                }
                field("Destination Airport"; Rec."Destination Airport")
                {
                }
                field(Consolidated; Rec.Consolidated)
                {
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Custom Entry No"; Rec."Custom Entry No")
                {
                }
                field("Phyto Certificate"; Rec."Phyto Certificate")
                {
                }
                field("Euro Form No"; Rec."Euro Form No")
                {
                }
                field("Commercial Invoice No"; Rec."Commercial Invoice No")
                {
                }
                field("Total Weight"; Rec."Total Weight")
                {
                    Editable = false;
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                }
                field("House Nos"; Rec."House Nos")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Flight Code"; Rec."Flight Code")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                    Caption = 'Description';
                }
            }
            part(ArchivedMAWBSubform; "Archived MAWB Subform")
            {
                SubPageLink = "MAWB No." = FIELD("No.");
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
                        MAWBLine.SETRANGE(MAWBLine."MAWB No.", Rec."No.");
                        IF MAWBLine.FINDSET THEN BEGIN
                            REPEAT
                                TBLTW += MAWBLine."Chargeable Weight";
                            UNTIL MAWBLine.NEXT = 0;
                        END;
                        Rec."Total Weight" := TBLTW;
                        MESSAGE('Total Weight Calculated');
                        // ************************** end ********
                        // *************************************TBL calc houses *****
                        TBLHN := 0;
                        MAWBLine.RESET;
                        MAWBLine.SETRANGE(MAWBLine."MAWB No.", Rec."No.");
                        IF MAWBLine.FINDSET THEN BEGIN
                            REPEAT
                                IF (MAWBLine."HAWB No." <> '') THEN
                                    TBLHN := TBLHN + 1;
                            UNTIL MAWBLine.NEXT = 0;
                        END;
                        Rec."House Nos" := TBLHN;
                        MESSAGE('Houses number Calculated');

                        // ************************** end ********

                        Ammend.ClearCalculatedCharges(Rec."No.");
                        Ammend.CalculateMAWBCharges(Rec."No.");
                        Ammend.CalculateHandlingFees(Rec."No.");
                        Rec.MODIFY;
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
                        Rec.CalculateHandlingFees;
                    end;
                }
                action("View Charges")
                {
                    Caption = 'View Charges';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "MAWB Invoice Charges";
                    RunPageLink = "MAWB No." = FIELD("No.");
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
                        MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", Rec."No.");
                        IF MAWBReceipt.FINDFIRST THEN BEGIN
                            REPORT.RUNMODAL(Report::"MAWB Usage", TRUE, FALSE, MAWBReceipt);
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
                        IF CONFIRM(Text0001 + '' + FORMAT(Rec."No.")) THEN BEGIN
                            Rec.Status := Rec.Status::Pending;
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
                        IF CONFIRM('Do you want to reset the MAWB to Documentation level?') THEN BEGIN
                            MAWBReceipt.RESET;
                            MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", Rec."No.");
                            IF MAWBReceipt.FINDFIRST THEN BEGIN
                                MAWBReceipt.Prepared := FALSE;
                                MAWBReceipt.MODIFY;
                                MAWBInvoiceCharge.RESET;
                                MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.", Rec."No.");
                                IF MAWBInvoiceCharge.FIND('-') THEN BEGIN
                                    MAWBInvoiceCharge.DELETEALL;
                                END;
                                Rec.Status := Rec.Status::Submitted;
                                Rec.MODIFY();
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
                            MAWBLine.SETRANGE(MAWBLine."MAWB No.", Rec."No.");
                            IF MAWBLine.FIND('-') THEN BEGIN
                                REPORT.RUNMODAL(Report::"Update MAWB Dates", FALSE, FALSE, MAWBLine);
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
                        Rec.TESTFIELD("Flight Code");
                        Rec.TESTFIELD("Source Airport");
                        Rec.TESTFIELD("Destination Airport");
                        Rec.TESTFIELD("Airline Code");
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
        MAWBS: Record "MAWB Header 2";
        Text0001: Label 'Do you want to archive the MAWB No. ';
        Ammend: Codeunit "Ammend Charges";
        String: Text[250];
        Opt: Integer;
        MAWBReceipt: Record "MAWB Receipt";
        MAWBHeader: Record "MAWB Header 2";
        MAWBLine: Record "MAWB Line";
        HAWBHeader: Record "HAWB Header";
        HAWBLine: Record "HAWB Line";
        MAWBInvoiceCharge: Record "MAWB Invoice Charge";
        UpdateLog: Codeunit "Update Log";
        BKMawb: Record "Booking Sheet MAWB Allocation";
        BKLine: Record "Booking Sheet Line";
        BKLine1: Record "Booking Sheet Line";
        LoadingSheetLine: Record "Loading Sheet Line";
        TBLTW: Decimal;
        TBLHN: Integer;
        gCduTBLFunctions: Codeunit "TBL Functions";
        gBoolModified: Boolean;
}

