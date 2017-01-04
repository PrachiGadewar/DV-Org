public with sharing class ENT_Ctrl_CDyneCallout 
{
    // Request object for CDyne web service callout.
    class PavRequest
    {
        public String CityName{get; set;}
        public String FirmOrRecipient{get; set;}
        public String LicenseKey{get; set;}
        public String PrimaryAddressLine{get; set;}
        public String SecondaryAddressLine{get; set;}
        public String State{get; set;}
        public String Urbanization{get; set;}
        public String ZipCode{get; set;}
        
        Boolean ReturnCaseSensitive = false;
        public Boolean getReturnCaseSensitive()
        {
            return ReturnCaseSensitive;
        }
        
        Boolean ReturnCaseSensitiveSpecified= false;
        public Boolean getReturnCaseSensitiveSpecified()
        {
            return ReturnCaseSensitiveSpecified;
        }
        
        Boolean ReturnCensusInfo= false;
        public Boolean getReturnCensusInfo()
        {
            return ReturnCensusInfo;
        }
        
        Boolean ReturnCensusInfoSpecified= false;
        public Boolean getReturnCensusInfoSpecified()
        {
            return ReturnCensusInfoSpecified;
        }
        
         
        Boolean ReturnCityAbbreviation= false;
        public Boolean getReturnCityAbbreviation()
        {
            return ReturnCityAbbreviation;
        }
        
        Boolean ReturnCityAbbreviationSpecified= false;
        public Boolean getReturnCityAbbreviationSpecified()
        {
            return ReturnCityAbbreviationSpecified;
        }
        
               
        Boolean ReturnGeoLocation = false;
        public Boolean getReturnGeoLocation()
        {
            return ReturnGeoLocation ; 
        }
        
        Boolean ReturnGeoLocationSpecified= false;
        public Boolean getReturnGeoLocationSpecified()
        {
            return ReturnGeoLocationSpecified; 
        }

        Boolean ReturnLegislativeInfo= false;
        public Boolean getReturnLegislativeInfo()
        {
            return ReturnLegislativeInfo; 
        }
        
        Boolean ReturnLegislativeInfoSpecified= false;
        public Boolean getReturnLegislativeInfoSpecified()
        {
            return ReturnLegislativeInfoSpecified; 
        }
        
        Boolean ReturnMailingIndustryInfo= false;
        public Boolean getReturnMailingIndustryInfo()
        {
            return ReturnMailingIndustryInfo; 
        }
        
        Boolean ReturnMailingIndustryInfoSpecified= false;
        public Boolean getReturnMailingIndustryInfoSpecified()
        {
            return ReturnMailingIndustryInfoSpecified; 
        }

        Boolean ReturnResidentialIndicator= false;
        public Boolean getReturnResidentialIndicator()
        {
            return ReturnResidentialIndicator; 
        }
        
        
        Boolean ReturnResidentialIndicatorSpecified= false;
        public Boolean getReturnResidentialIndicatorSpecified()
        {
            return ReturnResidentialIndicatorSpecified; 
        }
        
        Boolean ReturnStreetAbbreviated= false;
        public Boolean getReturnStreetAbbreviated()
        {
            return ReturnStreetAbbreviated; 
        }
        
        Boolean ReturnStreetAbbreviatedSpecified= false;
        public Boolean getReturnStreetAbbreviatedSpecified()
        {
            return ReturnStreetAbbreviatedSpecified; 
        }
    }

    // Longitude from the response.
    public String Longitude { get; set; }

    // Latitude from the response.
    public String Latitude { get; set; }

    // Congressional District Number from the response.
    public String CDNumber { get; set; }

    // FIPS Code from the response.
    public String FIPSCode { get; set; }

    // Flag to check if the input address is valid.
    public Boolean AddressVerified { get; set; }

    // Flag to check if the input address is invalid.
    public Boolean AddressNotVerified { get; set; }

    // State - input from user.
    public String State { get; set; }

    // City - input from user.
    public String City { get; set; }

    // Street - input from user.
    public String Street { get; set; }
    
    public String WebResponse { get; set; }
    public String PostalCode{ get; set; }
    
    public ENT_Ctrl_CDyneCallout()
    {
        AddressVerified = false;
        AddressNotVerified = false; 
    } 
    
    private string constructRequestBody()
    {
        // Set the request object for the CDyne web service callout. 
        PavRequest pReq = new PavRequest();
        pReq.LicenseKey = '96c2b183-1df3-4440-ac7c-90bd1286998d';
        List<String> stringLst = new List<String>();
        /*stringLst  = Street.split(',');
        pReq.PrimaryAddressLine = stringLst[0];
        pReq.SecondaryAddressLine = stringLst[1];*/
        pReq.PrimaryAddressLine = Street;
        pReq.SecondaryAddressLine = null;
        pReq.CityName = City;
        pReq.State = State;
        pReq.ZipCode = '';
        pReq.ReturnCensusInfo = true;
        //pReq.ReturnCensusInfoSpecified = true;
        //pReq.ReturnCityAbbreviation = true;
        pReq.ReturnGeoLocation = true;
        pReq.ReturnGeoLocationSpecified = true;
        pReq.ReturnLegislativeInfo = true;
        pReq.ReturnLegislativeInfoSpecified = true;
        //pReq.ReturnStreetAbbreviated = true;

        return JSON.Serialize(pReq);
    }
    
    private void parseResponse(string response)
    {
        WebResponse = response;
        // Load the response into DOM document. 
        /*DOM.Document doc = new DOM.Document();
        doc.Load(response);          
        DOM.XMLNode rootNode = doc.getRootElement ();  
        
        // Get the node holding the ReturnCode. 
        DOM.XMLNode statusNode = rootNode.getChildElement('ReturnCode', rootNode.getNamespace());
        
        // Retrieve the ReturnCode. 
        if(statusNode != null)
        {
            
            // TODO: Need to handle other return codes as well. 
            // Please refer - http://wiki.cdyne.com/index.php/PAV_VerifyAddressAdvanced_Output
            if(statusNode.getText() == '1' || statusNode.getText() == '2' || statusNode.getText() == '10')
            {
                AddressNotVerified = true;
                return;
            }
            AddressVerified = true;
        }
            
        // Retrieve Census Data.     
        DOM.XMLNode censusNode = rootNode.getChildElement('CensusInfo', rootNode.getNamespace());
        
        if(censusNode != null)
        {
            // Retrieve the FIPS Code
            DOM.XmlNode FIPSNode = censusNode.getChildElement ('FIPS', rootNode.getNamespace());
            
            if(FIPSNode != null)
            {
                FIPSCode = FIPSNode.getText();
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
                Latitude = latNode.getText();
            }
            
            if(lngNode != null)
            {
                Longitude = lngNode.getText();
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
                CDNumber = cdNode.getText();
            }
        }*/
        
        
    }
    
    public PageReference VerifyAddress() 
    {
        AddressVerified = false;
        AddressNotVerified = false;       
        
        // Construct the request body
        string reqBody = constructRequestBody();
        
        try 
        { 
            // Set the HttpRequest for Cdyne web service callout. 
            HttpRequest request = new HttpRequest();
            request.setEndPoint('http://pav3.cdyne.com/PavService.svc/VerifyAddressAdvanced');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'text/json; charset=utf-8');       
            request.setBody(reqBody);
            
            Http httpObj = new Http();          
         
            // Execute web service call.         
            HTTPResponse response = httpObj.send(request);   
            
            // Parse the response.                                  
            parseResponse(response.getBody());                    
        } 
        catch(System.CalloutException ex) 
        {  
            ApexPages.Message errmsg = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
            ApexPages.addMessage(errmsg);
        }   
        return null;
    }
}