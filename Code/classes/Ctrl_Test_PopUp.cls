public with sharing class Ctrl_Test_PopUp {
    public boolean popupBlock {get; set;}
    public pagereference viewMap {get; set;}
    
    public Ctrl_Test_PopUp ()
    {
        viewMap = new Pagereference('apex/View_Map');
    }
}