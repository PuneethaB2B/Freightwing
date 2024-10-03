xmlport 50000 "Import IATA Invoices"
{
    Caption = 'Import/Export Permissions';
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("IATA Purchase Invoice"; "IATA Purchase Invoice")
            {
                XmlName = 'IATA';
                fieldattribute(Airline; "IATA Purchase Invoice"."Airline Code")
                {
                }
                fieldattribute(MAWBNo; "IATA Purchase Invoice"."MAWB No.")
                {
                }
                fieldattribute(LineNo; "IATA Purchase Invoice"."Line No.")
                {
                }
                fieldattribute(InvoiceDate; "IATA Purchase Invoice"."Airline Invoice Date")
                {
                }
                fieldattribute(WeightasPerIATA; "IATA Purchase Invoice"."Weight as per Airline")
                {
                }
                fieldattribute(AmmountAsPerIATA; "IATA Purchase Invoice"."Amount as per Airline")
                {
                }
                fieldattribute(RateAsPerIATA; "IATA Purchase Invoice"."Airline Kilo Rate")
                {
                }
                fieldattribute(Comments; "IATA Purchase Invoice".Comments)
                {
                }
                fieldattribute(BillingStartDate; "IATA Purchase Invoice"."Billing Start Date")
                {
                }
                fieldattribute(BillingEndDate; "IATA Purchase Invoice"."Billing End Date")
                {
                }
                fieldattribute(IATAInvoiceNo; "IATA Purchase Invoice"."Airline Invoice No")
                {
                }
            }
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
}

