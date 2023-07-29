enum 50904 "Remote Source EHO" implements "IRemote Source EHO"
{
    Extensible = true;

    /*value(0; " ")
    {
        Caption = ' ';
    }*/
    value(1; "Azure Devops")
    {
        Caption = 'Azure Devops';
        Implementation = "IRemote Source EHO" = "Azure Devops Source EHO";
    }
    value(2; GitHub)
    {
        Caption = 'GitHub';
        Implementation = "IRemote Source EHO" = "GitHub Source EHO";
    }/*
    value(3; GitLab)
    {
        Caption = 'GitLab';
    }
    value(4; Bitbucket)
    {
        Caption = 'Bitbucket';
    }*/

}
