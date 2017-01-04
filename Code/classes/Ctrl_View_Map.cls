/***************************************************************
Class   : Ctrl_View_Map
Author  : PGadewar
Date    : 10/11/2013
Details : This class provides controller functionality for the VF
          page View_Map
History : 
*****************************************************************/

public with sharing class Ctrl_View_Map 
{
    private ApexPages.StandardSetController standardController;
    public List<Employee__c> SelectedEmployees { get; set;}

    public Ctrl_View_Map(ApexPages.StandardController controller) 
    {
        SelectedEmployees = [select Name, Full_Name__c, Address__c, Street__c, State__c, City__c, Zip_Code__c, Is_Selected__c from Employee__c where Is_Selected__c = true];
    }
    
    Public void SetMap()
    {
    }

    

}