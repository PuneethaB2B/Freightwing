tableextension 50032 SalesShipmentLineExt extends "Sales Shipment Line"
{
    fields
    {
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure AsmToShipmentExists(var PostedAsmHeader: Record "Posted Assembly Header"): Boolean
    var
        PostedAssembleToOrderLink: Record "Posted Assemble-to-Order Link";
    begin
        IF NOT PostedAssembleToOrderLink.AsmExistsForPostedShipmentLine(Rec) THEN
            EXIT(FALSE);
        EXIT(PostedAsmHeader.GET(PostedAssembleToOrderLink."Assembly Document No."));

    end;



}