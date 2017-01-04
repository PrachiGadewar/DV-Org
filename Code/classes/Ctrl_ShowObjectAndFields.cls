public with sharing class Ctrl_ShowObjectAndFields {

    Public List<eEmployee> empList{get; set;}
    Public List<Employee__c> selectedEmployee{get; set;} 
    Public Boolean ShowSelectedList{get; set;}
     
    Public Ctrl_ShowObjectAndFields ()
    {
        ShowSelectedList = false;
    }
    
    Public List<eEmployee> getEmployees()
    {
        if(empList == null)
        {
            empList = new List<eEmployee>();
            for(Employee__c e : [select name, Last_Name__c,Monthly_Salary__c  from Employee__c])
            {
                empList.add(new eEmployee(e));
            }
        }
        return empList;
    }
    
    public void ProcessCommand() 
    {
        selectedEmployee = new List<Employee__c>();
        for(eEmployee e: getEmployees())
        {
            if(e.selected == true)
                selectedEmployee.add(e.emp);
        }
        ShowSelectedList = true; 
    }
    
    Public class eEmployee
    {
        Public Employee__c emp{get; set;}
        Public boolean selected{get; set;}
        
        Public eEmployee(Employee__c e)
        {
            emp = e;
            selected = false;           
        }
    }
    
    Public void BackToPage()
    {
        for(eEmployee e: getEmployees())
        {
            e.selected = false;
        }
        ShowSelectedList = false;
    }

}