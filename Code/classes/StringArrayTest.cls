public class StringArrayTest {
    public static List<String> generateStringArray(Integer count){
        List<String> strinlist = new List<String>();
        Integer i;
        for(i=0;i<count;i++)
            strinlist.add('Test '+i);
        return strinlist;
    }
}