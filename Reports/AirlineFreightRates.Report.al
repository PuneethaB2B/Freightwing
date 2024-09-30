report 50075 "Airline Freight Rates"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AirlineFreightRates.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Freight Item Charge Matrix"; "Freight Item Charge Matrix")
        {
            RequestFilterFields = "Airline Code", "Destination Airport", "Effective Start Date", "Effective End Date";
            column(AirlineCode_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Airline Code")
            {
            }
            column(FlightCode_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Flight Code")
            {
            }
            column(ItemNo_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Item No.")
            {
            }
            column(FreightChargeCode_FreightItemChargeMatrix; FreightCharge.Description)
            {
            }
            column(UnitofMeasureCode_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Unit of Measure Code")
            {
            }
            column(NoofPallets_FreightItemChargeMatrix; "Freight Item Charge Matrix"."No. of Pallets")
            {
            }
            column(ULDType_FreightItemChargeMatrix; "Freight Item Charge Matrix"."ULD Type")
            {
            }
            column(FromWeight_FreightItemChargeMatrix; "Freight Item Charge Matrix"."From Weight")
            {
            }
            column(ToWeight_FreightItemChargeMatrix; "Freight Item Charge Matrix"."To Weight")
            {
            }
            column(RateAmount_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Rate Amount")
            {
            }
            column(CurrencyCode_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Currency Code")
            {
            }
            column(Calculation_FreightItemChargeMatrix; "Freight Item Charge Matrix".Calculation)
            {
            }
            column(Difference_FreightItemChargeMatrix; "Freight Item Charge Matrix".Difference)
            {
            }
            column(Sourceairport_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Source airport")
            {
            }
            column(DestinationAirport_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Destination Airport")
            {
            }
            column(EffectiveStartDate_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Effective Start Date")
            {
            }
            column(EffectiveEndDate_FreightItemChargeMatrix; "Freight Item Charge Matrix"."Effective End Date")
            {
            }
            column(Item; Item.Description)
            {
            }
            column(Logo; CompanyInformation.Picture)
            {
            }
            column(Filters; Filters)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
                Item.GET("Freight Item Charge Matrix"."Item No.");
                FreightCharge.GET("Freight Item Charge Matrix"."Freight Charge Code");
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET();
                Filters := "Freight Item Charge Matrix".GETFILTERS;
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
        Item: Record 27;
        Ok: Boolean;
        CompanyInformation: Record 79;
        Filters: Text[250];
        FreightCharge: Record 50018;
}

