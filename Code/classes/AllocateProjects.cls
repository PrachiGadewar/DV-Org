public with sharing class AllocateProjects {

    public AllocateProjects(ApexPages.StandardController controller){
    
    }
      public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        List<Project__c> nameProjects = new List<Project__c>();
        nameProjects = [select name from Project__c];
        for(Project__c p : nameProjects){
            options.add(new SelectOption('p.name','p.name'));
        }
        return options;
    }
    Public List<SelectOption> getitemsd(){
        List<SelectOption> options = new List<SelectOption>();
        List<Developer__c> nameDevelopers = new List<Developer__c>();
        nameDevelopers = [select id,name from Developer__c];
        for(Developer__c d : nameDevelopers ){
            options.add(new SelectOption('d.name','d.name'));
        }
        return options; 
    }
}