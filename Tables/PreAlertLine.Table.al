table 50023 "Pre Alert Line"
{

    fields
    {
        field(1; "Pre Alert No"; Code[10])
        {
            TableRelation = "Pre Alert Header".No.;
        }
        field(2;"HAWB No";Code[10])
        {
        }
        field(3;"Shipper Code";Code[10])
        {
            TableRelation = Customer.No.;
        }
        field(4;"Consignee Code";Code[10])
        {
            TableRelation = Consignee.No.;
        }
        field(5;"C&F Agent";Code[10])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(6;"HAWB Date";Date)
        {
        }
        field(7;"Location Code";Code[20])
        {
            TableRelation = Location;
        }
        field(8;"Barcode No";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Pre Alert No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

