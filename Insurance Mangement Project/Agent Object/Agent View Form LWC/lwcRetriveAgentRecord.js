import { LightningElement, wire} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import AGENTID_FIELD from '@salesforce/schema/User.Agent_Record_ID__c';
const fields = [AGENTID_FIELD];
import AGNET__C from '@salesforce/schema/Agent__c';
import NAME from '@salesforce/schema/Agent__c.Name__c';
import DOB from '@salesforce/schema/Agent__c.Date_of_Birth__c';
import GENDER from '@salesforce/schema/Agent__c.Gender__c';
import PHONE from '@salesforce/schema/Agent__c.Phone__c';
import EMAIL from '@salesforce/schema/Agent__c.Email__c';
import REGDATE from '@salesforce/schema/Agent__c.Reg_Date__c';
import ADDRESS from '@salesforce/schema/Agent__c.Address__c';
const FIELD = [ NAME, DOB, GENDER, PHONE, EMAIL, REGDATE, ADDRESS];

export default class LwcRetriveAgentRecord extends LightningElement {
  userId = Id;
  objectApiName = AGNET__C;
  agentfield = FIELD;

  @wire(getRecord, { recordId: '$userId', fields })user;

  get record() {
    return getFieldValue(this.user.data, AGENTID_FIELD);
}


}   