trigger agentHandlertrigger on Agent__c (before Update)
{
    if(trigger.isBefore)
    {
		if(trigger.isUpdate)
        {
			agentHandlerClass.createnewuser(trigger.new, trigger.old);
            agentHandlerClass.createnewContact(trigger.new, trigger.old);
        }
    }

}