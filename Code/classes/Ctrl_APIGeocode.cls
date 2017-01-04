public with sharing class Ctrl_APIGeocode 
{

    public String LatLong { get; set; }

    public String Address {get; set;}
    public InformationSIM geocodevalues;
    public PageReference GetGeocodes() 
    {
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');
        //'http://www.datasciencetoolkit.org/maps/api/geocode/json?sensor=false&address=1600+Amphitheatre+Parkway,+Mountain+View,+CA';
        Address = Address.replace(' ','+');
        system.debug('Address '+Address );
       // String url = 'https://www.mapquestapi.com/geocoding/v1/address?location='+Address+'&key=Fmjtd%7Cluur21ut29%2C22%3Do5-90tg9z';
        String url = 'https://maps.googleapis.com/maps/api/geocode/json?address='+Address+'&sensor=true&key=AIzaSyBkBFg8cedLHLoWXiDbEMyHKw8TiTD3RUM';
        req.setendpoint(url);
        HTTPResponse resp = http.send(req);
        system.debug('response'+resp.getBody());
        JSONParser parser = JSON.createParser(resp.getBody());
        while(Parser.nextToken() != null)
        {
            system.debug('value of token'+parser.getcurrenttoken());
            if (parser.getcurrenttoken() == JSONToken.START_OBJECT) 
            {
                 geocodevalues = (InformationSIM)parser.readValueAs(InformationSIM.class); 
            }
        }
        //geocode = geocodevalues.LatLng;
        //InformationSIM.LatLng testLatLng = new InformationSIM.LatLng;
        
        //system.debug('Geocode values'+testLatLng.lat);
        //system.debug('Geocode values'+geocodevalues);    
        return null;
    }

}