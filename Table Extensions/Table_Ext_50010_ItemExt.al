tableextension 50010 ItemExt extends Item
{
    fields
    {
        field(50000; "HS Code"; Code[50])
        {
            TableRelation = "HS Codes".Code;
        }
    }


    //Unsupported feature: Code Modification on "TestNoEntriesExist(PROCEDURE 1006)".

    //procedure TestNoEntriesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemLedgEntry.SETCURRENTKEY("Item No.");
    ItemLedgEntry.SETRANGE("Item No.","No.");
    IF NOT ItemLedgEntry.ISEMPTY THEN
      ERROR(
        Text007,
        CurrentFieldName);

    PurchOrderLine.SETCURRENTKEY("Document Type",Type,"No.");
    PurchOrderLine.SETFILTER(
    #10..16
        Text008,
        CurrentFieldName,
        PurchOrderLine."Document Type");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
     // ERROR(
       // Text007,
       // CurrentFieldName);  //tbl
    #7..19
    */
    //end;
}

