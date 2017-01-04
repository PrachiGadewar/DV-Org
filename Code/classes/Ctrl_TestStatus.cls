public with sharing class Ctrl_TestStatus 
{

    public String error { get; set; }
    Public void RunUtility()
    {
        SchedulableContext sc;
        Schedule_ProjectFieldsUpdate sch = new Schedule_ProjectFieldsUpdate();
        sch.execute(sc);
    }
    
}