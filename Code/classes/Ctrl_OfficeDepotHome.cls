public with sharing class Ctrl_OfficeDepotHome 
{

    public static List<Document> listDocuments{get; set;}
    public static Boolean showLibrarySection{get; set;}
    public static Boolean showSupportSection{get; set;}
    public static Boolean showHome{get;set;}
    public static Case newCase{get;set;}
    
    public Ctrl_OfficeDepotHome()
    {
        showHome = true;
        listDocuments = new List<Document>();
        showLibrarySection = false;
        showSupportSection = false;
    }
    
    public PageReference GetDocument() 
    {
        showHome = false;
        showLibrarySection = true;
        listDocuments = [SELECT id, name from Document];
        system.debug('***listDocuments'+listDocuments);
        return null;         
    }
    
    public PageReference CreateCase() {
        showHome = false;
        showLibrarySection = false;
        showSupportSection = true;
        newCase = new Case();
        return null;
    }

    

}