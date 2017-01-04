@RestResource(urlMapping='/simpleAccount/*')
  global with sharing class SimpleAccountResource 
  {    
      static String getIdFromURI() {
          RestRequest req = RestContext.request;
          return req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
      }
      @HttpGet 
      global static string doGet() 
      {
          String id = getIdFromURI();
          Account acc = [select Id, Name from Account 
                         where Id = :id];
          return acc.Name;
      }
      
  }