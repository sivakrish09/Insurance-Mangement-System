trigger insurancePolicyHolderTrigger on Policy_Holder__c (before insert, after update)
{
	if(trigger.isAfter)
    {
        if(trigger.isUpdate)
        {
			insurancePolicyHolderHandler.createnewuser(trigger.new, trigger.old);
        }
    }
    
    if(trigger.isBefore)
    {
		if(trigger.isInsert)
        {
			insurancePolicyHolderHandler.contactCreate(trigger.new);
        }
    }
}