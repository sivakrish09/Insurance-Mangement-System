trigger insurancePolicyHolderTrigger on Policy_Holder__c (before Update, after update)
{

    if(trigger.isBefore)
    {
	if(trigger.isUpdate)
        {
		insurancePolicyHolderHandler.contactCreate(trigger.old,trigger.new);
        }
    }
    if(trigger.isAfter)
    {
	if(trigger.isUpdate)
	{		
		insurancePolicyHolderHandler.UserCreate(trigger.old,trigger.new);
	}			
    }
}
