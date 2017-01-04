@RestResource(urlMapping='/PayPalIPNListener/*')
global with sharing class PayPalIPNListener
{
    @HttpPost
    global static void doPost() 
    {         
         System.Debug('PayPal Response:'); 
    }
}