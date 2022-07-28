trigger insuranceleadtrigger on Lead (after update)
{
	if(trigger.isAfter)
    {
        if(trigger.isUpdate)
        {
            insuranceleadHandler.convertintoPolicyHolder(trigger.new,trigger.old);
        }
    }
}