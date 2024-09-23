table 50008 "Shipment Update Line"
{

    fields
    {
        field(1; "Activity Code"; Code[50])
        {
            TableRelation = "Import Activities"."Activity Code";
        }
        field(2; "Pre Alert No"; Code[50])
        {
            TableRelation = "Pre Alert Header".No.;
        }
        field(3; Date; Date)
        {
        }
        field(4; Status; Option)
        {
            OptionMembers = ,Yes,No;
        }
        field(5; Remarks; Text[200])
        {
        }
        field(6; "Collected By"; Text[100])
        {
        }
        field(7; "Send Notification"; Boolean)
        {

            trigger OnValidate()
            begin
                IF "Send Notification" = TRUE THEN BEGIN
                    TESTFIELD("Activity Code");
                    TESTFIELD("Pre Alert No");
                    TESTFIELD(Date);
                    TESTFIELD(Status);
                    IF CONFIRM(Text001) THEN BEGIN
                        ImportActivities.GET("Activity Code");
                        Activity := ImportActivities.Description;
                        Notifyparty.RESET;
                        Notifyparty.SETRANGE(Notifyparty.Type, Notifyparty.Type::Management);
                        Notifyparty.SETRANGE(Notifyparty.Blocked, FALSE);
                        IF Notifyparty.FINDSET THEN BEGIN
                            REPEAT
                                LineFeed := 10;
                                CarriageReturn := 13;
                                CRLF := FORMAT(LineFeed) + FORMAT(CarriageReturn);
                                Email := Notifyparty."E-Mail";
                                Name := Notifyparty.Name;
                                SMTP.CreateMessage(COMPANYNAME, 'system@fwl.com', Email, "Pre Alert No" + ' ' + 'Shipment Update Status', ' ', FALSE);
                                Body := Activity + ' ' + ' For Pre-Alert No. ' + ' ' + "Pre Alert No" + ' ' + 'has been completed.';
                                SMTP.AppendBody('Dear ' + Name + ',' + CRLF + Body);
                                //SMTP.AppendBody(CRLF+CRLF+Body);
                                SMTP.AppendBody(CRLF + 'Details are as follows:');
                                SMTP.AppendBody(CRLF + 'Pre Alert No ' + '-' + "Pre Alert No");
                                PreAlertHeader.RESET;
                                PreAlertHeader.SETRANGE(PreAlertHeader."No.", "Pre Alert No");
                                IF PreAlertHeader.FIND('-') THEN BEGIN
                                    //PreAlertHeader.GET("Pre Alert No");
                                    SMTP.AppendBody(CRLF + 'Pre Alert Date ' + '-' + FORMAT(PreAlertHeader."Pre-Alert Date"));
                                    SMTP.AppendBody(CRLF + 'Activity ' + '-' + Activity);
                                    SMTP.AppendBody(CRLF + 'MAWB No ' + '-' + PreAlertHeader."MAWB No");
                                    SMTP.AppendBody(CRLF + 'MAWB Date ' + '-' + FORMAT(PreAlertHeader."MAWB Date"));
                                END;
                                SMTP.AppendBody(CRLF + 'Status ' + '-' + FORMAT(Status));
                                SMTP.AppendBody(CRLF + 'Remarks ' + '-' + Remarks);
                                SMTP.AppendBody(CRLF + 'Document Collected By ' + '-' + "Collected By");
                                //SMTP.AddBCC( Email);
                                SMTP.Send();
                            UNTIL Notifyparty.NEXT = 0;
                        END;
                        MESSAGE('Notifications Sent');
                    END
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Activity Code", "Pre Alert No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'Are you sure you want to send status Alerts';
        Body: Text[1024];
        Email: Text[250];
        SMTP: Codeunit "400";
        Name: Text[100];
        Notifyparty: Record "50017";
        ImportActivities: Record "50009";
        Activity: Text;
        CRLF: Text[2];
        PreAlertHeader: Record "50030";
        LineFeed: Char;
        CarriageReturn: Char;
}

