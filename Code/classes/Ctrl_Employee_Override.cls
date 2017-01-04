/***************************************************************
Class   : Ctrl_Employee_Override
Author  : PGadewar
Date    : 9/30/2013
Details : This class provides controller functionality for the VF
          page Employee_Override
History : 
*****************************************************************/
Public with sharing class Ctrl_Employee_Override{
    
    Private ID employeeId {get; set;}
    Public Employee__c Employee{get; set;}  
     
    public Ctrl_Employee_Override() 
    {
        employeeId = ApexPages.currentPage().getParameters().get('employee');
        
        If(EmployeeId != null)//Check current record Id is not null
        {            
            Employee= [select Name, Last_Name__c, Designation__c, Specialist_in__c, Employee_ID__c, recordTypeId,Address__c, Phone__c from Employee__c where Id =: employeeId ];
        }
        else
        {
            Employee= new Employee__c();    
        }
    }

    Public PageReference CustomSave()
    {
        // Insert or update record with given values and return to list page.
        upsert employee;
        PageReference pref = new PageReference('/apex/Employee_List');
        return pref;
    }
    
    Public PageReference CustomCancel()
    {
        PageReference pRef = new PageReference('/apex/Main_Page');
        return pRef;
    }
}