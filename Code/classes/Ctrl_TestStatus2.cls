public with sharing class Ctrl_TestStatus2 {

    List<BatchJob> batchJobs;
    public String s{get{return '';} set{s = value;}}
    public List<BatchJob> batchJobs2{get{return batchJobs;} set{batchJobs = value;}}
    public Integer numberOfJobs {get; set;}
    Public boolean showRecords{get; set;}
    public DateTime currentDate{get; set;}
    public Ctrl_TestStatus2()
    {
        batchJobs = new List<BatchJob>();
         batchjobs.clear();
        currentDate = System.now();
    }
    Public pagereference RunUtility()
    {
        
        SchedulableContext sc;
        showRecords=true;
        Schedule_ProjectFieldsUpdate sch = new Schedule_ProjectFieldsUpdate();
        sch.execute(sc);
        batchjobs.clear();
        return null;
    }
 
    public void refresh()
    {
       
        for(AsyncApexJob a : [select TotalJobItems, Status, CreatedDate, CreatedById, CompletedDate, ApexClassId, ApexClass.Name From AsyncApexJob where CreatedDate >= :currentDate order by CreatedDate desc limit 1])
        {
            batchjobs.clear();
            BatchJob j = new BatchJob();
            j.job = a;
            Project__c project;
            if(a.Status == 'Completed')
            {
                 j.showReports= true;
                 project = [Select name from Project__c order by CreatedDate desc limit 1];
            }
            j.p = project;
            
            batchJobs.add(j);
        }
    }
 
    public Class BatchJob
    {
        public AsyncApexJob job {get; set;}
        public  Project__c p{get; set;}
        public boolean showReports{get; set{showReports=false;}}
    }    
    
    
       
    /*public void CollectBatchJobs2()
    {
        //Query the Batch apex jobs
        batchjobs.clear();
        for(AsyncApexJob a : [select TotalJobItems, Status, CreatedDate, CreatedById, CompletedDate, ApexClassId, ApexClass.Name From AsyncApexJob where CreatedDate >= :currentDate order by CreatedDate desc])
        {
            BatchJob j = new BatchJob();
            j.job = a;
                
             if(a.Status == 'Completed')
                 showReports= true;
             else
                 showReports=false;
                 
             batchJobs.add(j);
         }
    }*/
 
}