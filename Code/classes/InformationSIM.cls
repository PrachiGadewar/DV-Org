public class InformationSIM
{    
    public class Address_components {
        public String long_name;
        public String short_name;
        public List<String> types;
    }

    public class Northeast{
        public Double lat;
        public Double lng;
    }

    public List<Results> results;
    public String status;

    public class Bounds {
        public Northeast northeast;
        public Northeast southwest;
    }

    public class Geometry {
        public Bounds bounds;
        public Northeast location;
        public String location_type;
        public Bounds viewport;
    }

    public class Results {
        public List<Address_components> address_components;
        public String formatted_address;
        public Geometry geometry;
        public List<String> types;
    }

    
    public static InformationSIM parse(String json) 
    {
        return (InformationSIM) System.JSON.deserialize(json, InformationSIM.class);
    }

}