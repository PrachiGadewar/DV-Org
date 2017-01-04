public with sharing class Ctrl_TestGooglePage 
{
    public wrapperc wr{get; set;}
    public class wrapperc
    {
        public Boolean checked{get;set;}
        Public String Lat{get;set;}
        Public String Lng{get;set;}
        public wrapperc(String latitude, String longitude)
        {
            Lat = latitude;
            Lng = longitude;
        }
    }
    public Ctrl_TestGooglePage()
    {
        wr = new wrapperc('18.5195700' ,'73.8553500');        
    }
}