/***************************************************************
Class   : ENT_Ext_Case_EditPage_Override
Author  : Smita Bhilare
Date    : 21/11/2013
Details : This class includes methods to create new case,edit existing case,clone case & to create child case of existing case.
*****************************************************************/
public with sharing class ENT_Ext_CaseOverride
{   
    private case caseRecord;   
    private Id caseId;
    private Id parentCaseId;
    private string currentPageUrl;
    
    public ENT_Ext_CaseOverride(ApexPages.StandardController controller)
    {       
        // get parent case id from url 
        parentCaseId = ApexPages.currentPage().getparameters().get('def_parent_id');  
        
        //get current case id from url to edit or close case  
        caseId = ApexPages.currentPage().getparameters().get('id'); 
        If(caseId != null)
        {
           caseRecord = [SELECT Id,ContactId,Origin,ParentId,Reason,OwnerId,Status,IsEscalated,Priority FROM Case WHERE Id =: caseId];
        }
        currentPageUrl=ApexPages.currentPage().getUrl();        
    }
    
    public case CurrentCase
    {
        get
        {
           If(caseRecord == null) 
            {
                createNewCase();             
            } 
            // copy parent details in new case
            if(currentPageUrl.contains('cloneparent=1'))
            {
                case tempCaseRecord = new case();
                tempCaseRecord = caseRecord;
                
                caseRecord=new case();
                caseRecord= tempCaseRecord;
                caseRecord.ParentId =tempCaseRecord.Id; 
                caseRecord.Id=null;
                 
            }
            // clone current case record
            if(currentPageUrl.contains('clone=1'))
            {
                case tempCaseRecord = new case();
                tempCaseRecord = caseRecord;
                
                caseRecord=new case();
                caseRecord= tempCaseRecord;             
                caseRecord.Id=null;
            }
                
          //create child case from parent case Id taken from url
            If(parentCaseId != null)
            {
                createNewCase(); 
                caseRecord.ParentId = parentCaseId; 
            }            
            return caseRecord;
           }
    }
    
    public void CreateNewCase()
    {       
        caseRecord = new case();       
        caseRecord.OwnerId = UserInfo.getUserId();      
    }
    
    
   
     public PageReference save()
    { 
        If(caseRecord != null)
        {

                caseRecord.Status = 'Closed';
        }  
       
        // Add the case to the database.
    
        // Send the user to the detail page.
        pagereference pg = new PageReference('/'+caseRecord.id);
        pg.setRedirect(true);
        return pg; 
    }
    
     public PageReference saveAndCloseCase()
    { 
        If(true)
        {
            caseRecord.Status = 'Closed';         
            // Send the user to the detail page.
            return new PageReference('/'+caseRecord.id);
        }
        else
        {   
            // Send the user to the closeCase page.           
            PageReference closeCase =new PageReference('/'+caseRecord.id+'/s?retURL=%2F'+caseRecord.id+'&co=1');
            closeCase.setRedirect(true);
            return closeCase;
        }       
        return null;
    }
   
    public PageReference saveAndNewCase()
    {   
        // Send the user to the same page for the new case.
        
        PageReference newCase =new PageReference('/apex/ENT_CaseOverride');
        newCase.setRedirect(true);
        return newCase;
    }
   
    public PageReference cancel()
    {   
        If(caseRecord == null || caseRecord.Id == null) 
        {
            return new PageReference('/500/o');
        }
        else
        {
            return new PageReference('/'+caseRecord.id);
        }         
    }
  
}