public with sharing class Ctrl_TestSelectionCheckboxes 
{

    public List<String> SelectObject { get; set; }
    
    public List<SelectOption> SelectOptions 
    { 
        get
        {
            list<SelectOption> options = new list<SelectOption>();
            options.add(new SelectOption('account','Account'));
            options.add(new SelectOption('contact','Contact'));
            options.add(new SelectOption('lead','Lead'));
        
            return options;
        } 
        set; 
    }
    
    String[] countries = new String[]{};

    public PageReference test() {
        return null;
    }

    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('CANADA','Canada'));
        options.add(new SelectOption('MEXICO','Mexico'));

        return options;
    }

    public String[] getCountries() {
        return countries;
    }

    public void setCountries(String[] countries) {
        this.countries = countries;
    }
    
}