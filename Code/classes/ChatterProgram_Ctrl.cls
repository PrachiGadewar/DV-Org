public with sharing class ChatterProgram_Ctrl 
{

    public String UserId { get; set; }

    public ChatterProgram_Ctrl() {
        UserId = UserInfo.getUserId();
    }

    public PageReference TestAction1() {
        return null;
    }

    
}