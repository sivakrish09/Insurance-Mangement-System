public class InsMotorInsuranceHandler {
    
    // agent can retrive details
    @AuraEnabled(cacheable=true)
    
    public static list<Motor_Insurance__c> getInsuranceList(string Agentid)
    {
		string inputKey = Agentid;
        list<Motor_Insurance__c> ClientDetails = [SELECT Id,Customer_Name__c, Name, Premium_Amount__c,Premium_Type__c, Motor_Type__c 
                                                  FROM Motor_Insurance__c
                                                  WHERE Agent_Id_Number__c =:inputKey ];
        return ClientDetails;
    }
	// client can retrive their data
    @AuraEnabled(cacheable=true)
    
    public static list<Motor_Insurance__c> getMotorList(string PhId)
    {
		string inputKey = PhId;
        list<Motor_Insurance__c> ClientDetails = [SELECT Id,Customer_Name__c, Name, Premium_Amount__c,Premium_Type__c, Motor_Type__c 
                                                  FROM Motor_Insurance__c
                                                  WHERE Premanent_Policy_Holder_Id__c =:inputKey ];
        return ClientDetails;
    }
}