public with sharing class CallSoapServiceController {

    private String Result;
    public String endpoint {get; set;}
    public String soapaction {get; set;}
    public String payload {get; set;}
    public String creds {get; set;}
    public String chosen {get; set;}
    public String getResult() {
        return Result;
    }

    public CallSoapServiceController () {
        endpoint = 'https://gw.eqa.boots.co.uk/buk/services/customer';
        soapaction = 'SearchPerson';
        creds = 'Rich:spray';
        payload = '<?xml version="1.0" encoding="UTF-8"?><env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><env:Header /><env:Body><RetrieveCustomerWrapper xmlns="http://schemas.boots.com/loyalty/services/v1_0"><RetrieveCustomerV10><Header><Msgid>123</Msgid><Timstmp>20130521155243</Timstmp><Chnid>4</Chnid></Header><Request><Custloc>GB</Custloc><Queryby>1</Queryby><Adcardno>633035600000014955</Adcardno><Chkdig>4</Chkdig><Flags><Gclubs>Y</Gclubs></Flags></Request></RetrieveCustomerV10></RetrieveCustomerWrapper></env:Body></env:Envelope>';
        payload = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cus="http://schemas.boots.co.uk/services/customer/customer_v1_0">\r\n   <soapenv:Header>\r\n\r\n<wsse:Security \r\nxmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"\r\nsoapenv:mustUnderstand="1">\r\n<wsse:UsernameToken \r\nxmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"\r\nwsu:Id="UsernameToken-1">\r\n<wsse:Username>Rich</wsse:Username>\r\n<wsse:Password \r\nType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">spray</wsse:Password>\r\n</wsse:UsernameToken>\r\n</wsse:Security>\r\n\r\n   \r\n   </soapenv:Header>\r\n   <soapenv:Body>\r\n\r\n\r\n\r\n      <cus:SearchPerson>\r\n         <!--Optional:-->\r\n         <Header>\r\n\r\n            <SrcMsgDateTimestamp>2014-07-18T06:30:00</SrcMsgDateTimestamp>\r\n\r\n         </Header>\r\n         <!--Optional:-->\r\n         <SearchPersonReq>\r\n            <!--Optional:-->\r\n            <FirstName>Tahir</FirstName>\r\n            <!--Optional:-->\r\n            <SurName>Merwanji</SurName>\r\n            <!--Optional:-->\r\n            <DateOfBirth>1988-04-12</DateOfBirth>\r\n    \r\n                                  <Members>\r\n               <!--Zero or more repetitions:-->\r\n             </Members>\r\n\r\n            <!--Optional:-->\r\n         </SearchPersonReq>\r\n\r\n      </cus:SearchPerson>\r\n   </soapenv:Body>\r\n</soapenv:Envelope>';
    }    
    
    public PageReference fetchHTTP() {
       // Instantiate a new http object
        try {
            Http h = new Http();
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        //req.setMethod('GET');
        req.setMethod('POST');
        req.setTimeout(60000);
        
        req.setBody(payload);
        if (creds.length() > 0) {
            req.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(creds)));
        }
        req.setHeader('Soapaction', '"' + soapaction + '"');
        req.setHeader('Content-Type', 'text/xml; charset=UTF-8');
        req.setHeader('Accept', 'text/xml');
         
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        
        
        
        Result = 'returned:' + res.getBody() + res.getStatus() + res.toString();
        
        } catch (Exception e) {
            Result = e.getMessage();
        }
        return null;
    }

   
}