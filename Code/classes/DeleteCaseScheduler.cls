global class DeleteCaseScheduler implements Schedulable,Database.Batchable<SObject> {

    global void execute(SchedulableContext sc) {
        
        Database.executeBatch(new DeleteCaseScheduler(), 100);
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
         return Database.getQueryLocator('Select id, casenumber from Case where Owner.Name=\'Spam Queue\'');
    }

    global void execute(Database.BatchableContext bc, list<Case> cases) {
         delete cases;
    }

    global void finish(Database.BatchableContext bc) {
    }
}