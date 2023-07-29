UnInstall-NavContainerApp -containerName EHBC365 -name 'Event Horizon' -version '1.0.0.1'
UnPublish-NavContainerApp -containerName EHBC365 -name 'Event Horizon' -version '1.0.0.1'

UnInstall-NavContainerApp -containerName EHBC365 -name 'RESTApp' -version '17.3.0.0'
UnPublish-NavContainerApp -containerName EHBC365 -name 'RESTApp' -version '17.3.0.0'
Sync-NavContainerApp -containerName EHBC365 -name 'RESTApp' -Mode Clean



Publish-NavContainerApp -containerName EHBC365 -appFile 'C:\Users\Desktop\waldo.restapp\waldo_RESTApp_17.3.0.0.app' -skipVerification
Install-BcContainerApp -containerName EHBC365 -appName 'RESTApp'