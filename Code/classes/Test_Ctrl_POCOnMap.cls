global with sharing class Test_Ctrl_POCOnMap 
{
    public List<Address__c> LstSelectedRecords;
    public String CurrentLat{get; set{CurrentLat = value;}}
    public String CurrentLongi{get; set{CurrentLongi=value;}}
    public string abc{get; set;}
    //public static weatherObservation weather{get;set;}
    public PageReference ShowOnMap() 
    {
        return null;
    }


    public List<wrapperObject> lstAddresses{get; set;}
    public Test_Ctrl_POCOnMap()
    {
        LstSelectedRecords = new List<Address__c>();
        lstAddresses = new List<wrapperObject>();
        List<Address__c> lst = new List<Address__c>([
            SELECT Id, Name, Latitude__c, Longitude__c FROM Address__c
        ]);
        for(Address__c a: lst)
        {
            wrapperObject newwrapper = new wrapperObject(a);
            lstAddresses.add(newwrapper);
        }
    }
        
    Public class wrapperObject
    {
        public Address__c Address{get;set;}
        public Boolean Checked{get;set;}
        
        public wrapperObject(Address__c add)
        {
            Address = add;
            Checked = false;
        }
    }
    public List<Address__c> GetLstSelectedRecords()
    {        
        for(wrapperObject record : lstAddresses)
        {
            if(record.Checked)
            {
                LstSelectedRecords.add(record.Address);
            }
        }
        return LstSelectedRecords;
    }
    
    @remoteaction
    public static pagereference FetchInfo()
    {
        String lat = ApexPages.CurrentPage().getParameters().get('lati');  
        string longi = ApexPages.CurrentPage().getParameters().get('longi');  
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');
        String url = 'http://api.geonames.org/findNearByWeatherJSON?lat='+lat+'&lng='+longi+'&username=pgadewar';
        req.setendpoint(url);
        HTTPResponse resp = http.send(req);
        /*String jsonresp = '{"weatherObservation":{"weatherCondition":"n/a","clouds":"clouds and visibility OK","observation":"LESO 050700Z 22015KT 190V250 CAVOK 13/03 Q1000"}}';
       
                    /*,"windDirection":'+'220,"ICAO":"LESO","elevation":8,"countryCode":"ES","cloudsCode":"CAVOK","lng":-1.8,"temperature":"13","dewPoint":"3","windSpeed":"15","humidity":50,"stationName":'+
                   //'"San Sebastian / Fuenterrabia","datetime":"2014-02-05 07:00:00","lat":43.35,"hectoPascAltimeter":1000}}';*/
        String jsonresp = resp.getbody().trim();
        system.debug('JSONResp: ' + jsonresp);
        jsonresp = jsonresp.replace('datetime', 'datetime1');
        JSONParser parser = JSON.createParser(jsonresp);  
        while (parser.nextToken() != null)
        {
            system.debug('Getcurrenttoken: ' + parser.getcurrenttoken());
            system.debug('JSONToken.START_OBJECT: ' + JSONToken.START_OBJECT);
                while (parser.nextToken() != null)
                {
                    if (parser.getcurrenttoken() == JSONToken.START_OBJECT) 
                    {
                        //system.debug('value of token'+parser.getcurrenttoken());
                        weatherObservation weather = (weatherObservation)parser.readValueAs(weatherObservation.class);
                        system.debug('Weather Info: ' + weather); 
                        //weather = (weatherInfo)parser.readValueAsStrict(weatherInfo.class);            
                    }
                }
        }
        return null;
    }
    
    public SIM_related_info__c getInfo()
    {
        List<SIM_related_info__c> siminfo = new List<SIM_related_info__c>([Select name,Weather_info__c from SIM_related_info__c order by CreatedDate limit 1]);
        for(SIM_related_info__c s : siminfo)
        {
            return s;
        }
        return null;
    }/*SIM_related_info__c info = new SIM_related_info__c();
        info.name = 'Test';
        info.Weather_info__c = json;
        insert info;*/
}