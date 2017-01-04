public with sharing class TestToParameter 
{
    public List<Address__c> lst{get; set;}
    public String lat{get; set;}
    public String longi{get; set;}
    public string combinedValue{get; set;}
    public TestToParameter()
    {
        lst = new List<Address__c>([
            SELECT Id, Name, Latitude__c, Longitude__c FROM Address__c
        ]);
    }
    public pagereference getProcess()
    {
         return null;
    }
    public pagereference process()
    {   
    lst = new List<Address__c>([
            SELECT Id, Name, Latitude__c, Longitude__c FROM Address__c
        ]);
        lat = ApexPages.CurrentPage().getParameters().get('lat1');  
        longi = ApexPages.CurrentPage().getParameters().get('longi1');
        system.debug('****Lat**'+lat);
        system.debug('****Longitude**'+longi);
        combinedValue = lat+','+longi;
        system.debug('****combinedValue **'+combinedValue);
        return null;
    }
}