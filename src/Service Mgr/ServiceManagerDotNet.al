dotnet
{
    assembly("mscorlib")
    {
        type("System.Array"; "DotNet_Array")
        {
        }
    }

    assembly("System.Collections")
    {

    }

    assembly("System.ServiceProcess")
    {
        type("System.ServiceProcess.ServiceController"; "DotNet_ServiceController")
        {
        }
        type("System.ServiceProcess.ServiceControllerStatus"; "DotNet_ServiceControllerStatus")
        {
        }
    }
}