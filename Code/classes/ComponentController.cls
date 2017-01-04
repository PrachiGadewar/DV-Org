public class ComponentController 
{
    public String [] strings {get; set;}

    public String getJoined()
    {
        String ret = '';

        for(String s : strings)
        {
            ret += s + ';';
        }

        return ret;
    }
}