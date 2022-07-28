import { LightningElement, wire} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import AGENTID_FIELD from '@salesforce/schema/User.Agent_Record_ID__c';
const fields = [AGENTID_FIELD];
import NAME from '@salesforce/schema/Policy_Holder__c.Name__c';
import DOB from '@salesforce/schema/Policy_Holder__c.Date_of_Birth__c';
import GENDER from '@salesforce/schema/Policy_Holder__c.Gender__c';
import PHONE from '@salesforce/schema/Policy_Holder__c.Phone__c';
import EMAIL from '@salesforce/schema/Policy_Holder__c.Email__c';
import ADDRESS from '@salesforce/schema/Policy_Holder__c.Street__c';
import PERM_ID from '@salesforce/schema/Policy_Holder__c.Permanent_policy_holder_id__c';	
import OCCUPATION from '@salesforce/schema/Policy_Holder__c.Occupation__c';
import INCOME from '@salesforce/schema/Policy_Holder__c.Income__c';
const FIELD = [ NAME, DOB, GENDER, PHONE, EMAIL, ADDRESS,PERM_ID, OCCUPATION, INCOME];
export default class LwcDisplayClientInfo extends LightningElement {

    UserId = Id;
    Heading = FIELD;

    @wire(getRecord, { recordId: '$UserId', fields })user;
   
    get records()
    {
        return getFieldValue(this.user.data,AGENTID_FIELD );
        
    }
}