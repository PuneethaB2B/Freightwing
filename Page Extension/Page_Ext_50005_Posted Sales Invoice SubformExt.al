pageextension 50005 PostedSalesInvoiceSubformExt extends "Posted Sales Invoice Subform"
{
    layout
    {


        addafter("No.")
        {
            field("Freight Charge Code"; Rec."Freight Charge Code")
            {
                ApplicationArea = all;
            }
            field("MAWB No."; Rec."MAWB No.")
            {
                ApplicationArea = all;
            }
            field("HAWB No."; Rec."HAWB No.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Quantity)
        {
            field("Split Weight"; Rec."Split Weight")
            {
                ApplicationArea = all;
            }
            field("Split Factor"; Rec."Split Factor")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit Price")
        {
            field("Margin %"; Rec."Margin %")
            {
                ApplicationArea = all;
            }
            field("Margin Amount"; Rec."Margin Amount")
            {
                ApplicationArea = all;
            }
            field("VAT Amount"; Rec."VAT Amount")
            {
                ApplicationArea = all;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Airline Code"; Rec."Airline Code")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Margin Amount"; "VAT %")
        moveafter("Airline Code"; "VAT Prod. Posting Group")
    }
    trigger OnAfterGetRecord()
    begin
        Rec."Line Amount" := Rec."Margin Amount" + rec."Unit Price";
    end;

}