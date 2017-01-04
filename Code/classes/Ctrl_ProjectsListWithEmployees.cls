/***************************************************************
Class   : Ctrl_ProjectsListWithEmployees
Author  : PGadewar
Date    : 9/30/2013
Details : This class provides controller functionality for the VF
          page ProjectsListWithEmployees
History : 
*****************************************************************/

public with sharing class Ctrl_ProjectsListWithEmployees 
{
    Public List<Project2__c> LstProject{get; set;}
    
    Public Ctrl_ProjectsListWithEmployees ()
    {
        LstProject = new List<Project2__c>();
        getProjectList();
    }
    
    Public void getProjectList()
    {
        LstProject = [SELECT Id, Name , Start_Date__c, (select Name, Employee__r.Name FROM Project_Employee_Associations__r) FROM Project2__c];
    }
}