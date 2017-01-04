public with sharing class RedirectTestCommon_Controller {
    
    public string ids{get; set;}
    
    public Pagereference redirectTest2()
    {
        return new PageReference('/apex/RedirectTest2');
    }
}