/***************************************************************
Class   : Ctrl_Employee_List 
Author  : PGadewar
Date    : 9/30/2013
Details : This class provides controller functionality for the VF
          page Employee_List 
History : 
*****************************************************************/
public with sharing class Ctrl_Employee_List 
{

    public List<Employee__c> ListOfEmployee { get; set;}
    
    public Ctrl_Employee_List()        // Pull all employee records
    {
        // Fetch all employee from object
        ListOfEmployee = [select id,Name,Employee_ID__c,Designation__c, Phone__c, Is_Selected__c, Street__c, City__c, State__c, Zip_Code__c, Address__c from Employee__c]; 
        for(Employee__c e : ListOfEmployee)
        {
            e.Is_Selected__c = false;
        }
    }
    
    public PageReference SetMap()         // Update records and redirect to View map page
    {
        PageReference pRef = new PageReference('/apex/View_Map');
        Update ListOfEmployee; 
        return pRef ;
    }
    
    public PageReference BackToMainPage()           //Back to Main Page
    {
        PageReference pRef = new PageReference('/apex/Main_Page');
        return pRef ;
    }
    
}