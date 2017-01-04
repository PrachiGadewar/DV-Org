public with sharing class TestStaticPageController 
{
    public String link{get; set;}
    public TestStaticPageController()
    {
        List<Account> account = [SELECT name, BillingStreet, BillingState, BillingPostalCode, BillingCity 
            FROM  Account
            WHERE Name = 'Prachi Gadewar Test'
        ];
         link ='http://maps.google.com/maps/api/staticmap?center='+ account[0].BillingStreet+ ','+
          account[0].BillingCity + account[0].BillingState + account[0].BillingPostalCode+'zoom=16&format=png&maptype=roadmap&mobile=false'+
          'language=English&markers=|color:Yellow|label:Address|' +  account[0].BillingStreet + ','+
          account[0].BillingCity + account[0].BillingState + account[0].BillingPostalCode+'&size=500x500&key=&sensor=false&'+ account[0].name+'_map';
          
          System.debug(link);
    }
    
}