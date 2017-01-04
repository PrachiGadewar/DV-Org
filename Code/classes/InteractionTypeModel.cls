public class InteractionTypeModel {
    
   
        public Id businessRuleId { get; set; }
        public String businessRuleCode { get; set; }
        public String businessRuleName { get; set; }
        public String phase { get; set; }
        public String processStep { get; set; }
        
        public String ruleType { get; set; }
        public String ruleDisplayType { get; set; }
        
        public Decimal numericValue { get; set; }
        public String stringValue { get; set; }
        public Boolean booleanValue { get; set; }
        public List<SelectOption> selectOptions { get; set; }
        public String picklistValue { get; set; }
  
        public Map<String, Decimal> numericMap { get; set; }
      public transient Boolean disabled { get; set; }
         
    public static List<InteractionTypeModel> Deserialize(String objectSnapShot)
    {
        List<InteractionTypeModel> lista = (List<InteractionTypeModel>)JSON.deserialize(objectSnapShot, List<InteractionTypeModel>.class);
        return lista ;
    }
}