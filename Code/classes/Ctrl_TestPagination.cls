public with sharing class Ctrl_TestPagination
{
    List<categoryWrapper> categories {get;set;}
    public String TempMessage{get;set;}
     public String n{get; set;} 
    // instantiate the StandardSetController from a query locator
    public Ctrl_TestPagination()
    {
     n='Project2__c';
     TempMessage = '';
     }
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                con = new ApexPages.StandardSetController(Database.getQueryLocator('Select Id,Deadline__c,Using_Technologies__c, Name FROM '+n+' Order By Name limit 100'));
                // sets the number of records in each page set
                con.setPageSize(5);
            }
            return con;
        }
        set;
       
    }
 
    // returns a list of wrapper objects for the sObjects in the current page set
    public List<categoryWrapper> getCategories() {
        categories = new List<categoryWrapper>();
        for (Project2__c category : (List<Project2__c>)con.getRecords())
            categories.add(new CategoryWrapper(category));
 
        return categories;
    }
 
    // displays the selected items
    public PageReference process() {
        for (CategoryWrapper cw : categories) {
            if (cw.checked)
               TempMessage += cw.Cat.Name;
        }
        return null;
    }
 
    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
 
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
 
    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
 
    // returns the first page of records
    public void first() {
        con.first();
    }
 
    // returns the last page of records
    public void last() {
        con.last();
    }
 
    // returns the previous page of records
    public void previous() {
        con.previous();
    }
 
    // returns the next page of records
    public void next() {
        con.next();
        process();
    }
 
    // returns the PageReference of the original page, if known, or the home page.
    public void cancel() {
        con.cancel();
    }
    
    public class CategoryWrapper {
 
    public Boolean checked{ get; set; }
    public Project2__c cat { get; set;}
 
    public CategoryWrapper(){
        cat = new Project2__c();
        checked = false;
    }
 
    public CategoryWrapper(Project2__c c){
        cat = c;
        checked = false;
    }

 
}
 
}