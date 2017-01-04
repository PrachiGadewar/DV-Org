/***************************************************************
Class   : Batch_ProjectFieldsUpdate
Author  : PGadewar
Date    : 9/30/2013
Details : This class update fields of Projects like deadline and Highly Priority
          If due date is withing upcoming 30 days then update deadline field to true
          and if is passed then mark Highly Priority to true.
History : 
*****************************************************************/
global class Batch_ProjectFieldsUpdate implements Database.Batchable<sObject>
{
    global final String Query;
        
    global Batch_ProjectFieldsUpdate ()
    {
        Query = 'Select id, Due_Date__c, Start_Date__c, Highly_Priority__c, Deadline__c from Project2__c';     
    }
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(Query);
    }
    
    
    global void execute(Database.BatchableContext BC, List<Project2__c> LstProject )
    {
        integer numberDaysDue;
        System.debug('**Before Schedule job**'+LstProject);
        for(Project2__c p : LstProject)
        {
            if(p.Due_Date__c != null)
            {
                numberDaysDue = (Date.Today()).daysBetween(p.Due_Date__c);
                if(numberDaysDue < 30)
                {
                    p.Highly_Priority__c = true;
                }
                else if(numberDaysDue  < 0)
                {
                    p.Deadline__c = true;
                }
            }
        }
        Update LstProject;
        System.debug('**After Schedule job**'+LstProject);
    } 
    
    global void finish(Database.BatchableContext BC)
    {
        Project__c p = new Project__c(Name = 'Batch Run');
        insert p;
        String add = 'prachi.gadewar@gmail.com';
        String[] arrayAddresses = add.split(',');
        EmailTemplate emailTemplateToSend = [SELECT id,name FROM EmailTemplate WHERE name = '  for Batch class']; 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(p.Id);
        mail.setToAddresses(arrayAddresses);
        mail.setSenderDisplayName('Address Verification');
        mail.setTemplateId(emailTemplateToSend.Id);
        mail.setSaveAsActivity(false);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        /*SchedulableContext sc;
        Schedule_InsertContactOfUser schedule = new Schedule_InsertContactOfUser();
        schedule.execute(sc);*/
    }
   
}