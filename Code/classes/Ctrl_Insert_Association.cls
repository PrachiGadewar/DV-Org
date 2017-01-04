/***************************************************************
Class   : Ctrl_Insert_Association 
Author  : PGadewar
Date    : 9/30/2013
Details : This class provides controller functionality for the VF
          page Insert_Association 
History : 
*****************************************************************/
Public with sharing class Ctrl_Insert_Association {
 Public String SelectedEmployee{get; set;}
     Public String SelectedProject{get; set;}
     
     Public list<SelectOption> getEmployees()
     {
         list<SelectOption> options = new list<SelectOption>();
         
         for(Employee__c employee: [select Name from Employee__c])
         {
             options.add(new SelectOption(employee.Id, employee.Name));
         }
         
         return options;
     }
     Public List<SelectOption> getProjects()
     {
         List<SelectOption> options = new List<SelectOption>();
         
         for(Project2__c p : [select Name from Project2__c])
         {
             options.add(new SelectOption(p.id, p.name));
         }
         
         return options;
     }    
     
     Public PageReference InsertRecord()
     {
         Project_Employee_Association__c PEAssociation = new Project_Employee_Association__c();
         PageReference pRef = new PageReference('/apex/Main_Page');
         PEAssociation.Employee__c = SelectedEmployee;
         PEAssociation.Project__c = SelectedProject;
         
         insert PEAssociation;
         return pRef;
     }

}