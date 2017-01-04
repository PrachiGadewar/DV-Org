/***************************************************************
Class   : Ctrl_ProjectsListWithEmployees
Author  : PGadewar
Date    : 9/30/2013
Details : This class used to schedule batch(Batch_ProjectFieldsUpdate)
History : 
*****************************************************************/

global class Schedule_ProjectFieldsUpdate implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Database.executeBatch(new Batch_ProjectFieldsUpdate(), 50);
    }
}