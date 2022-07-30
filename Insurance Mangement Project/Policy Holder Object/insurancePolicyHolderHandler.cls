public class insurancePolicyHolderHandler
{
    public static void contactCreate(list<Policy_Holder__c> oldLead, list<Policy_Holder__c> newlead)
    {
        Account InsAccountID = [SELECT id FROM Account WHERE Name = 'Insurance Company Clients'];
        list<contact> conlist = new list<contact>();
        
        for(Policy_Holder__c oldRecord: oldLead)
        {
           if(oldRecord.Request_Status__c != 'Background Verification- Completed')
           {
               for(Policy_Holder__c newRecord : newlead)
               {
                   if(newRecord.Request_Status__c == 'Background Verification- Completed')
                   {
                       Contact phContact = new Contact();
                        phContact.AccountId=InsAccountID.Id;
                        phContact.Email = newRecord.Email__c;
                        phContact.LastName = newRecord.Name;
                        phContact.Phone = newRecord.Phone__c;
                       	phContact.Policy_Holder__c = newRecord.Id;
                        conlist.add(phContact);
                   }
               }
           }
        }
       	insert conlist;
    }
  	public static void UserCreate(list<Policy_Holder__c> oldLeads, list<Policy_Holder__c> newleads)
    {
        set<Id> PolicyId = new set<Id>();
        
        for (Policy_Holder__c oldrecord: oldLeads)
        {
             if(oldrecord.Request_Status__c != 'Approved' && oldrecord.Do_you_want_to_create_user_ID__c	 !='Yes')
             {
                 for (Policy_Holder__c newRecord: newleads)
                 {
                     if(newRecord.Request_Status__c == 'Approved' && newRecord.Do_you_want_to_create_user_ID__c	 =='Yes')
                     {
                         PolicyId.add(newRecord.Id);
                     }
                 }
             }
        }
        Map<String,Id> ContactMap = new Map<String,Id>();
        List<Contact> contactId = [SELECT Id,Policy_Holder__c FROM Contact WHERE Policy_Holder__c =: PolicyId ];
        for(Contact con:contactId )
        {
			ContactMap.put(con.Policy_Holder__c,con.id);
            
        }
        Profile ClientProfileId =[SELECT Id FROM Profile WHERE Name ='Insurance Policy User'];
        list<User> userList = new list<user>();
		
		for (Policy_Holder__c newClient : newleads)    
        {
            if(ContactMap.containsKey(newClient.Id))
            {
			   User u = new User();
			   string nickname = newClient.Name__c;
			   u.LastName = 'Client';
			   u.FirstName = newClient.Name__c;
			   u.Email = newClient.Email__c;
			   u.Alias='Cit'+nickname.substring(1,4);
			   u.CommunityNickname ='client'+newClient.Name;
			   u.Username = newClient.Permanent_policy_holder_id__c+'@Lemonade.net';
			   u.CommunityNickname = newClient.Name__c;
			   u.ProfileId = ClientProfileId.id;
		       u.EmailEncodingKey = 'ISO-8859-1';
			   u.TimeZoneSidKey = 'America/Los_Angeles';
	           u.LanguageLocaleKey  = 'en_US';
			   u.LocaleSidKey = 'en_US';
			   u.ContactId = ContactMap.get(newClient.Id);
			   u.Agent_Record_ID__c= newClient.id;
		       userList.add(u);
                
            }
        }
        insert userList;
    }
}
