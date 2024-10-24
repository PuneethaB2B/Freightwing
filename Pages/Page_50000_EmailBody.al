page 50000 "Email Body"
{
    PageType = StandardDialog;
    SaveValues = true;
    SourceTable = "Email Body";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Email Body';

    layout
    {
        area(content)
        {
            field("From Address"; Rec."From Address")
            {
                Caption = 'From';
            }
            field("To Address"; Rec."To Address")
            {
                Caption = 'To';
            }
            field("CC Email"; Rec."CC Email")
            {
                Caption = 'CC';
            }
            field(Subject; Rec.Subject)
            {
            }
            field("Attachment Name"; Rec."Attachment Name")
            {
                Editable = false;

                trigger OnAssistEdit()
                begin
                    DownloadHandler(Rec."Attachment Path", SaveFileDialogTitleMsg, '', SaveFileDialogFilterMsg, Rec."Attachment Name");
                end;
            }
            field(Body; Rec.Body)
            {
                Caption = 'Message';
                MultiLine = true;
            }
        }
    }

    actions
    {
    }

    var
        FileManagement: Codeunit "File Management";
        SaveFileDialogTitleMsg: Label 'Save PDF file';
        SaveFileDialogFilterMsg: Label 'PDF Files (*.pdf)|*.pdf';

    procedure DownloadHandler(FromFile: Text; DialogTitle: Text; ToFolder: Text; ToFilter: Text; ToFile: Text) Downloaded: Boolean
    begin
        ClearLastError();
        Downloaded := Download(FromFile, DialogTitle, ToFolder, ToFilter, ToFile);
        if not Downloaded then
            if GetLastErrorText <> '' then
                Error('%1', GetLastErrorText);
    end;

    procedure Download(FromFile: Text; DialogTitle: Text; ToFolder: Text; ToFilter: Text; var ToFile: Text): Boolean
    begin
    end;
}

