public with sharing class Ctrl_ViewMap 
{

    public boolean DisplayMap{get;set;}
    Public Employee__c Emp{get; set;}

    public Ctrl_ViewMap() 
    {
        Emp = new Employee__c();
        DisplayMap = false;    
    }
      
    Public void SetMap()
    {
        DisplayMap = true;
    }

}