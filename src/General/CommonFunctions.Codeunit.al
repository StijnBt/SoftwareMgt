codeunit 50910 "Common Functions EHO"
{
    procedure GetZipFileFromFileEntries(var FileEntry: Record "File Entry EHO"; var TempBlob: Codeunit "Temp Blob")
    var
        DataCompression: Codeunit "Data Compression";
        InStr: InStream;
        OutStr: OutStream;
    begin
        DataCompression.CreateZipArchive();

        if FileEntry.FindSet() then
            repeat
                if not FileEntry.Folder then begin
                    FileEntry.GetFile();
                    FileEntry.CalcFields("Blob Content");
                    FileEntry."Blob Content".CreateInStream(InStr);
                    if CopyStr(FileEntry."Full Path", 1, 1) = '/' then
                        FileEntry."Full Path" := CopyStr(FileEntry."Full Path", 2);
                    DataCompression.AddEntry(InStr, FileEntry."Full Path");
                end;
            until FileEntry.Next() < 1;

        TempBlob.CreateOutStream(OutStr);
        DataCompression.SaveZipArchive(OutStr);
        DataCompression.CloseZipArchive();
    end;


}
