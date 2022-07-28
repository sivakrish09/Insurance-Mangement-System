public class InsLifeInsuranceHandler 
// get Policy Holder Details
{
 // agent can retrive details
    @AuraEnabled(cacheable=true)
    public Static list<Life_Insurance__c> getPolicyHolderInfo(string Agentid)
    {
		string inputKey = Agentid;
        list<Life_Insurance__c> ClientDetails = [SELECT Id, Customer_Name__c,Name,Premium_Amount__c,Premium_Type__c 
                                                 FROM Life_Insurance__c 
                                                 WHERE Agent_Id_Number__c =: Agentid ];
        return ClientDetails;
       
    }
    
    // client can retrive their data
    @AuraEnabled(cacheable=true)
    public Static list<Life_Insurance__c> getClientInfo(string PhId)
    {
		string inputKey = PhId;
        list<Life_Insurance__c> ClientDetails = [SELECT Id, Customer_Name__c,Name,Premium_Amount__c,Premium_Type__c,Total_Amount_Paid__c 
                                                 FROM Life_Insurance__c 
                                                 WHERE Premanent_Policy_Holder_Id__c =: inputKey ];
        return ClientDetails;
       
    }
   	
}