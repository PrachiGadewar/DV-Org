/***************************************************************
Class   : EZMap_Display_Extension
Author  : PGadewar
Date    : 01/14/2014
Details : Extension to display EZMap
History : v1.0 - 10/01/2013 - Created         
*****************************************************************/
public with sharing class EZMap_Display_Extension
{
    private ApexPages.StandardSetController standardController;
    public List<Map_Address__c> SelectedAddresses { get; set; }
    public String SelectedRecordName{ get; set; }
   
    public EZMap_Display_Extension(ApexPages.StandardSetController controller) 
    {
        this.standardController = controller;
    }
    
    public PageReference InitializeMap()
    {       
        // Get the selected records (optional, you can use getSelected to obtain ID's and do your own SOQL)
        List<Map_Address__c> lstSelectedAddresses = (List<Map_Address__c>) standardController.getSelected();
        Set<Id> setAddressIds = new Set<Id>();
        SelectedAddresses = new List<Map_Address__c>();
        string id = ApexPages.currentPage().getParameters().get('id');
        if(lstSelectedAddresses.size() == 0)
        {
             SelectedAddresses = [SELECT EZ_Map__r.Name,  Name__c, Street__c, 
                     Additional_Information__c, City__c, State__c 
                     FROM Map_Address__c WHERE EZ_Map__c = :id];
        }
        else
        {
            for(Map_Address__c addr : lstSelectedAddresses)
            {
                setAddressIds.add(addr.ID);
            }
            
            SelectedAddresses = [SELECT EZ_Map__r.Name,  Name__c, Street__c, 
                     Additional_Information__c, City__c, State__c 
                     FROM Map_Address__c WHERE ID in :setAddressIds];
        }
        if(SelectedAddresses.size() > 0)
        {
            SelectedRecordName = SelectedAddresses[0].EZ_Map__r.Name;
        }
        return null;        
    }
}