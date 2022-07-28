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
                        AgentContacts.add(con);
                    }
                }
            }
        }
        Insert AgentContacts; 
    }
    public static void createnewuser(list<Agent__c>NewRecords, list<Agent__c> oldRecords)  
	{
		Profile AgentProfileId =[SELECT Id FROM Profile WHERE Name ='Insurance Agent'];
        set<string> agEmailid = new set<string>();
		list<User> AgentLogin = new list<User>();
        
        for(Agent__C agtEmail : NewRecords)
		{
          if( agtEmail.Request_Status__c == 'Approved' && agtEmail.user_creation__c =='Yes')
          {
              agEmailid.add(agtEmail.Email__c);
          }
        }
        Contact Con = [SELECT id FROM contact WHERE Email =:agEmailid LIMIT 1];
		for( Agent__C oldAge : oldRecords)
		{
			if(oldAge.Request_Status__c != 'Approved' && oldAge.user_creation__c !='Yes')
                 
				{
                    system.debug('old records') ;
					for(Agent__C newAge : NewRecords)
					{
                        system.debug('new records') ;
						if( newAge.Request_Status__c == 'Approved' && newAge.user_creation__c =='Yes')
							{
								User u = new User();
								string nickname = newAge.Name__c;
								u.LastName = 'Agent';
								u.FirstName = newAge.Name__c;
								u.Email = newAge.Email__c;
								u.Alias='agt'+nickname.substring(1,3);
								u.CommunityNickname ='Agent'+newAge.Name;
								u.Username = newAge.Name+'@Lemonade.net';
								u.CommunityNickname = newAge.Name__c+'agt';
								u.ProfileId = AgentProfileId.id;
								u.EmailEncodingKey = 'ISO-8859-1';
								u.TimeZoneSidKey = 'America/Los_Angeles';
								u.LanguageLocaleKey  = 'en_US';
								u.LocaleSidKey = 'en_US';
                              					u.ContactId =Con.Id;
								u.Agent_Record_ID__c= newAge.id;
								AgentLogin.add(u);
                              					system.debug('user created');
							}
					}
				}
		}
		insert AgentLogin;
	}
  	
}
