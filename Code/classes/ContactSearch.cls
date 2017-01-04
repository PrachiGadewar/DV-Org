public class ContactSearch {
    public static List<Contact> searchForContacts(String lName,String pCode){
        List<Contact> listContact = new List<Contact>();
        listContact = [Select id,Lastname,MailingPostalcode from Contact where Lastname =: lName and MailingPostalcode =: pCode];
        return listContact;
    }
}