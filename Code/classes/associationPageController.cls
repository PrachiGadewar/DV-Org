public with sharing class associationPageController{
     Public String SelectedEmployee{get; set;}
     Public String SelectedProject{get; set;}
     
     public list<SelectOption> getEmployees()
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
     
     Public Pagereference insertRecord()
     {
         Project_Employee_Association__c PEAssociation = new Project_Employee_Association__c();
         PEAssociation.Employee__c = SelectedEmployee;
         PEAssociation.Project__c = SelectedProject;
         insert PEAssociation;
         Pagereference pref = new Pagereference('/' + PEAssociation.id );
         return pref;
     }
}