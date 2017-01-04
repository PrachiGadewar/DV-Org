@istest
Public class TestCoverage_BatchClass
{
    public static testMethod void TestMethodForBatch()
    {
        Project2__c pro = new Project2__c(Name = 'ERIC');
        TestCoverage_BatchClass testCoverage = new TestCoverage_BatchClass();
        Test.startTest(); 
        Batch_UpdateProjectFields testbatch = new Batch_UpdateProjectFields(); 
        Database.executeBatch(new Batch_ProjectFieldsUpdate(), 1);
        
        //test.execute(new SchedulableContext);
        Test.stopTest(); 
    }
}