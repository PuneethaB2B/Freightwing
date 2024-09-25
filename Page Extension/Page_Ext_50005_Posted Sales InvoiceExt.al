pageextension 50005 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    layout
    {
        addbefore("No.")
        {
            field("MAWB No."; Rec."MAWB No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("No.")
        {
            field("HAWB No."; Rec."HAWB No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Order No.")
        {
            field("CC/PP"; Rec."CC/PP")
            {
                ApplicationArea = all;
            }
        }
        addafter("No. Printed")
        {
            field(Commodity; Rec.Commodity)
            {
                ApplicationArea = all;
            }
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = all;
            }
            field("Invoice Number"; Rec."Invoice Number")
            {
                ApplicationArea = all;
            }
            field("Agreed Rate"; Rec."Agreed Rate")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}