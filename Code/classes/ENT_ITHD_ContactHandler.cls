public class ENT_ITHD_ContactHandler
{  
    
    @future
    public static void createContactGroup(Set<ID> userIdsToInsert, Set<ID> userIdsToupdate) 
    {  
        ITHD_Settings__c accountCustomSetting = [SELECT Name,Setting_Value__c FROM ITHD_Settings__c WHERE name='Account Name'];   
        Account getAccountRecord = [SELECT id, Name FROM Account WHERE Name =: accountCustomSetting.Setting_Value__c LIMIT 1];
        ID accountId = getAccountRecord.id;
        Map<String, Contact> mapRecordsToContact =  new  Map<String, Contact>();
        List<User> lstUserToInsert = [SELECT Id, Name, Email, Title, Username, Department, FirstName, LastName, Phone, MobilePhone, IsActive, Street, City, State, PostalCode, Country FROM User WHERE id IN: userIdsToInsert];
        List<User> lstUserToUpdate = [SELECT Id, Name, Email, Title, Username, Department, FirstName, LastName, Phone, MobilePhone, IsActive, Street, City, State, PostalCode, Country FROM User WHERE id IN: userIdsToUpdate];
        Map<ID, sObject> mapContactRecords =  new Map<ID, sObject>(Database.query('SELECT id, Name, Email, Title, Department, FirstName, UserID__c, LastName, Phone, MobilePhone, AccountId, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry FROM Contact WHERE AccountId =: accountId'));
        ID recordTypeId = [SELECT id, name FROM RecordType WHERE Name = 'Employee' AND sObjectType = 'Contact' LIMIT 1].Id;
        List<Contact> lstInsertContacts = new List<Contact>();
        List<Contact> lstUpdateContacts = new List<Contact>();
        
        //Collect all the contact values which contains same Username as that of Username in User object.
        if(mapContactRecords.size()>0)
        {
            for(sObject contactsValues : mapContactRecords.values())
            {
                Contact contactToCheck = (Contact)contactsValues;
                mapRecordsToContact.put(contactToCheck.Id, contactToCheck);
            }
        }
        
        for(User getUser : lstUserToInsert )
        {
           // Only insert those contacts where User is Active.
           if(mapRecordsToContact.get(getUser.Username) == null)
           {
                if(getUser.IsActive == True)
                {
                    Contact createNewContact = new Contact();
                    
                    createNewContact.LastName = getUser.LastName;
                    createNewContact.FirstName = getUser.FirstName ;
                    createNewContact.LastName = getUser.LastName ;
                    createNewContact.Email = getUser.Email; 
                    createNewContact.Title = getUser.Title;
                    createNewContact.Department = getUser.Department;
                    createNewContact.Phone = getUser.Phone;
                    createNewContact.MobilePhone = getUser.MobilePhone;
                    //createNewContact.UserID__c = getUser.Username;
                    //createNewContact.Active__c = getUser.IsActive;
                    createNewContact.MailingStreet = getUser.Street;
                    createNewContact.MailingCity = getUser.City;
                    createNewContact.MailingState = getUser.State;
                    createNewContact.MailingPostalCode = getUser.PostalCode;
                    createNewContact.MailingCountry = getUser.Country;
                    createNewContact.AccountId = accountid;
                   // createNewContact.RecordTypeId = recordTypeId;
                    
                    lstInsertContacts.add(createNewContact);
                }
            }
        }
        
        for(User userToUpdate : lstUserToUpdate )
        {
           // If trigger fires on Update, check contact username is similar to User object Username.
           if(mapRecordsToContact.get(userToUpdate.Username) != null)
           { 
                contact contactRecordToUpdate = mapRecordsToContact.get(userToUpdate.Username);
                contactRecordToUpdate.put('Active__c',userToUpdate.IsActive);
                contactRecordToUpdate.put('FirstName',userToUpdate.FirstName);
                contactRecordToUpdate.put('LastName',userToUpdate.LastName);
                contactRecordToUpdate.put('Email',userToUpdate.Email);
                contactRecordToUpdate.put('Title',userToUpdate.Title);
                contactRecordToUpdate.put('Department',userToUpdate.Department);
                contactRecordToUpdate.put('Phone',userToUpdate.Phone);
                contactRecordToUpdate.put('MobilePhone',userToUpdate.MobilePhone);
                contactRecordToUpdate.put('MailingStreet',userToUpdate.Street);
                contactRecordToUpdate.put('MailingCity',userToUpdate.City);
                contactRecordToUpdate.put('MailingState',userToUpdate.State);
                contactRecordToUpdate.put('MailingPostalCode',userToUpdate.PostalCode);
                contactRecordToUpdate.put('MailingCountry',userToUpdate.Country);      
                
                lstUpdateContacts.add(contactRecordToUpdate);
                
           }
        }
        
        // List to insert contact records.
        if(!lstInsertContacts.isEmpty())
        {
            insert lstInsertContacts;
        }
        
        // List to update contact records.
        if(!lstUpdateContacts.isEmpty())
        {
            update lstUpdateContacts;
        } 
    }
}