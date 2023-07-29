interface "IRemote Source EHO"
{
    procedure UpdateVersions(var Software: Record "Software EHO"; var SoftwareVersion: Record "Software Version EHO");
    procedure GetFiles(var Software: Record "Software EHO"; var SoftwareVersion: Record "Software Version EHO"; var FileEntryEHO: Record "File Entry EHO");
    procedure GetFile(var Software: Record "Software EHO"; var FileEntryEHO: Record "File Entry EHO")

}