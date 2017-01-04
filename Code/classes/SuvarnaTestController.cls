public with sharing class SuvarnaTestController {
 public List<wrapperObject> lstAddresses{get; set;}
    public SuvarnaTestController ()
    {
        lstAddresses = new List<wrapperObject>();
        List<Address__c> lst = new List<Address__c>([
            SELECT Id, Name, Latitude__c, Longitude__c, Checked__c FROM Address__c
        ]);
        for(Address__c a: lst)
        {
            wrapperObject newwrapper = new wrapperObject(a);
            lstAddresses.add(newwrapper);
        }
    }
    Public class wrapperObject
    {
        public Address__c Address{get;set;}
        public Boolean Checked{get;set;}
        
        public wrapperObject(Address__c add)
        {
            Address = add;
            Checked = false;
        }
    }
    
    public List<Address__c> GetLstSelectedRecords()
    {
        List<Address__c> LstSelectedRecords = new List<Address__c>();
        
        for(wrapperObject record : lstAddresses)
        {
            if(record.Checked)
            {
                LstSelectedRecords.add(record.Address);
            }
        }
        
        return LstSelectedRecords;
    }
}