codeunit 50033 Test
{

    trigger OnRun()
    begin
        Name := 'Paul Chege';
        FOR i := 1 TO STRLEN(Name) DO BEGIN
            IF Name[i] = ' ' THEN BEGIN
                Name1 := COPYSTR(Name, 1, i - 1);
                Name2 := COPYSTR(Name, i + 1, STRLEN(Name) - i);
            END;
        END;

        Name3 := LOWERCASE(COPYSTR(Name1, 4, STRLEN(Name1) - 3) + COPYSTR(Name1, 1, 3) + ' ' + COPYSTR(Name2, 3, STRLEN(Name2) - 3) + COPYSTR(Name2, 1, 3));

        MESSAGE(FORMAT(Name3));
        MESSAGE(FORMAT(Name4));
        //MESSAGE('Name %1 %2', Name2,Name1);


        ////////////////
        /*Time1 := 010500T;
        Time2 := 013200T;
        MESSAGE(FORMAT(Time1));
        MESSAGE(FORMAT(Time2));
        IF (Time1 <= 235959T) AND (Time2 >= 000000T) THEN BEGIN
          t2 := 235959T - Time1 + 2000;
          t3 := Time2 - 000000T;
          t2 := t2 + t3;
        END ELSE IF (Time1 >= 000000T) AND (Time2 >= 000000T) THEN
          t2 := Time2 - Time1
        ELSE IF (Time1 < 235959T) AND (Time2 < 235959T) THEN
          t2 := Time2 - Time1;
        
        Hours := ROUND(((t2/1000)/60)/60,1);
        Min := ROUND((t2/1000)/60,1);
        MESSAGE('%1 Hours %2 Minutes',Hours,Min);
        //END;
         */

    end;

    var
        Time1: Time;
        Time2: Time;
        t1: Time;
        t2: Integer;
        t3: Integer;
        Hours: Integer;
        "Min": Integer;
        gCduCalcTime: Codeunit "7600";
        t4: Integer;
        Name: Text;
        i: Integer;
        Name1: Text;
        Name2: Text;
        Name3: Text;
        Name4: Text;
        Length: Integer;
}

