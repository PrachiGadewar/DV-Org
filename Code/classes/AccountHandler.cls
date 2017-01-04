public class AccountHandler {
    public static Account insertNewAccount(String name){
        if(name == '' || name == null)
            return null;
        else{
            Account account = new Account(Name = name);
            try{
                insert account;
                return account;
            }catch(Exception e){
                return null;
            }
        }
        return null;
    }
}