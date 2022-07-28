public class insurancePolicyHolderHandler
{
    public static void contactCreate(list<Policy_Holder__c> leadlist)
    {
        list<contact> conlist = new list<contact>();
        contact phContact = new contact();
        for(Policy_Holder__c phList:leadlist )
        {
            phContact.AccountId='0012w00000zSPNcAAO';
            phContact.Email = phlist.Email__c;
            phContact.LastName = phlist.Name__c;
            phContact.Phone = phlist.Phone__c;
            conlist.add(phContact);
        }
        insert conlist;
    }
    public static void createnewuser(list<Policy_Holder__c> NewRecords,list<Policy_Holder__c> oldRecords)
    {	
        Profile clientProfileId= [SELECT Id FROM Profile WHERE Name ='Insurance Policy User']; 
		list<User> userList = new list<user>();
        set<string> PhEmailId = new set<string>();
        for (Policy_Holder__c phEmails : NewRecords)
        {
			if(phEmails.Request_Status__c == 'Approved' && phEmails.Do_you_want_to_create_user_ID__c == 'Yes')
            {
                PhEmailId.add(phEmails.Email__c);
            }
        }
        Contact Con = [SELECT id FROM contact WHERE Email =:PhEmailId LIMIT 1];
        for (Policy_Holder__c oldClient : oldRecords)
			{
				if(oldClient.Request_Status__c != 'Approved' && oldClient.Do_you_want_to_create_user_ID__c	!= 'Yes')
				{
					for (Policy_Holder__c newClient : NewRecords)
					{
						if(newClient.Request_Status__c == 'Approved' && newClient.Do_you_want_to_create_user_ID__c == 'Yes')
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
								u.ProfileId = clientProfileId.id;
								u.EmailEncodingKey = 'ISO-8859-1';
								u.TimeZoneSidKey = 'America/Los_Angeles';
								u.LanguageLocaleKey  = 'en_US';
								u.LocaleSidKey = 'en_US';
								u.ContactId = Con.id;
								u.Agent_Record_ID__c= newClient.id;
								userList.add(u);
						}
					}
				}
			}
		insert userList;
}
}