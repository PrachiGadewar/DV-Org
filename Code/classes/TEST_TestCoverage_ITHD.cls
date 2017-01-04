@isTest
public class TEST_TestCoverage_ITHD
{   
     public static TestMethod void ENT_ITHD_CaseTrigger_TestparentCase()
     {
        Account acc = new Account(Name ='Test Account');
        insert acc; 
        System.debug('*Account*'+acc);
        Contact cont = new Contact(FirstName = 'First name',LastName='test Contact', AccountId=acc.Id);
        insert cont;
        System.debug('*Contact*** '+cont );
        Case parentCase = new Case(Status='New', Origin='Phone', ContactId = cont.Id, AccountId = acc.Id);
        insert parentCase;
        Case toUpdate = [Select id, Status from Case limit 1];
        Case childCase1 = new Case(Status='New', Origin='Phone', ContactId = cont.Id, AccountId = acc.Id, ParentId=parentCase.Id);
        insert childCase1;
        Case childCase2 = new Case(Status='New', Origin='Phone', ContactId = cont.Id, AccountId = acc.Id, ParentId=parentCase.Id);
        insert childCase2;
        Case childCase3= new Case(Status='New', Origin='Phone', ContactId = cont.Id, AccountId = acc.Id, ParentId=parentCase.Id);
        insert childCase3;
        Case childCase4= new Case(Status='New', Origin='Phone', ContactId = cont.Id, AccountId = acc.Id, ParentId=parentCase.Id);
        insert childCase4;
        Case childCase5= new Case(Status='New', Origin='Phone', ContactId = cont.Id, AccountId = acc.Id, ParentId=parentCase.Id);
        insert childCase5;

        toUpdate.Status = 'Closed';   
        update toUpdate;   
     }
}