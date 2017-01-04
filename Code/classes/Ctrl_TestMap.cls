public with sharing class Ctrl_TestMap {
    public boolean DisplayMap{get;set;}
    public Employee__c Emp{get; set;}

   
    public Ctrl_TestMap () 
    {
        Emp = new Employee__c();
        DisplayMap =false;    
    }
      
    Public void SetMap()
    {
        DisplayMap = true;
    }
}