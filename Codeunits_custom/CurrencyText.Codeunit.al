codeunit 50017 "Currency Text"
{
    // //Converts the supplied amount into currency text - Nilanjan Gupta 19/04/2K6


    trigger OnRun()
    var
        Text_Units: array[10] of Text[30];
        Text_Teens: array[9] of Text[30];
        Text_Tens: array[9] of Text[30];
    begin
    end;

    var
        txt: Text[30];
        CommaPosition: Integer;
        StartPosition: Integer;
        boolPrintDecimal: Boolean;

    [Scope('Internal')]
    procedure ConvertToText(MyAmount: Text[30]; CurrencyCode: Code[10]) txtConvertedAmount: Text[250]
    var
        txtMyAmount: Text[30];
        txtIntegerPart: Text[30];
        txtDecimalPart: Text[30];
        intDecimalPlace: Integer;
        intCount: Integer;
        txtTemp: Text[250];
        txtFinalInteger: Text[250];
        txtFinalDecimal: Text[250];
        arrPlace: array[9] of Text[20];
        recCurrency: Record "4";
        txtCurrencyNumericPos: Text[30];
        txtCurrencyDecimalPos: Text[30];
        txtTemp2: Text[2];
    begin
        IF STRPOS(MyAmount, ',') > 0 THEN BEGIN
            StartPosition := 1;
            REPEAT
                CommaPosition := STRPOS(MyAmount, ',');
                txt := txt + COPYSTR(MyAmount, StartPosition, CommaPosition - 1);
                MyAmount := COPYSTR(MyAmount, CommaPosition + 1);
            UNTIL STRPOS(MyAmount, ',') = 0;
            txt := txt + COPYSTR(MyAmount, StartPosition);
            MyAmount := txt;
        END;
        arrPlace[2] := ' THOUSAND ';
        arrPlace[3] := ' MILLION ';
        arrPlace[4] := ' BILLION ';
        arrPlace[5] := ' TRILLION ';
        /*IF (CurrencyCode = '') OR (CurrencyCode='') THEN
           boolPrintDecimal:=FALSE;
        */
        boolPrintDecimal := TRUE;
        recCurrency.RESET;
        recCurrency.SETRANGE(Code, CurrencyCode);
        IF recCurrency.FIND('-') THEN BEGIN
            txtCurrencyNumericPos := recCurrency."Currency Numeric Description";
            txtCurrencyDecimalPos := recCurrency."Currency Decimal Description";
        END
        ELSE BEGIN
            txtCurrencyNumericPos := '';
            txtCurrencyDecimalPos := 'CENT';
        END;



        //txtMyAmount := FORMAT(MyAmount);
        txtMyAmount := MyAmount;
        // Position of decimal place 0 if none.
        intDecimalPlace := STRPOS(txtMyAmount, '.');
        // Convert cents and set txtMyAmount to dollar amount.
        IF intDecimalPlace > 0 THEN BEGIN
            txtDecimalPart := COPYSTR(txtMyAmount, intDecimalPlace + 1, 2);
            txtDecimalPart := fnGetTens(txtDecimalPart);
            txtIntegerPart := COPYSTR(txtMyAmount, 1, intDecimalPlace - 1);
        END
        ELSE BEGIN
            txtIntegerPart := COPYSTR(txtMyAmount, 1);
        END;

        intCount := 1;
        REPEAT
            IF STRLEN(txtIntegerPart) >= 3 THEN
                txtTemp := COPYSTR(txtIntegerPart, STRLEN(txtIntegerPart) - 2, 3)
            ELSE
                txtTemp := txtIntegerPart;

            txtTemp := fnGetHundreds(txtTemp);
            IF txtTemp <> '' THEN
                txtFinalInteger := txtTemp + arrPlace[intCount] + txtFinalInteger;
            IF STRLEN(txtIntegerPart) > 3 THEN
                txtIntegerPart := COPYSTR(txtIntegerPart, 1, STRLEN(txtIntegerPart) - 3)
            ELSE
                txtIntegerPart := '';

            intCount := intCount + 1;
        UNTIL txtIntegerPart = '';

        IF txtFinalInteger = '' THEN
            txtFinalInteger := txtCurrencyNumericPos + ' ZERO'
        ELSE BEGIN
            IF txtFinalInteger = 'ONE' THEN
                txtFinalInteger := txtCurrencyNumericPos + ' ONE'
            ELSE
                txtFinalInteger := txtCurrencyNumericPos + ' ' + txtFinalInteger;
            //      txtFinalInteger := txtCurrencyNumericPos + 'S ' + txtFinalInteger ;
        END;
        IF boolPrintDecimal THEN BEGIN
            IF txtDecimalPart = '' THEN
                txtDecimalPart := ' AND ZERO ' + txtCurrencyDecimalPos + 'S'
            ELSE BEGIN
                IF txtDecimalPart = 'ONE' THEN
                    txtDecimalPart := ' AND ONE ' + txtCurrencyDecimalPos
                ELSE
                    txtDecimalPart := ' AND ' + txtDecimalPart + ' ' + txtCurrencyDecimalPos + 'S';
            END;
        END
        ELSE
            txtDecimalPart := ' AND ' + txtDecimalPart;
        IF boolPrintDecimal THEN
            txtConvertedAmount := txtFinalInteger + txtDecimalPart + ' ONLY'
        ELSE
            txtConvertedAmount := txtFinalInteger + ' ONLY';

    end;

    [Scope('Internal')]
    procedure fnGetTens(txtTens_in: Text[2]) txtTens_out: Text[100]
    var
        txtTemp: Text[50];
    begin
        // If value between 10-19...
        txtTemp := COPYSTR(txtTens_in, 1, 1);
        IF txtTemp = '1' THEN BEGIN
            IF txtTens_in = '10' THEN
                txtTens_out := 'TEN'
            ELSE
                IF txtTens_in = '11' THEN
                    txtTens_out := 'ELEVEN'
                ELSE
                    IF txtTens_in = '12' THEN
                        txtTens_out := 'TWELVE'
                    ELSE
                        IF txtTens_in = '13' THEN
                            txtTens_out := 'THIRTEEN'
                        ELSE
                            IF txtTens_in = '14' THEN
                                txtTens_out := 'FOURTEEN'
                            ELSE
                                IF txtTens_in = '15' THEN
                                    txtTens_out := 'FIFTEEN'
                                ELSE
                                    IF txtTens_in = '16' THEN
                                        txtTens_out := 'SIXTEEN'
                                    ELSE
                                        IF txtTens_in = '17' THEN
                                            txtTens_out := 'SEVENTEEN'
                                        ELSE
                                            IF txtTens_in = '18' THEN
                                                txtTens_out := 'EIGHTEEN'
                                            ELSE
                                                IF txtTens_in = '19' THEN
                                                    txtTens_out := 'NINETEEN'
        END
        ELSE BEGIN
            //If value between 20-99...
            IF txtTemp = '2' THEN
                txtTens_out := 'TWENTY '
            ELSE
                IF txtTemp = '3' THEN
                    txtTens_out := 'THIRTY '
                ELSE
                    IF txtTemp = '4' THEN
                        txtTens_out := 'FORTY '
                    ELSE
                        IF txtTemp = '5' THEN
                            txtTens_out := 'FIFTY '
                        ELSE
                            IF txtTemp = '6' THEN
                                txtTens_out := 'SIXTY '
                            ELSE
                                IF txtTemp = '7' THEN
                                    txtTens_out := 'SEVENTY '
                                ELSE
                                    IF txtTemp = '8' THEN
                                        txtTens_out := 'EIGHTY '
                                    ELSE
                                        IF txtTemp = '9' THEN
                                            txtTens_out := 'NINETY ';
            txtTens_out := txtTens_out + fnGetDigits(COPYSTR(txtTens_in, 2, 1));
        END;
    end;

    [Scope('Internal')]
    procedure fnGetDigits(txtDigits_in: Text[1]) txtDigits_out: Text[100]
    begin
        IF txtDigits_in = '1' THEN
            txtDigits_out := 'ONE';
        IF txtDigits_in = '2' THEN
            txtDigits_out := 'TWO';
        IF txtDigits_in = '3' THEN
            txtDigits_out := 'THREE';
        IF txtDigits_in = '4' THEN
            txtDigits_out := 'FOUR';
        IF txtDigits_in = '5' THEN
            txtDigits_out := 'FIVE';
        IF txtDigits_in = '6' THEN
            txtDigits_out := 'SIX';
        IF txtDigits_in = '7' THEN
            txtDigits_out := 'SEVEN';
        IF txtDigits_in = '8' THEN
            txtDigits_out := 'EIGHT';
        IF txtDigits_in = '9' THEN
            txtDigits_out := 'NINE';
    end;

    [Scope('Internal')]
    procedure fnGetHundreds(txtHundreds_in: Text[50]) txtHundreds_out: Text[100]
    var
        txtMyNumber: Text[100];
        txtResult: Text[250];
        txtTemp: Text[50];
    begin
        IF txtHundreds_in = '000' THEN EXIT;
        txtHundreds_in := '000' + txtHundreds_in;
        txtMyNumber := COPYSTR(txtHundreds_in, STRLEN(txtHundreds_in) - 2, 3);
        //Convert the hundreds place.
        txtTemp := COPYSTR(txtMyNumber, 1, 1);
        IF txtTemp <> '0' THEN BEGIN
            txtTemp := COPYSTR(txtMyNumber, 1, 1);
            txtResult := fnGetDigits(txtTemp) + ' HUNDRED ';
        END;

        //Convert the tens and ones place.
        txtTemp := COPYSTR(txtMyNumber, 2, 1);
        IF txtTemp <> '0' THEN BEGIN
            txtTemp := COPYSTR(txtMyNumber, 2, 2);
            txtResult := txtResult + fnGetTens(txtTemp);
        END
        ELSE BEGIN
            txtTemp := COPYSTR(txtMyNumber, 3, 1);
            txtResult := txtResult + fnGetDigits(txtTemp);
        END;
        txtHundreds_out := txtResult;
    end;
}

