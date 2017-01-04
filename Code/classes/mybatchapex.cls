global class mybatchapex implements Schedulable,Database.Batchable<sObject>
{      
        //How to schedule batch apex.run following code in developer console.
        public static String CRON_EXP = '0 1 0 30 9 ? 2013';//Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
                //OR
      // mybatchapex m = new mybatchapex();
      // public static String sch ='0 0 0 3 9 ? 2022';
      // system.schedule('Test job',sch,m);
        //OR
       // in case of production,write schedulable class & schedule from "apex class->schedule apex"
      
       // write diff class for scheduling.chk ENT_Schedule_mybatchapex apex class.
    //Use the SchedulableContext object to keep track of the scheduled job once it's scheduled.
   global void execute(SchedulableContext ctx)
    {      
           
          // Start Batch Apex job to create Journals
          Database.executeBatch(new mybatchapex());                   
    } 
     
  //Use the start method to collect the records or objects to be passed to the interface method execute.          
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {             
     return Database.getQueryLocator([SELECT Name from account limit 1]);
    }
    //Use this method to do all required processing for each chunk of data.
    global void execute(Database.BatchableContext BC, List <sObject>scope)
    {
       /*List <Account> lstAccount = new list<Account>();
       system.debug('***lstAccount*****'+lstAccount);
        for(Sobject s : scope)
        {
            Account a = (Account)s;
          //  NumberOfEmployees=+NumberOfEmployees+1;
            a.Phone= '12345678';
            lstAccount.add(a);
            system.debug('****lstAccount2****'+lstAccount);
        }
       // to delete records
       // Delete lstAccount;
       //to update
        update lstAccount;*/
        // DataBase.emptyRecycleBin(scope);
         //  system.debug('********'+lstAccount);
    }
    
    //Use this method to send confirmation emails or execute post-processing operations.
    global void finish(Database.BatchableContext BC)
    {

//Send an email to the User after your batch completes
      Contact con = [SELECT Id, Name from Contact where name = 'Prachi Gadewar' limit 1];
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); //instantiate a new message object
      String[] arrayAddresses = new String[] {'prachi.gadewar@gmail.com'}; //denote the email address for receiving the message
      OrgWideEmailAddress owa = [select id from OrgWideEmailAddress where address='prachi.gadewar@yahoo.co.in']; 
      system.debug('********owa*******'+owa.Id);
      mail.setOrgWideEmailAddressId(owa.Id);  //from address
      mail.setTargetObjectId(con.id);
      mail.setSaveAsActivity(false); 
      mail.setToAddresses(arrayAddresses);
      // mail.setSenderDisplayName('noReply');
      mail.setSubject('Apex Batch Job is done'); //subject
      mail.setPlainTextBody('The batch Apex job processed.Update is done'); //body
      Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
      
    
      system.debug('********finish********'+mail);
      
      /*
      // Create Contact
        Contact con = new Contact();
        con.FirstName = 'Test';
        con.LastName = 'Contact';
        con.Email = 'no-reply@organization.com';
        insert con;
        // Create Email and Send
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        //msg.setTemplateId('Your Email Template Id');
        msg.setToAddresses(new String[] {'prachi.gadewar@gmail.com'});
        msg.setTargetObjectId(con.Id);
       // msg.setWhatId('Your Record Id if applicable');
        msg.setSaveAsActivity(false);
        msg.setPlainTextBody('The batch Apex job processed.Update is done'); //body
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg });
        // Don't Forget!  Clean up!
        system.debug('**********msg ***********'+msg);
        delete con;
              */
      
}

/*how to run a batch apex class? In developer console,in execute section paste following code.
 mybatchapex b = new mybatchapex();
Database.executeBatch(b);
*/

/*
As per documentation Batch Apex can process 200 Records per batch . 
But , while making callouts Batch Apex can only process 1 record per batch(as per documentation) .
To overcome this ,we have to make scope of 1 within a batch .
for eg.
mybatchapex b = new mybatchapex();
Database.executeBatch(b,1);
*/
}