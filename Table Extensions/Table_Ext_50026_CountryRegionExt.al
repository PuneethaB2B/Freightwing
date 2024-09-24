tableextension 50026 CountryRegionExt extends "Country/Region"
{

    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    VATRegNoFormat.SETFILTER("Country/Region Code",Code);
    VATRegNoFormat.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    VATRegNoFormat.SETFILTER("Country/Region Code",Code);
    VATRegNoFormat.DELETEALL;

    Airport.RESET;
    Airport.SETRANGE("Country Code",Code);
    IF Airport.FINDFIRST THEN
      ERROR(Text001,Code);
    */
    //end;

    var
        Airport: Record "50019";
        Text001: Label 'You cannot delete Country Code %1 because it has entries associated with it';
}

