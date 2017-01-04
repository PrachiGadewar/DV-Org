public with sharing class Controller_BPopup {

    public list<account> accountRecords{get;set;}
    public account accountObj {get;set;}
    public String name{get; set;}
    public account account1{get; set;}
    public list<String> selectedValue {get;set;}
    public list<SelectOption> accountTypeOption {get;set;}
    public map<String, Account> mapAcc{get;set;}
    
    public void AssignValue()
    {
    }
    public Controller_BPopup(ApexPages.StandardController stdController) {
        mapAcc = new map<String, Account>();
         accountRecords = [SELECT ID,name,phone,type FROM account where Type != '' limit 4]; 
         for(Account a : accountRecords)
             mapAcc.put(a.name,a);
          
            
            /*accountObj = new account();
            accountTypeOption = new list<SelectOption>();
            String SobjectApiName = 'account';
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
    
            for(String fieldName : fieldMap.keyset()){
                stdController.addFields(new List<String>{fieldName});
            }
            accountObj = (account)stdController.getRecord();
            
            accountTypeOption.add(new SelectOption('US','US'));
            accountTypeOption.add(new SelectOption('India','India'));
            accountTypeOption.add(new SelectOption('UK','UK'));*/
         
    }
    public list<account> getAccountRecord() {
            return accountRecords;
        }

}