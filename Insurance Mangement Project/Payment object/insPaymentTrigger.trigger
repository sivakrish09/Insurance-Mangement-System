trigger insPaymentTrigger on Payment__c (after insert) {
	if(trigger.isAfter)
    {	
		if(trigger.isInsert)
        {
			InsPaymenthandler.totalAmount();
        }
    }
}