/***************************************************************
Class   : EZMap_Override_Extension
Author  : PGadewar
Date    : 01/13/2014
Details : Controller to create a new EZMap.
History : v1.0 - 09/16/2013 - Created         
*****************************************************************/
public with sharing class EZMap_Override_Extension
{   
    public class ApplicationException extends Exception
    {
    }
    
    // Property to hold file name uploaded. 
    public string NameFile { get; set; }
    
    // Property to hold the body of the uploaded file. 
    public Blob ContentFile { get; set; }
    
    // Property to hold the link to the address template. 
    public string TemplateUrl { get; set; }
        
    // Current Record. 
    private EZ_Map__c currentRecord; 
      
    public EZMap_Override_Extension(ApexPages.StandardController controller) 
    {
        // Get the current record of the EasyMap. 
        currentRecord = (EZ_Map__c)controller.getRecord(); 
        
        try
        {
            List<Document> lstDocument = [Select Name from Document where Name = 'AddressMapping_Template' limit 1];
            // Construct the URL for the address Template.            
            TemplateUrl= '/servlet/servlet.FileDownload?file=' + lstDocument[0].Id;            
        }
        catch (Exception ex)
        {
            ApexPages.Message errMessage = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
            ApexPages.addMessage(errMessage);
        }        
    }
    
    public Pagereference ReadFile()
    {
        try
        {
            // Check if the file is chosen for upload. 
            if (ContentFile == null)
            {
                ApexPages.Message errMessage = new ApexPages.Message(ApexPages.Severity.FATAL, 'Please choose a file to upload.');
                ApexPages.addMessage(errMessage);
                return null;
            }
            
            // Check if the name has a value. If it does not have, assign the filename to the name. 
            if(currentRecord.Name == null)
            {
                currentRecord.Name = NameFile;
            }
                                       
            // Insert the record of the EasyMap.
            insert currentRecord;
            
            // Convert the Blob to string.
            NameFile = ContentFile.toString();
                    
            boolean isHeader = true;            
            List<string> lstRequiredFields = new List<string> {'Name', 'Street', 'City', 'State', 'Postal Code'};
            List<string> lstColumnHeaders = new List<string>();
            Map<string, integer> mapColumnHeaders = new Map<string, integer>();
            
            // List of the addreses parsed.
            List<Map_Address__c> lstMapAddresses = new List<Map_Address__c>();        
            
            // Parse the file.
            NameFile= NameFile.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
            
            // Now replace all remaining double quotes - we do this so that we can reconstruct
            // fields with commas inside assuming they begin and end with a double quote.
            NameFile= NameFile.replaceAll('""','DBLQT');            
            List<string> lstFileLines = NameFile.split('\n');            
            
            for (string fileLine : lstFileLines)
            {
                List<string> lstColumns = GetColumns(fileLine);

                // Get the header. 
                if(isHeader)
                {
                    for(integer colIndex = 0; colIndex < lstColumns.size(); colIndex++)
                    {
                        lstColumnHeaders.add(lstColumns[colIndex].trim());                        
                        mapColumnHeaders.put(lstColumns[colIndex].trim(), colIndex);
                    }
                    
                    for(string requiredField : lstRequiredFields)
                    {
                        if(!mapColumnHeaders.containsKey(requiredField))
                        {
                            //ApexPages.Message errMessage = new ApexPages.Message(ApexPages.Severity.FATAL, 'One or more required fields are missing. Please use the standard template to upload the file.');
                            //ApexPages.addMessage(errMessage);
                            ApplicationException ex = new ApplicationException ();
                            ex.setMessage('One or more required fields are missing. Please use the standard template to upload the file.');
                            throw ex;
                        }
                    }
                                   
                    isHeader = false;
                }
                else
                {
                    // Anything other than the required columns are additional info. 
                    string additionalInfo = '';
                                     
                    for (integer colIndex = lstRequiredFields.size(); colIndex < lstColumnHeaders.size(); colIndex++)
                    {
                        additionalInfo = additionalInfo + lstColumnHeaders[colIndex].replace('\r','') 
                                + ':' + lstColumns[colIndex].replace('\r','') +'<BR>';
                    }
                    
                        Map_Address__c mapAddress = new Map_Address__c(
                        Name__c = lstColumns[mapColumnHeaders.get('Name')], 
                        Street__c = lstColumns[mapColumnHeaders.get('Street')],      
                        City__c = lstColumns[mapColumnHeaders.get('City')],
                        State__c = lstColumns[mapColumnHeaders.get('State')],
                        Postal_Code__c = lstColumns[mapColumnHeaders.get('Postal Code')],
                        Additional_Information__c = additionalInfo,
                        EZ_Map__c = currentRecord.Id
                        );
                    
                    lstMapAddresses.add(mapAddress);
                }
            }
            
            if(lstMapAddresses.size() > 0)
            {
                insert lstMapAddresses;
            }
            
            PageReference redirect = new PageReference('/apex/EZMap_Display'); 
            redirect.getParameters().put('id',currentRecord.ID); 
            redirect.setRedirect(true);
             
            return redirect;          
        }
        catch(Exception ex)
        {
            List<EZ_Map__c> insertedEasyMapRecords = [
                select Id 
                from EZ_Map__c
                where Id = :currentRecord.Id
                ];
            
            if (insertedEasyMapRecords.size() > 0)
            {
                delete insertedEasyMapRecords;
            }
                       
            ApexPages.Message errMessage = new ApexPages.Message(ApexPages.Severity.FATAL, ex.getMessage());
            ApexPages.addMessage(errMessage);
        }
        
        return null;
    }
    
    private List<string> GetColumns(string line)
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
    }
}