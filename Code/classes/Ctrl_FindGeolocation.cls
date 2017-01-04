public with sharing class Ctrl_FindGeolocation {

    public List<Map_Address__c> lstAddress{get; set;}
    public string callfunc;

    public Ctrl_FindGeolocation()
    {
        lstAddress = new List<Map_Address__c>();
    }
    public PageReference Find() 
    {
        lstAddress = [Select id, name, Street__c, State__c, 
            City__c, MappingStatus__c, Postal_code__c, Latitude__c, Longitude__c 
            FROM Map_Address__c  
            WHERE Latitude__c = null AND Longitude__c = null 
        ];
        
        system.debug('Map address records'+lstAddress);
            
        callfunc = '<script> func(); </script>';
        system.debug('Finish');
        return null;
    }

}