report 50077 "P&L Schedule Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PLScheduleReport.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table17)
        {
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(DocumentType_GLEntry; "G/L Entry"."Document Type")
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(Description_GLEntry; gTxtDescription)
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(Vat_Amount; gDecVatAmount)
            {
            }
            column(Company_Name; gRecCompanyInfo.Name)
            {
            }
            column(Company_PostCode; gRecCompanyInfo."Post Code")
            {
            }
            column(Company_Address; gRecCompanyInfo.Address)
            {
            }
            column(Company_Picture; gRecCompanyInfo.Picture)
            {
            }
            column(Company_City; gRecCompanyInfo.City)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Calculate VAT Entries
                gDecVatAmount := 0;
                gRecVatEntry.RESET;
                gRecVatEntry.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
                gRecVatEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                IF gRecVatEntry.FINDSET THEN
                    REPEAT
                        gDecVatAmount += gRecVatEntry.Amount;
                    UNTIL gRecVatEntry.NEXT = 0;

                //Calculate Descriptions for Invoices
                IF "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::Invoice THEN BEGIN
                    gRecPstdPurchaseInvLine.RESET;
                    gRecPstdPurchaseInvLine.SETRANGE("Document No.", "G/L Entry"."Document No.");
                    gRecPstdPurchaseInvLine.SETRANGE("No.", "G/L Entry"."G/L Account No.");
                    IF gRecPstdPurchaseInvLine.FINDFIRST THEN
                        gTxtDescription := gRecPstdPurchaseInvLine.Description;
                END ELSE
                    gTxtDescription := "G/L Entry".Description;
            end;

            trigger OnPreDataItem()
            begin
                gRecCompanyInfo.GET;
                gRecCompanyInfo.CALCFIELDS(gRecCompanyInfo.Picture);
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
        gDecVatAmount: Decimal;
        gRecVatEntry: Record "254";
        gRecPstdPurchaseInvLine: Record "123";
        gTxtDescription: Text;
        gRecCompanyInfo: Record "79";
}

