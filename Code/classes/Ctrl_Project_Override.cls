public with sharing class Ctrl_Project_Override {

    Public Project2__c Project{get; set;}   
    public Ctrl_Project_Override() 
    {
           project = new Project2__c();
    }

    Public PageReference CustomSave()
    {
        // Insert or update record with given values and return to list page.
        upsert project;
        PageReference pref = new PageReference('/apex/Project_List');
        return pref;
    }
    Public PageReference CustomCancel()
    {
        PageReference pref = new PageReference('/apex/Main_Page');
        return pref;
    }
   
}