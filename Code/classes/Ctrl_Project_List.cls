/***************************************************************
Class   : Ctrl_Project_List 
Author  : PGadewar
Date    : 9/30/2013
Details : This class provides controller functionality for the VF
          page Project_List 
History : 
*****************************************************************/
public with sharing class Ctrl_Project_List 
{
    
    public List<Project2__c> ListOfProject { get; set;}
    
    public Ctrl_Project_List ()
    {
        //Fetch all Projects from object
        ListOfProject = [select name, Description__c, Using_Technologies__c from Project2__c];
    }
    
    public PageReference BackToMainPage()
    {
        PageReference pRef = new PageReference('/apex/Main_Page');
        return pRef ;
    }
}