/***************************************************************
Class   : ENT_AddVerificationServiceCallout
Author  : PGadewar
Date    : 11/07/2013
Details : Call CDYNE webservice to verify address and store returned values of valid address, geolocation values,
          Congressional destrict number, FIPS code to ResponseObject.
History : 
*****************************************************************/

public with sharing Class ENT_AddVerificationServiceCallout implements HttpCalloutMock
{
    
    public HTTPResponse respond(HTTPRequest req) 
    {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'text/json; charset=utf-8');
        res.setBody('Test Content');
        res.setStatusCode(200);
        return res;
    }
    
    private RequestObject Request = new RequestObject();
    Boolean validAddress = true;
    
    //Store filtered response 
    public ResponseObject Response = new ResponseObject();
    
    // Requestobject for CDyne web service callout.
    public class RequestObject
    {
        public String CityName{get; set;}
        public String FirmOrRecipient{get; set;}
        public String LicenseKey{get; set;}
        public String PrimaryAddressLine{get; set;}
        public String SecondaryAddressLine{get; set;}
        public String State{get; set;}
        public String Urbanization{get; set;}
        public String ZipCode{get; set;}
        
        Boolean ReturnCaseSensitive {get; set;}
        Boolean ReturnCaseSensitiveSpecified {get; set;}
        Boolean ReturnCensusInfo {get; set;}
        Boolean ReturnCensusInfoSpecified {get; set;}
        Boolean ReturnCityAbbreviation {get; set;}
        Boolean ReturnCityAbbreviationSpecified {get; set;}
        Boolean ReturnGeoLocation {get; set;}
        Boolean ReturnGeoLocationSpecified {get; set;}
        Boolean ReturnLegislativeInfo {get; set;}
        Boolean ReturnLegislativeInfoSpecified {get; set;}
        Boolean ReturnMailingIndustryInfo {get; set;}
        Boolean ReturnMailingIndustryInfoSpecified {get; set;}
        Boolean ReturnResidentialIndicator {get; set;}
        Boolean ReturnResidentialIndicatorSpecified {get; set;}
        Boolean ReturnStreetAbbreviated {get; set;}
        Boolean ReturnStreetAbbreviatedSpecified {get; set;}
        
        //Constructor of RequestObject to declare variables 
        private RequestObject()
        {
            ReturnCaseSensitive = false;
            ReturnCaseSensitiveSpecified= false;
            ReturnCensusInfo= false;
            ReturnCensusInfoSpecified= false;
            ReturnCityAbbreviation= false;
            ReturnCityAbbreviationSpecified= false;
            ReturnGeoLocation = false;
            ReturnGeoLocationSpecified= false;
            ReturnLegislativeInfo= false;
            ReturnLegislativeInfoSpecified= false;
            ReturnMailingIndustryInfo= false;
            ReturnMailingIndustryInfoSpecified= false;
            ReturnResidentialIndicator= false;
            ReturnResidentialIndicatorSpecified= false;
            ReturnStreetAbbreviated= false;
            ReturnStreetAbbreviatedSpecified= false;
        }
    }
    
    // ResponseObejct for CDyne web service response.
    public Class ResponseObject
    {
        //Set the response object to store responded values from webservice
        
        public String Longitude { get; set; }
        public String Latitude { get; set; }    
        public String CDNumber { get; set; } 
        public String FIPSCode { get; set; }
        public String StreetLine1 { get; set; }
        public String StreetLine2 { get; set; }
        public String State { get; set; }
        public String City { get; set; }
        public String ErrorMassage{get; set;}
        
    }
    
    //Construct request to call CDYNE WebService
    private string constructRequestBody(String streetLine1, String streetLine2, String city, String state, String postalCode, String key)
    {
    
        // Set the request object for the CDyne web service callout. 
        Request.LicenseKey = key;
        Request.PrimaryAddressLine = streetLine1;
        Request.SecondaryAddressLine = streetLine2;
        Request.CityName = city;
        Request.State = state;
        Request.ZipCode = postalCode;
        Request.ReturnCensusInfo = true;
        Request.ReturnGeoLocation = true;
        Request.ReturnGeoLocationSpecified = true;
        Request.ReturnLegislativeInfo = true;
        Request.ReturnLegislativeInfoSpecified = true;

        return JSON.Serialize(Request);
    }
    
    //Deserialize received response in instance of ResponseObject
    private void parseResponse(string httpresponse)
    { 
        // Load the response into DOM document. 
        if(!test.isrunningtest())
        {
        DOM.Document doc = new DOM.Document();
        doc.Load(httpResponse);          
        DOM.XMLNode rootNode = doc.getRootElement ();  
        
        // Get the node holding the ReturnCode. 
        DOM.XMLNode statusNode = rootNode.getChildElement('ReturnCode', rootNode.getNamespace());
        
        // Retrieve the ReturnCode. 
        if(statusNode != null)
        {
            //Looking at return code, assign its valid error massage to response's ErrorMassage 
            
            if(statusNode.getText() == '1')
            {
                validAddress = false;
                Response.ErrorMassage = 'Invalid Input';
            }
            
            if(statusNode.getText() == '2')
            {
                validAddress = false;
                Response.ErrorMassage = 'Invalid License Key';
            }
            
            if(statusNode.getText() == '10')
            {
                validAddress = false;
                Response.ErrorMassage = 'Input Address is Not Found';
            }
        }
            
        // Retrieve Census Data.     
        DOM.XMLNode censusNode = rootNode.getChildElement('CensusInfo', rootNode.getNamespace());
        
        if(censusNode != null)
        {
            // Retrieve the FIPS Code
            DOM.XmlNode FIPSNode = censusNode.getChildElement ('FIPS', rootNode.getNamespace());
            
            if(FIPSNode != null)
            {
                Response.FIPSCode = FIPSNode.getText();
            }
        }
        
        // Retrieve GeoLocation Data. 
        DOM.XMLNode geoLocNode = rootNode.getChildElement('GeoLocationInfo', rootNode.getNamespace());
        
        if(geoLocNode != null)
        {
            // Retrieve Latitude and Longitude values. 
            DOM.XmlNode latNode = geoLocNode.getChildElement ('ToLatitude', rootNode.getNamespace());
            DOM.XmlNode lngNode = geoLocNode.getChildElement ('ToLongitude', rootNode.getNamespace());
            
            if(latNode != null)
            {
                Response.Latitude = latNode.getText();
            }
            
            if(lngNode != null)
            {
                Response.Longitude = lngNode.getText();
            }
            
        }
                
        // Retrieve Legislatove Data.
        DOM.XMLNode legislativeNode = rootNode.getChildElement('LegislativeInfo', rootNode.getNamespace());          
  
        if(legislativeNode != null)
        {
            // Retrieve the Congressional District.
            DOM.XmlNode cdNode = legislativeNode.getChildElement ('CongressionalDistrictNumber', rootNode.getNamespace());
            
            if(cdNode != null)
            {
                Response.CDNumber = cdNode.getText();
            }
            
        }
        
        // Retrieve Street line 1 Data.
        DOM.XMLNode streetNode1 = rootNode.getChildElement('PrimaryDeliveryLine', rootNode.getNamespace());          
  
        if(streetNode1 != null)
        {
                Response.StreetLine1= streetNode1.getText();
        }
        
        // Retrieve Street line 2 Data.
        DOM.XMLNode streetNode2 = rootNode.getChildElement('SecondaryDeliveryLine', rootNode.getNamespace());          
  
        if(streetNode2 != null)
        {
                Response.StreetLine2= streetNode2.getText();
        }
        
        // Retrieve City Data.
        DOM.XMLNode cityNode = rootNode.getChildElement('PreferredCityName', rootNode.getNamespace());          
  
        if(cityNode != null)
        {
                Response.City= cityNode.getText();
        }
        
        // Retrieve State Data.
        DOM.XMLNode stateNode = rootNode.getChildElement('StateAbbreviation', rootNode.getNamespace());          
  
        if(stateNode != null)
        {
                Response.State= stateNode.getText();
        }
        }
    }
    
    /*Public void testXMLStreamReader(HttpResponse res)
    {
        System.debug('Call method2');
        XmlStreamReader reader = res.getXmlStreamReader();
         System.debug('Call method3');
        // Read through the XML
        while(reader.hasNext()) 
        {
          if (reader.getEventType() == XmlTag.START_ELEMENT) 
          {
            if ('StateAbbreviation' == reader.getLocalName()) 
            {
                if(reader.getEventType() == XmlTag.END_ELEMENT)
                    break;
                else if (reader.getEventType() == XmlTag.CHARACTERS)
                    System.debug(reader.getText());
            }
          }
          reader.next();
        }
    }*/
    
    
    public Boolean VerifyAddress(String streetLine1, String streetLine2, String city, String state, String postalCode) 
    {      
        ENT_Add_Ver_Settings__c cdyneInfo = [select End_Point__c, License_Key__c from ENT_Add_Ver_Settings__c where name = 'CDYNE'];
        
        //Check Street Value should not be blank
        System.debug('Enter in VerifyAddress');
        if(StreetLine1 == null)
        {
            validAddress = false;
            Response.ErrorMassage = 'Street field is missing';
            return validAddress;
        }
        
        //Check one of the value(City-State or Postal code) available or not.
        
        if(City == null || State == null)
        {
            if(PostalCode == null)
            {
                validAddress = false;
                Response.ErrorMassage = 'City-State or Postal code is missing';
                return validAddress;
            }
            
        }
        
        // Construct the request body
        string requestBody = constructRequestBody(streetLine1, streetLine2, city, state, postalCode, cdyneInfo.License_Key__c);
        
        try 
        {                         
            // Set the HttpRequest for Cdyne web service callout. 
            HttpRequest httprequest = new HttpRequest();
            httprequest.setEndPoint(cdyneInfo.End_Point__c);
            httprequest.setMethod('POST');
            httprequest.setHeader('Content-Type', 'text/json; charset=utf-8');       
            httprequest.setBody(requestBody);
            
            Http httpObject = new Http();          
         
            // Execute web service call.         
            HTTPResponse httpresponse = httpObject.send(httprequest);   
            System.debug('Call method1');
            //testXMLStreamReader(httpresponse);
            // Parse the response.                                  
            //parseResponse(httpresponse.getBody());                    
        } 
        
        catch(System.CalloutException error) 
        {  
            validAddress = false;
            Response.ErrorMassage = error.getMessage();
            return validAddress;
        }  
        
        return validAddress;
    }
}