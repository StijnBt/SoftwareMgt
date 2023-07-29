#Install-Module navcontainerhelper
#Update-Module navcontainerhelper
#Import-Module navcontainerhelper


#$artifactUrl = Get-BCArtifactUrl -type Sandbox -version 17 -select Latest
$artifactUrl = Get-BCArtifactUrl -type Sandbox -select Latest
#$licPath = "C:\Users\\Downloads\lic.flf"
$securePassword = ConvertTo-SecureString -String "" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential -argumentList "admin", $securePassword

Check-BcContainerHelperPermissions -Fix

New-BCContainer `
    -containerName "EHBC365" `
    -artifactUrl $artifactUrl `
    -accept_eula `
    -accept_outdated `
    -licenseFile $licPath `
    -updateHosts `
    -useBestContainerOS `
    -assignPremiumPlan `
    -auth "NavUserPassword" `
    -doNotExportObjectsToText `
    -credential $credential