public with sharing class Ctrl_TestObjectAndFields 
{
    Public List<Schema.SObjectType> ListObjects{get; set;}
    Public string objectName{get;set;}
    Map<String, String> MapObjectAPIName{get; set;}
    Map<String, String> MapFieldAPIName{get; set;}
    Public String Query{get; set;}
    Public List<String> LstChildRelationship{get; set;}
    Public List<String> fieldsList{get; set;}
    Integer count = 0;
    Integer i=0;
    public boolean isRender{get;set;}
    Public Map<String, List<WrapperObjList>> ListCAAndFields{get; set;}
    
    
    Public String SelectedType{get; set;} 
    Public Map<String, Schema.SObjectType>gd {get; set;}  
    public list<String> ObjList{get;set;}
    public list<String> FieldList{get;set;}
    Public List<WrapperObjList> ListObjectWrapper{get; set;}
    Public List<WrapperObjList> ListFieldWrapper{get; set;}
    Public List<WrapperObjList> LstChildRelationshipWrapper{get; set;}
    Public List<WrapperObjList> fieldsListwrapper{get; set;}
    Map<String, Schema.SObjectType> chlRshipNameandObject = new Map<String, Schema.SObjectType>();
    
    Public list<SelectOption> getSelectedOptions()
    {
        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('no','None'));
        options.add(new SelectOption('CO','Custom Object'));
        options.add(new SelectOption('So','Standard Object'));
        
        return options;
    }
    
    Public Ctrl_TestObjectAndFields()
    { 
         ListObjectWrapper = new list<WrapperObjList>();
         ListFieldWrapper = new list<WrapperObjList>();
         MapObjectAPIName = new Map<String, String>();
         MapFieldAPIName = new Map<String, String>();
         LstChildRelationshipWrapper=new list<WrapperObjList>();
         LstChildRelationship = new List<String>();
         fieldsList=new List<String>();
         fieldsListwrapper=new list<WrapperObjList>();
         ListCAAndFields = new Map<String, List<WrapperObjList>>();
         isRender = false;
         getObjList();  
    }

    public void getObjList()
    {      
        count=0;
        objList = new list<string>();
        FieldList = new list<String>();
        gd = Schema.getGlobalDescribe();
        ListObjectWrapper.clear();
        MapObjectAPIName.clear();
        LstChildRelationshipWrapper.clear();
        for(Schema.SObjectType d : gd.values())
        {
          Schema.DescribeSObjectResult ds = d.getDescribe();
          if(SelectedType == 'CO' && ds.isCustom())
          {
              ObjList.add(ds.getLabel());
              MapObjectAPIName.put(ds.getLabel(),ds.getName());
          }
          
          else if (SelectedType == 'SO' && !ds.isCustom())
          {
                ObjList.add(ds.getLabel());
                MapObjectAPIName.put(ds.getLabel(),ds.getName());
          }          
        }
         ObjList.sort();
         for(String s : ObjList)
          {
              if(ListObjectWrapper.size() <= 1000)
              {
                  ListObjectWrapper.add(new WrapperObjList(s));
              }
          }
          system.debug('ListObjectWrapper'+ListObjectWrapper);        
    }

    Public class WrapperObjList
    {
        Public String ObjName {get; set;}
        Public boolean Selected{get; set;}
        
        Public WrapperObjList(String ob)
        {
            ObjName = ob;
            Selected = false;           
        }    
    }
    
    Public void DisplayFields()
    {
        ListCAAndFields.clear();
        SelectedType = 'None';
        ListFieldWrapper.clear();
        MapFieldAPIName.clear();
        LstChildRelationship.clear();
        LstChildRelationshipWrapper.clear();
        for(WrapperObjList o : ListObjectWrapper)
        {
            if(o.selected == true)
            {
                objectName = o.ObjName;
                count++;
            }
        }
        if(count > 1)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select only one value'));
            SelectedType = 'None';
            ListObjectWrapper.clear();
        }
        else
        {
            if(objectName == null)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter value'));
                SelectedType = 'None';
            }
            else
            {
                String ObjectAPIName = MapObjectAPIName.get(objectName);
                Schema.SObjectType objToken = Schema.getGlobalDescribe().get(ObjectAPIName);
                FieldList = getFields(objToken);
                FieldList.sort();
                for(String s : FieldList)
                  {
                      if(ListFieldWrapper.size() <= 1000)
                      {
                          ListFieldWrapper.add(new WrapperObjList(s));
                      }
                  } 
                Schema.DescribeSObjectResult sobject_describe = objToken.getDescribe();
                List<Schema.ChildRelationship> crel = sobject_describe.getChildRelationships();
                
                for(Schema.ChildRelationship s : crel)
                {
                    Schema.SObjectType obj = s.getChildSObject();
                    String s2 = s.getRelationshipName();
                    chlRshipNameandObject.put(s2, obj);
                    if(s2!=null)
                    {
                        LstChildRelationship.add(s2);
                    }
                }    
                LstChildRelationship.sort();
                for(String s : LstChildRelationship)
                  {
                      if(LstChildRelationshipWrapper.size() <= 1000)
                      {
                          LstChildRelationshipWrapper.add(new WrapperObjList(s));
                      }
                  }                
                  //system.debug('call DisplayFields'+LstChildRelationshipWrapper);              
            } 
            ListObjectWrapper.clear(); 
            //collectfieldList();
          }     
    }
    Public List<String> getFields(Schema.SObjectType objToken)
    { 
        Schema.DescribeSObjectResult sobject_describe = objToken.getDescribe();
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap();
        List<String> FieldList2 = new List<String>();
        FieldList2.clear();
        for(Schema.SObjectField d : field_map.values())
        {
            Schema.DescribeFieldResult ds = d.getDescribe();
            FieldList2.add(ds.getLabel());
            MapFieldAPIName.put(ds.getLabel(), ds.getName());
        } 
        return FieldList2;
    }
    
   Public void collectfieldList()
    {
        string CRName = apexpages.currentpage().getparameters().get('CRName');
       // ListCAAndFields.clear();
        Schema.SObjectType obj;
        System.debug('**Map**'+ListCAAndFields);
        System.debug('**Parameter**'+CRName );
        /*for(WrapperObjList l : LstChildRelationshipWrapper)
        {
            If(l.selected == true )
            {*/
                fieldsListwrapper.clear();
                obj = chlRshipNameandObject.get(CRName);
                system.debug(obj);
                fieldsList = getFields(obj);
                fieldsList.sort();
                for(String s : fieldsList)
                  {
                      if(fieldsList.size() <= 1000)
                      {
                          fieldsListwrapper.add(new WrapperObjList(s));
                          system.debug('**Count**'+ i++);
                      }
                  }
                  system.debug('**Key*'+CRName);
                  system.debug('**value*'+fieldsListwrapper);
                 // if(ListCAAndFields.get(CRName)==null)
                       ListCAAndFields.put(CRName, fieldsListwrapper);
               fieldsList.clear();
           /*} 
         }*/
         System.debug('**Map**'+ListCAAndFields);
    }
    
    Public void BuildQuery()
    {
        Query = 'SELECT Id';
        for(WrapperObjList f : ListFieldWrapper)
        {
            if(f.selected == true)
            {
                Query = Query + ', ' +MapFieldAPIName.get(f.ObjName)+' ';
            }
        }
        for(WrapperObjList f1 : LstChildRelationshipWrapper)
        {    
            if(f1.selected == true)
            {   
                Query =  Query+', (SELECT Id ';
                for(WrapperObjList f : ListCAAndFields.get(f1.Objname))
                {
                    if(f.selected == true)
                    {
                        Query = Query + ', '+ MapFieldAPIName.get(f.ObjName)+' ';
                    }
                }
                Query = Query + 'FROM '+ f1.ObjName + ')';
            }
        }
        Query = Query + ' FROM '+ MapObjectAPIName.get(ObjectName);
     
  }
}