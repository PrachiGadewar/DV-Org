public with sharing class Ctrl_TestPayPal {

   public List<ItemAmountValues> listItemNameAndValue{get; set;}
    public Ctrl_TestPayPal()
    {
        listItemNameAndValue = new List<ItemAmountValues>();
        listItemNameAndValue.add(new ItemAmountValues('item_name_1','Certification 1', 'amount_1', '10'));
        listItemNameAndValue.add(new ItemAmountValues('item_name_2','Certification 2', 'amount_2', '20'));
    }
   public void middle()
    {
         /*Certification_Payment__c pay = new Certification_Payment__c();
        insert pay;*/
    }
    public PageReference getDoAction() {
        /*middle();*/

        PageReference ref = new PageReference('<form id="Paypal" name="Paypal" action="https://sandbox.paypal.com/cgi-bin/webscr"  method="post">'   
            +'<input type="hidden" name="cmd" value="_cart" />'
            +'<input type="hidden" name="upload" value="1" />'
            +'<input type="hidden" name="tax_cart" value="0%>" />'
            +'<apex:repeat value="{!listItemNameAndValue}" var="item">'
               +' <input type="hidden" name="item_name_1" value="sbjnsc " />   '
               +' <input type="hidden" name="amount_1" value="21" />'
            +' <input type="hidden" name="no_note" value="0" />'
            +'<input type="hidden" name="currency_code" value="USD" />'
           +' <input type="hidden" name="return" value="https://c.ap1.visual.force.com/apex/TestPayPalReturn"  />'
           +'<input type="hidden" name="notify_url" value="https://madhugadewar-developer-edition.ap1.force.com/TestPayPalSite/TestPayPalResponse" />'
           +' <input type="hidden" name="cn" value="How did you hear about us?" />'
            +'</form>');
        return ref;
    }
    public class ItemAmountValues
    {
        public String itemLabel{get; set;}
        public String itemName{get; set;}
        public String amountLabel{get; set;}
        public String amountValue{get; set;}
        
        public ItemAmountValues(string a, String b, String c, String d)
        {
            itemLabel = a;
            itemName = b;
            amountLabel = c;
            amountValue = d;
        }
        
    }

}