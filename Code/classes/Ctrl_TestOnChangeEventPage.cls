public with sharing class Ctrl_TestOnChangeEventPage {

    public void DoSumation() 
    {
        Sum = SecondValue + FirstValue;
    }
    public Double Sum { get; set; }

    public Double SecondValue { get; set; }

    public Double FirstValue { get; set; }
    
    public String Name{ get; set;}
}