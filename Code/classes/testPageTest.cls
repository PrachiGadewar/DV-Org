public with sharing class testPageTest 
{
    public Project__c testProject{get; set;}
    public Date Today { get; set;}
    public List<SelectOption> listOptions {get; set;}
    public testPageTest ()
    {
        listOptions = new List<SelectOption>();
        testProject = new Project__c();
    }
    public void getABCPicklistValues()
    {
        listOptions.clear();
        listOptions.add(new SelectOption('A','A'));
        listOptions.add(new SelectOption('B','B'));
        listOptions.add(new SelectOption('C','C'));
    }
    public void getXYZPicklistValues()
    {
        listOptions.clear();
        listOptions.add(new SelectOption('X','X'));
        listOptions.add(new SelectOption('Y','Y'));
        listOptions.add(new SelectOption('Z','Z'));
    }
}