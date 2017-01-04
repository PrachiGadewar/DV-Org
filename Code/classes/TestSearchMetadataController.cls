public with sharing class TestSearchMetadataController {
    public List<ApexClass> Classes {get;set;}
    public string myTextSearch {get;set;}
    public boolean isClassSearch {get;set;}
    public List<ApexPage> Pages {get;set;}
    public string myPageSearch {get;set;}
    public boolean isPageSearch {get;set;}    
    public List<ApexTrigger> Triggers {get;set;}
    public string myTriggerSearch {get;set;}
    public boolean isTriggerSearch {get;set;}
    private string searchText {get;set;}

    public void doSearch()
    {
        Classes = null;
        Pages = null;        
        Triggers = null;
        
        searchText = myTextSearch.replace('*', '%');
        
        if(isClassSearch)
        {            
            doClassSearch();
        }
        if(isPageSearch)
        {        
            doPageSearch();
        }
        if(isTriggerSearch)
        {        
            doTriggerSearch();
        }
    }
                
    public void doClassSearch()
    {
        Classes = new List<ApexClass>();

        ApexClass[] ac = [select id, name, body, createdby.Name, createdbyid, lastmodifiedby.Name, lastmodifiedbyid, createddate, lastmodifieddate from apexclass where name like :searchText order by name limit 50];

        for(ApexClass a : ac)
        {
            Classes.add(a);
        }        
    }
    
    public void doPageSearch()
    {
        Pages = new List<ApexPage>();

        ApexPage[] ac = [select id, name, createdby.Name, createdbyid, lastmodifiedby.Name, lastmodifiedbyid, createddate, lastmodifieddate from ApexPage where name like :searchText order by name limit 50];
    
        for(ApexPage a : ac)
        {
            Pages.add(a);
        }                 
    }
    
    public void doTriggerSearch()
    {
        Triggers = new List<ApexTrigger>();
        
        ApexTrigger[] ac = [select id, name, body, createdby.Name, createdbyid, lastmodifiedby.Name, lastmodifiedbyid, createddate, lastmodifieddate from ApexTrigger where name like :searchText order by name limit 50];            
        
        for(ApexTrigger a : ac)
        {
            Triggers.add(a);
        }             
    }        
}