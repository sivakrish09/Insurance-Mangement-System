public with sharing class agentHandlerClass
{
    public static void createnewContact(list<Agent__c>NewRecord, list<Agent__c> oldRecord)
    {
        Account InsAccountID = [SELECT id FROM Account WHERE Name = 'Insurance Company Agents'];
        list<Contact> AgentContacts = new list<Contact>();
        Contact con = new Contact();
        
        for(Agent__c oldAge : oldRecord )
        {
			if(oldAge.Request_Status__c != 'Background Verification- Completed')
            {
                for(Agent__c newAge :NewRecord )
                {
					if(newAge.Request_Status__c == 'Background Verification- Completed')
                    {
						con.LastName = newAge.Name__c;
                        con.Phone = newAge.Phone__c;
                        con.Email = newAge.Email__c;
                        con.AccountId = InsAccountID.id;
                        con.Agent__c = newAge.Id;
                        AgentContacts.add(con);
                    }
                }
            }
        }
        Insert AgentContacts; 
    }
    public static void createnewuser(list<Agent__c>NewRecords, list<Agent__c> oldRecords)  
	{
        set<Id> Agentid = new set<Id>();//agent IDS need to create user account
        
        for( Agent__C oldAge : oldRecords)
		{
			if(oldAge.Request_Status__c != 'Approved' && oldAge.user_creation__c !='Yes')
				{
                    system.debug('old records:' + oldAge) ;
                    for(Agent__C Agentcontact : NewRecords)
                        {
                            system.debug('new records:'+ Agentcontact) ;
                              if( Agentcontact.Request_Status__c == 'Approved' && Agentcontact.user_creation__c =='Yes')
                                  {
                                      Agentid.add(Agentcontact.Id);
                                  }
                        }	
                }
        }
        
        system.debug(Agentid);
        Map<String,Id> ContactMap = new Map<String,Id>(); // holdes agent and contact id
        List<Contact> contactId = [SELECT Id,Agent__c FROM Contact WHERE Agent__c =: Agentid ];
        System.debug(contactId);
        for(Contact con:contactId )
        {
			ContactMap.put(con.Agent__c , con.Id);
            
        }
       	System.debug('Map:'+ContactMap);
        
        Profile AgentProfileId =[SELECT Id FROM Profile WHERE Name ='Insurance Agent'];
        list<User> AgentLogin = new list<User>();
        
        for(Agent__C newAge : NewRecords)
        {
            if(ContactMap.containsKey(newAge.Id))
            {
                User u = new User();
		string nickname = newAge.Name__c;
		u.LastName = 'Agent';
		u.FirstName = newAge.Name__c;
		u.Email = newAge.Email__c;
		u.Alias='agt'+nickname.substring(1,3);
		u.CommunityNickname ='Agent'+newAge.Name;
		u.Username = newAge.Name+'@Lemonade.com';
		u.CommunityNickname = newAge.Name__c+'agt';
		u.ProfileId = AgentProfileId.id;
		u.EmailEncodingKey = 'ISO-8859-1';
		u.TimeZoneSidKey = 'America/Los_Angeles';
		u.LanguageLocaleKey  = 'en_US';
		u.LocaleSidKey = 'en_US';						
                u.ContactId =ContactMap.get(newAge.Id);
		u.Agent_Record_ID__c= newAge.id;
		AgentLogin.add(u);
                system.debug('user created');
            }
        }
		insert AgentLogin;
	}
  	
}
