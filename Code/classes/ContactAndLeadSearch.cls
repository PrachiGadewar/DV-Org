public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(String parameter){
        Contact c = new Contact(Lastname='Smith');
        insert c;
        
        Lead l = new Lead(Lastname='Smith',company='test');
        insert l;
        
        String searchquery = 'FIND \''+parameter+'\' IN NAME FIELDS RETURNING Contact(FirstName,LastName),Lead(FirstName,LastName)';
        List<List<SObject>> listSobject = search.query(searchquery);
        return listSobject;
    }
}