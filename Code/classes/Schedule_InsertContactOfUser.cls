global class Schedule_InsertContactOfUser implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Database.executeBatch(new Batch_InsertContactOfUser(), 50);
    }
}