public class insuranceleadHandler {
    
    public static void convertintoPolicyHolder (list<lead> newlead, list<lead> oldlead)
    {
		list<Policy_Holder__c> pHlist = new list<Policy_Holder__c>();
       
        for(lead le : oldlead)
        {
			if(le.Lead_is_Qulified__c != 'Yes')
            {
                for(lead l :newlead )
                {
                    if(l.Lead_is_Qulified__c == 'Yes')
                    {
                        Policy_Holder__c ph = new Policy_Holder__c();
                        ph.Name__c = l.FirstName+' '+l.LastName;
                        ph.Phone__c =l.Phone;
                        ph.Email__c = l.Email;
                        ph.Gender__c =l.Gender__c;
                        ph.Income__c = l.AnnualRevenue;
                        ph.Occupation__c = l.Company;
                        ph.Street__c =l.Street;
                        pHlist.add(ph);
                    }
                }
                
            }
        }
        insert pHlist;

    }

}