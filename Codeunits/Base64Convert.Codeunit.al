codeunit 50036 "Base64 Convert."
{

    trigger OnRun()
    begin
    end;

    var
        MemoryStream: DotNet MemoryStream;
        Convert: DotNet Convert;
        ConvertedArray: DotNet Array;


    procedure ToBase64(InS: InStream): Text
    var
        Base64String: Text;
    begin
        MemoryStream := MemoryStream.MemoryStream();
        COPYSTREAM(MemoryStream, InS);
        ConvertedArray := MemoryStream.ToArray();
        Base64String := Convert.ToBase64String(ConvertedArray);

        MemoryStream.Close();
        EXIT(Base64String);
    end;


    procedure FromBase64(Base64String: Text; var OutS: OutStream)
    begin
        IF Base64String = '' THEN
            EXIT;
        ConvertedArray := Convert.FromBase64String(Base64String);
        MemoryStream := MemoryStream.MemoryStream(ConvertedArray);
        MemoryStream.WriteTo(OutS);
        MemoryStream.Close();
    end;
}

