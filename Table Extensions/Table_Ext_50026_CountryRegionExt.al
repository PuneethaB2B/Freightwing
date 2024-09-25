tableextension 50026 CountryRegionExt extends "Country/Region"
{
    trigger OnAfterDelete()
    begin
        Airport.RESET;
        Airport.SETRANGE("Country Code", Code);
        IF Airport.FINDFIRST THEN
            ERROR(Text001, Code);
    end;

    var
        Airport: Record 50019;
        Text001: Label 'You cannot delete Country Code %1 because it has entries associated with it';
}

