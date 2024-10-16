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
            TableRelation = "Pre Alert Header"."No.";
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
            var
                ToReceipients: Text;
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
                                ToReceipients := Notifyparty."E-Mail";
                                Name := Notifyparty.Name;
                                EmailMessage.Create(ToReceipients, "Pre Alert No" + ' ' + 'Shipment Update Status', ' ');

                                //SMTP.CreateMessage(COMPANYNAME, 'system@fwl.com', Email, "Pre Alert No" + ' ' + 'Shipment Update Status', ' ', FALSE);//B2BUPG handled above where smtp structure is changed in higher version
                                Body := Activity + ' ' + ' For Pre-Alert No. ' + ' ' + "Pre Alert No" + ' ' + 'has been completed.';
                                EmailMessage.AppendtoBody('Dear ' + Name + ',' + CRLF + Body);
                                //SMTP.AppendBody(CRLF+CRLF+Body);
                                EmailMessage.AppendtoBody(CRLF + 'Details are as follows:');
                                EmailMessage.AppendtoBody(CRLF + 'Pre Alert No ' + '-' + "Pre Alert No");
                                PreAlertHeader.RESET;
                                PreAlertHeader.SETRANGE(PreAlertHeader."No.", "Pre Alert No");
                                IF PreAlertHeader.FIND('-') THEN BEGIN
                                    //PreAlertHeader.GET("Pre Alert No");
                                    EmailMessage.AppendtoBody(CRLF + 'Pre Alert Date ' + '-' + FORMAT(PreAlertHeader."Pre-Alert Date"));
                                    EmailMessage.AppendtoBody(CRLF + 'Activity ' + '-' + Activity);
                                    EmailMessage.AppendtoBody(CRLF + 'MAWB No ' + '-' + PreAlertHeader."MAWB No");
                                    EmailMessage.AppendtoBody(CRLF + 'MAWB Date ' + '-' + FORMAT(PreAlertHeader."MAWB Date"));
                                END;
                                EmailMessage.AppendtoBody(CRLF + 'Status ' + '-' + FORMAT(Status));
                                EmailMessage.AppendtoBody(CRLF + 'Remarks ' + '-' + Remarks);
                                EmailMessage.AppendtoBody(CRLF + 'Document Collected By ' + '-' + "Collected By");
                                //SMTP.AddBCC( Email);
                                EmailCode.Send(EmailMessage);
                            
                            //SMTP.Send();//B2BUPG handled above where smtp structure is changed in higher version
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
        //  SMTP: Codeunit 400;
        EmailMessage: Codeunit "Email Message";
        EmailCode: Codeunit Email;
        Name: Text[100];
        Notifyparty: Record "Notify Party";
        ImportActivities: Record "Import Activities";
        Activity: Text;
        CRLF: Text[2];
        PreAlertHeader: Record "Pre Alert Header";
        LineFeed: Char;
        CarriageReturn: Char;
}

