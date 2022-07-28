public class InsPaymenthandler
{
	public static void totalAmount()
    {
        Map<Id,Decimal> accountId = new Map<ID,Decimal>();    // store payment amount and insurance Amount
        set<ID> acid = new set<ID> (); 							// store Insurance Object id
        List<Life_Insurance__c> LifeInsuranceList = new List<Life_Insurance__c> ();  // query life insurance object
        
        AggregateResult[] QueryPayment = [SELECT SUM(Premium_Amount__c) amt, Life_Insurance__c
                                         FROM Payment__c 
                                         GROUP BY Life_Insurance__c]; 
        for(AggregateResult a : QueryPayment)
        {
            
            accountId.put((ID)a.get('Life_Insurance__c'),(Decimal)a.get('amt'));
        }
       
        acid = accountId.keySet();
        List<Life_Insurance__c> queryLifeInsurance = [SELECT Id, Name, Total_Amount_Paid__c 
                             FROM Life_Insurance__c
                             WHERE id =:acid ];
        for(Life_Insurance__c l:queryLifeInsurance )
        {
            l.Total_Amount_Paid__c=accountId.get(l.id);
            LifeInsuranceList.add(l);
            
        }
        update LifeInsuranceList;
   }
}