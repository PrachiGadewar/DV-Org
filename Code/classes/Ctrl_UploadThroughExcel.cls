public with sharing class Ctrl_UploadThroughExcel 
{

    public string NameFile { get; set; }
    public Blob ContentFile { get; set; }
    public String TemplateUrl{get; set;}
    
    private Task_Parent__c currentRecord;
    
    public Ctrl_UploadThroughExcel(ApexPages.StandardController controller) 
    {
        currentRecord = (Task_Parent__c)controller.getRecord();
        
        try
        {
            List<Document> lstDocument = [Select Name from Document where Name = 'AddressMapping_Template'];
                // Construct the URL for the address Template.            
            TemplateUrl= '/servlet/servlet.FileDownload?file=' + lstDocument[0].Id;
        }
        
        catch (Exception ex)
        {
            ApexPages.Message errMessage = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
            ApexPages.addMessage(errMessage);
        }
    }
    
    Public Void ReadFile()
    {
        
    }
}
 /* private List<string> GetColumns(string line)
 {
        List<string> lstColumns = new List<string>();        
        List<string> lstFields = line.split(',');
        boolean isCompositeField  = false;
        string compositeField = '';
        
        for(string field : lstFields)
        {
            if (field.startsWith('"') && field.endsWith('"')) 
            {
                lstColumns.add(field.replaceAll('"', ''));
            } 
            else if (field.startsWith('"')) 
            {
                isCompositeField = true;
                compositeField = field;
            } 
            else if (field.endsWith('"')) 
            {
                compositeField += ',' + field;
                lstColumns.add(compositeField.replaceAll('"', ''));
                isCompositeField = false;
            } 
            else if (isCompositeField) 
            {
                compositeField +=  ',' + field;
            } 
            else 
            {
                lstColumns.add(field.replaceAll('"', ''));
            }
        }
        
        return lstColumns;
    }*/