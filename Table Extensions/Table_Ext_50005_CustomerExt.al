tableextension 50005 CustomerExt extends Customer
{
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on "Balance(Field 58)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance (LCY)"(Field 59)".

        modify("E-Mail")
        {

            //Unsupported feature: Property Modification (Data type) on ""E-Mail"(Field 102)".

            Description = '//TBLBT Changed from 80 to 250';
        }
        field(50000; "Customer Type"; Option)
        {
            OptionMembers = " ",Group,"Third Party";
        }
        field(50001; "Contact Person"; Text[50])
        {
        }
        field(50002; "Blocked."; Boolean)
        {
        }
        field(50003; "Margin %"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(50004; "Email/CC"; Text[250])
        {
            Caption = 'CC Email';
            ExtendedDatatype = EMail;
        }
        field(50005; "Weight Type"; Option)
        {
            OptionCaption = 'Docket Weight,Volume Metric Weight';
            OptionMembers = "Docket Weight","Volume Metric Weight";
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF DOPaymentCreditCard.FINDFIRST THEN
      DOPaymentCreditCard.DeleteByCustomer(Rec);

    #4..117
    VATRegistrationLogMgt.DeleteCustomerLog(Rec);

    DimMgt.DeleteDefaultDim(DATABASE::Customer,"No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..120

    //========FW Export Management======
    ShipperItem.RESET;
    ShipperItem.SETRANGE("Shipper Code","No.");
    IF ShipperItem.FINDFIRST THEN
      ERROR(Text50000,"No.",ShipperItem.TABLENAME);

    ShipperAgent.RESET;
    ShipperAgent.SETRANGE("Shipper Code","No.");
    IF ShipperAgent.FINDFIRST THEN
      ERROR(Text50000,"No.",ShipperAgent.TABLENAME);

    ShipperFarm.RESET;
    ShipperFarm.SETRANGE("Shipper Code","No.");
    IF ShipperFarm.FINDFIRST THEN
      ERROR(Text50000,"No.",ShipperFarm.TABLENAME);

    ShipperNotifyParty.RESET;
    ShipperNotifyParty.SETRANGE("Shipper Code","No.");
    IF ShipperNotifyParty.FINDFIRST THEN
      ERROR(Text50000,"No.",ShipperNotifyParty.TABLENAME);

    ShipperConsignee.RESET;
    ShipperConsignee.SETRANGE("Shipper Code","No.");
    IF ShipperConsignee.FINDFIRST THEN
      ERROR(Text50000,"No.",ShipperConsignee.TABLENAME);
    */
    //end;

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".


    var
        ShipperAgent: Record 50011;
        ShipperItem: Record 50012;
        ShipperFarm: Record 50014;
        ShipperNotifyParty: Record 50067;
        ShipperConsignee: Record 50066;
        Text50000: Label 'You cannot delete Shipper %1 because there is at least one %2  associated with it.';
}

