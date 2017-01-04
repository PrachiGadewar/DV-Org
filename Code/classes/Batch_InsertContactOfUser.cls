global Class Batch_InsertContactOfUser implements Database.Batchable<sObject>, Database.Stateful
{   
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String queryString = 'Select Id, FirstName, Lastname, Email from User';
        return Database.getQueryLocator(queryString);
    }
    
    global void execute(Database.BatchableContext BC, List<User> lstUsers)
    {  
        List<Contact> lstContacts = new List<Contact>();
        Account acc = [Select id,name from Account where name = 'User Information' limit 1];
        List<Contact> LstExistingContact = [Select Id, name, Email from Contact where AccountId =: acc.Id];
        Set<String> EmailContact = new  Set<String>();
        for(Contact c : LstExistingContact )
        {
            EmailContact.add(c.Email);
        }
        
        
        for(User u : lstUsers) 
        {
            if(!EmailContact.contains(u.Email))
            {
                Contact c = new Contact(FirstName = u.FirstName, LastName = u.LastName, AccountId = acc.Id, Email = u.Email);
                lstContacts.add(c);
            }
        }
        
        insert lstContacts;
    }
    
    global void finish(Database.BatchableContext BC)
    {
       
    }
}