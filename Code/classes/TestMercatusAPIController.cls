public with sharing class TestMercatusAPIController {

    public string SelectedItem {get; set;}
    
    public List<SelectOption> lstItem{get; set;}
    private List<SelectOption> lstItem1;
    private List<SelectOption> lstItem2;
    
   
    
    public TestMercatusAPIController ()
    {
        lstItem1 = new List<SelectOption>();
        lstItem1.add(new SelectOption ('a', 'a'));
        lstItem1.add(new SelectOption ('b', 'b'));
        lstItem1.add(new SelectOption ('c', 'c'));
        
         lstItem2 = new List<SelectOption>();
        lstItem2.add(new SelectOption ('x', 'x'));
        lstItem2.add(new SelectOption ('y', 'y'));
        lstItem2.add(new SelectOption ('z', 'z'));
    }
    
    public PageReference GetFirstList()
    {
        lstItem = lstItem1;
        return null;
    }
    
    public PageReference GetSecondList()
    {
        lstItem = lstItem2;
        return null;
    }
}