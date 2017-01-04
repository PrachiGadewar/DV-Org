global with sharing class Ctrl_POCOnMap 
{
    public List<Address__c> LstSelectedRecords;
    public String CurrentLat{get; set{CurrentLat = value;}}
    public String CurrentLongi{get; set{CurrentLongi=value;}}
    public string abc{get; set;}
    public static weatherObservation weather{get;set;}
    public PageReference ShowOnMap() 
    {
        return null;
    }


    public List<wrapperObject> lstAddresses{get; set;}
    public Ctrl_POCOnMap()
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
        system.debug('jsonresp info'+jsonresp);  
        while (parser.nextToken() != null)
        {
            system.debug('value of token'+parser.getcurrenttoken());
            if (parser.getcurrenttoken() == JSONToken.START_OBJECT) 
            {
                //system.debug('value of token'+parser.getcurrenttoken());
                //weather = new weatherInfo();
                while(parser.nextToken() != null)
                {
                     if (parser.getcurrenttoken() == JSONToken.START_OBJECT) 
                     {
                          weather = (weatherObservation)parser.readValueAs(weatherObservation.class); 
                     }
                    /*if(parser.getText() == 'weatherCondition')
                    {
                        parser.nextValue();
                        weather.weatherCondition = parser.getText();
                    }
                    else if(parser.getText() == 'clouds')
                    {
                        parser.nextValue();
                        weather.clouds = parser.getText();
                    }
                    else if(parser.getText() == 'observation')
                    {
                        parser.nextValue();
                        weather.observation = parser.getText();
                    }
                    else if(parser.getText() == 'windDirection')
                    {
                        parser.nextValue();
                        weather.windDirection = parser.getIntegerValue();
                    }
                    else if(parser.getText() == 'ICAO')
                    {
                        parser.nextValue();
                        weather.ICAO = parser.getText();
                    }
                    else if(parser.getText() == 'elevation')
                    {
                        parser.nextValue();
                        weather.elevation = parser.getIntegerValue();
                    }
                    else if(parser.getText() == 'countryCode')
                    {
                        parser.nextValue();
                        weather.countryCode = parser.getText();
                    }
                    else if(parser.getText() == 'cloudsCode')
                    {
                        parser.nextValue();
                        weather.cloudsCode = parser.getText();
                    }
                    else if(parser.getText() == 'lng')
                    {
                        parser.nextValue();
                        weather.lng = parser.getDoubleValue();
                    }
                    else if(parser.getText() == 'temperature')
                    {
                        parser.nextValue();
                        weather.temperature = parser.getText();
                    }
                    else if(parser.getText() == 'dewPoint')
                    {
                        parser.nextValue();
                        weather.dewPoint = parser.getText();
                    }
                    else if(parser.getText() == 'windSpeed')
                    {
                        parser.nextValue();
                        weather.windSpeed = parser.getText();
                    }
                    else if(parser.getText() == 'humidity')
                    {
                        parser.nextValue();
                        weather.humidity = parser.getIntegerValue();
                    }
                    else if(parser.getText() == 'stationName')
                    {
                        parser.nextValue();
                        weather.stationName = parser.getText();
                    }
                    else if(parser.getText() == 'datetime1')
                    {
                        parser.nextValue();
                        weather.datetime1 = parser.getText();
                    }
                    else if(parser.getText() == 'lat')
                    {
                        parser.nextValue();
                        weather.lat = parser.getDoubleValue();
                    }
                    else if(parser.getText() == 'hectoPascAltimeter')
                    {
                        parser.nextValue();
                        weather.hectoPascAltimeter = parser.getIntegerValue();
                    }*/
                }
                         
            }
        }
        return null;
    }
        
    public class weatherInfo
    {
        public String weatherCondition{get;set;}
        public String clouds{get;set;}
        public String observation{get;set;}
        public Integer windDirection{get;set;}
        public String ICAO{get;set;}
        public Integer elevation{get;set;}
        public String countryCode{get;set;}
        public String cloudsCode{get;set;}
        public Double lng{get;set;}
        public String temperature{get;set;}
        public String dewPoint{get;set;}
        public String windSpeed{get;set;}
        public Integer humidity{get;set;}
        public String stationName{get;set;}
        public String datetime1{get;set;}
        public Double lat{get;set;}
        public Integer hectoPascAltimeter{get;set;}
        
        /*public weatherInfo(string a, string b, String c, Integer d, String e, Integer f, String g, String h, Double i, String j, String k,String l,Integer m, String n, String o, Double p, Integer q)
        {
            weatherCondition = a;
            clouds = b;
            observation = c;
            windDirection = d;
            ICAO = e;
            elevation = f;
            countryCode = g;
            cloudsCode = h;
            lng = i;
            temperature = j;
            dewPoint = k;
            windSpeed = l;
            humidity = m;
            stationName = n;
            datetime1 = o;
            lat = p;
            hectoPascAltimeter = q;
        }
        
        public weatherInfo(String a, String b, String c)
        {
            system.debug('Enter in constructor');
            weatherCondition = a;
            clouds = b;
            observation = c;
        }*/
        public weatherInfo()
        {
        }
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