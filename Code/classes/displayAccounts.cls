public with sharing class displayAccounts {

    List<Account> accounts;

    public displayAccounts(ApexPages.StandardController con){
    accounts = new List<Account>();

    }
    public List<Account> getaccounts()
    {
        for(Account a : [select name,phone,Type from Account])
            accounts.add(a);
        return accounts;
    }
}