global with sharing class TestPayPalResponseCtrl {

    public string tx {get; set;}
    public string Payer_Email {get; set;}
    public string payment_status{get; set;}
    public string invoice{get; set;}
    
    Map<String, String> parameterMap {get; set;}
    
    public PageReference InsertCertificationP() 
    {
        
        parameterMap = ApexPages.currentPage().getParameters();
        
        System.Debug('IPN received: ' + System.Now());
        
        if(VerifyResponse())
        {
            if ( parameterMap.get('txn_id') != null )
                 tx = parameterMap.get('txn_id');
            if ( parameterMap.get('payer_email') != null )
                 Payer_Email= parameterMap.get('payer_email');
            if ( parameterMap.get('payment_status') != null )
                 payment_status = parameterMap.get('payment_status');
            if ( parameterMap.get('invoice') != null )
                 invoice = parameterMap.get('invoice');

            if(tx!=null)
            {
                Certification_Payment__c obj = new Certification_Payment__c();
                
                obj.Transaction_ID__c = tx ;
                obj.Payment_Status__c = payment_status;
                insert obj;
           }
       }
        return null;
    }
    
    public Boolean VerifyResponse()
    {
        String queryString = 'cmd=_notify-validate';
        
        for (String parameterName : parameterMap.KeySet()) {
                queryString += '&' + parameterName + '=' + EncodingUtil.urlEncode(parameterMap.get(parameterName), 'UTF-8');
        }
        System.Debug('IPN Querystring: ' + queryString);
        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setEndpoint('https://www.sandbox.paypal.com/cgi-bin/webscr');
        req.setMethod('POST');
        req.setBody(queryString);
        req.setHeader('Content-Type'  , 'application/x-www-form-urlencoded');
        req.setHeader('Content-Length', req.getBody().length().format());
        req.setTimeout(60000);
        
        system.debug('req body: ' + req.getBody());
        
        HttpResponse res = new HttpResponse();
        String verificationResponse;
        
       // If this method is being called through a test method, create a sample response
        if(Test.isRunningTest()) {
            // The sample response is based on a page parameter populated in the test method, called 'verification response'
            verificationResponse = ApexPages.currentPage().getParameters().get('verifcationResponse');
        } else {
            res = http.send(req);
            verificationResponse = res.getBody(); 
            System.Debug('IPN Response: ' + verificationResponse );
        }
        
        return verificationResponse.equalsIgnoreCase('VERIFIED');
    }
    /*
    @httpPost
    global Static void SendResponse()
    {
        H
        setStatusCode(200);
    }*/
}