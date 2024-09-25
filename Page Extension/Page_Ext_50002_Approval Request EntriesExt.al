pageextension 50002 ApprovalRequestEntriesExt extends "Approval Request Entries"
{

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Usersetup.GET(USERID) THEN BEGIN
      IF ApprovalSetup.GET THEN;
      IF NOT (Usersetup."User ID" = ApprovalSetup."Approval Administrator") THEN BEGIN
        FILTERGROUP(2);
        SETCURRENTKEY("Sender ID");
        SETFILTER("Sender ID",'=%1',Usersetup."User ID");
        FILTERGROUP(0);
      END;
    END;

    SETRANGE(Status);
    SETRANGE("Due Date");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Usersetup.GET(USERID) THEN BEGIN
      IF ApprovalSetup.GET THEN BEGIN END ELSE BEGIN
    #3..8
      END;
    #9..12
    */
    //end;
}

