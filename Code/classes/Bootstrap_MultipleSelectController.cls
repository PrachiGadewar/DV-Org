public with sharing class Bootstrap_MultipleSelectController {
    
    public list<Account> optionGroup {get ; set;}
    public Bootstrap_MultipleSelectController(ApexPages.StandardController controller) {
          optionGroup = [select id,name from Account];
    }

}