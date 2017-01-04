/***************************************************
Details : Classes Covered from the Address Verification 
          Classes Covered:
          - ENT_AddVerificationServiceCallout
          
****************************************************/

@isTest
public class TEST_TestCoverage_AddVerification
{
    
    Public ENT_Add_Ver_Settings__c createAddVerSetting(String name, String endPoint, String key)
    {
        ENT_Add_Ver_Settings__c testAddVerSetting = new ENT_Add_Ver_Settings__c(Name = name, End_Point__c = endPoint, License_Key__c = key);
        return testAddVerSetting;
    }


    public static testMethod void Test_ENT_AddVerificationServiceCallout()
    {
        TEST_TestCoverage_AddVerification testCoverage = new TEST_TestCoverage_AddVerification();
        
        String str = 'Prachi';
        DOM.Document doc = new DOM.Document();
        doc.Load(str);  
        System.debug('doc'+doc);
        system.debug('str'+Str);
        ENT_Add_Ver_Settings__c addVerSetting = testCoverage.createAddVerSetting('CDYNE', 'http://pav3.cdyne.com/PavService.svc/VerifyAddressAdvanced','96c2b183-1df3-4440-ac7c-90bd1286998d');
        insert addVerSetting;
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new ENT_AddVerificationServiceCallout());
        ENT_Add_Ver_Settings__c cdyneInfo = [select End_Point__c, License_Key__c from ENT_Add_Ver_Settings__c where name = 'CDYNE'];
        ENT_AddVerificationServiceCallout temp = new ENT_AddVerificationServiceCallout();
        //String temp1 = temp.constructRequestBody('730 North Dean Road',null, 'Auburn', 'AL',null,cdyneInfo.License_Key__c);
        //temp.parseResponse(temp1); 
        temp.VerifyAddress('730 North Dean Road',null, 'Auburn', 'AL',null);
        
        Test.stopTest();
        
        
    }
}