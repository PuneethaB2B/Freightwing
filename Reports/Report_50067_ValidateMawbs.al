report 50067 "Validate Mawbs"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Loading Sheet Header"; "Loading Sheet Header")
        {

            trigger OnAfterGetRecord()
            begin
                /*MAWBHeader.RESET;
MAWBHeader.SETRANGE(MAWBHeader."No.","Loading Sheet Header"."MAWB No.");
IF NOT MAWBHeader.FINDFIRST THEN BEGIN
  Window.UPDATE(1,"Loading Sheet Header"."MAWB No.");
  MAWBRec.RESET;
  MAWBRec.SETRANGE(MAWBRec."MAWB No.","Loading Sheet Header"."MAWB No.");
  MAWBRec.SETRANGE(MAWBRec.Prepared,TRUE);
  IF MAWBRec.FINDFIRST THEN BEGIN
    MAWBRec.Prepared:=FALSE;
    MAWBRec.MODIFY;
  END;
  MAWBLine.RESET;
  MAWBLine.SETRANGE(MAWBLine."MAWB No.","Loading Sheet Header"."MAWB No.");
  MAWBHeader.INIT;
  IF NOT MAWBLine.FIND('-') THEN BEGIN
  MAWBHeader.VALIDATE(MAWBHeader."No.","Loading Sheet Header"."MAWB No.");
  END ELSE BEGIN
  MAWBHeader."No.":="Loading Sheet Header"."MAWB No.";
  END;
  MAWBHeader.VALIDATE(MAWBHeader."Shipper Code","Loading Sheet Header"."Shipper Code");
  MAWBHeader.Status:=MAWBHeader.Status::Submitted;
  MAWBHeader."Prepared By":=USERID;
  MAWBHeader."Processed By":=USERID;
  MAWBHeader."Preparation Date":="Loading Sheet Header"."Loading Date";
  MAWBHeader."Processed At":=TIME;
  MAWBHeader."Gate Pass Prepared":=TRUE;
  MAWBHeader.INSERT;
  MAWBRec.RESET;
  MAWBRec.SETRANGE(MAWBRec."MAWB No.","Loading Sheet Header"."MAWB No.");
  MAWBRec.SETRANGE(MAWBRec.Prepared,TRUE);
  IF MAWBRec.FINDFIRST THEN BEGIN
    MAWBRec.Prepared:=TRUE;
    MAWBRec.MODIFY;
  END;
END;*/
                MAWBLine.RESET;
                MAWBLine.SETRANGE(MAWBLine."MAWB No.", "Loading Sheet Header"."MAWB No.");
                IF MAWBLine.FINDSET THEN BEGIN
                    REPEAT UNTIL MAWBLine.NEXT = 0;
                END;
                SLEEP(100);

            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE('Updated');
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Loading Sheet Header".Status, "Loading Sheet Header".Status::Closed);
                Window.OPEN('Updating MAWBs \MAWB No. #1###');
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
        GatePassHeader: Record "Gate Pass Header";
        GatePassLine: Record "Gate Pass Line";
        MAWBHeader: Record "MAWB Header 2";
        LoadingSheetULDAllocation: Record "Loading Sheet ULD Allocation";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Window: Dialog;
        SalesHeader: Record "Sales Header";
        MAWBLine: Record "MAWB Line";
        HAWBHeader: Record "HAWB Header";
        HAWBLine: Record "HAWB Line";
        MAWBHeader1: Record "MAWB Header 2";
        MAWBHeader2: Record "MAWB Header 2";
        MAWBHeader3: Record "MAWB Header 2";
        MAWBReceipt: Record "MAWB Receipt";
        MAWBRec: Record "MAWB Receipt";
}

