tableextension 50005 CustomerExt extends Customer
{
    fields
    {
        modify("E-Mail")
        {

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
        field(50006; "E-Mail 1"; Text[250])
        {

        }
    }

    trigger OnAfterDelete()
    begin
        ShipperItem.RESET;
        ShipperItem.SETRANGE("Shipper Code", "No.");
        IF ShipperItem.FINDFIRST THEN
            ERROR(Text50000, "No.", ShipperItem.TABLENAME);

        ShipperAgent.RESET;
        ShipperAgent.SETRANGE("Shipper Code", "No.");
        IF ShipperAgent.FINDFIRST THEN
            ERROR(Text50000, "No.", ShipperAgent.TABLENAME);

        ShipperFarm.RESET;
        ShipperFarm.SETRANGE("Shipper Code", "No.");
        IF ShipperFarm.FINDFIRST THEN
            ERROR(Text50000, "No.", ShipperFarm.TABLENAME);

        ShipperNotifyParty.RESET;
        ShipperNotifyParty.SETRANGE("Shipper Code", "No.");
        IF ShipperNotifyParty.FINDFIRST THEN
            ERROR(Text50000, "No.", ShipperNotifyParty.TABLENAME);

        ShipperConsignee.RESET;
        ShipperConsignee.SETRANGE("Shipper Code", "No.");
        IF ShipperConsignee.FINDFIRST THEN
            ERROR(Text50000, "No.", ShipperConsignee.TABLENAME);
    end;

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".


    var
        ShipperAgent: Record "Shipper Agent";
        ShipperItem: Record "Shipper Item";
        ShipperFarm: Record "Shipper Farm";
        ShipperNotifyParty: Record "Shipper Notify Party";
        ShipperConsignee: Record "Shipper Consignee";
        Text50000: Label 'You cannot delete Shipper %1 because there is at least one %2  associated with it.';
}

