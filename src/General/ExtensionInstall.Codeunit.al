codeunit 50900 "Extension Install EHO"
{
    Subtype = Install;

    var
        AppInfo: ModuleInfo;

    trigger OnInstallAppPerCompany()
    begin
        // Code for company related operations
        //CreateProfile(); //handled by profile object
    end;

    trigger OnInstallAppPerDatabase()
    begin
        GetAppInfo();

        if AppInfo.DataVersion = Version.Create(0, 0, 0, 0) then
            HandleFreshInstall()
        else
            HandleReinstall();


        // Code for database related operations
    end;

    /// <summary> 
    /// Description for GetAppInfo.
    /// </summary>
    local procedure GetAppInfo()
    begin
        NavApp.GetCurrentModuleInfo(AppInfo); // Get info about the currently executing module     
    end;

    /// <summary> 
    /// Description for HandleFreshInstall.
    /// </summary>
    local procedure HandleFreshInstall()
    begin

    end;

    /// <summary> 
    /// Description for HandleReinstall.
    /// </summary>
    local procedure HandleReinstall()
    begin

    end;
}