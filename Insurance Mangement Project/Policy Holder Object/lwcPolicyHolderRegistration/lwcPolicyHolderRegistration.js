import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import POLICY_HOLDER from '@salesforce/schema/Policy_Holder__c';
import NAME from '@salesforce/schema/Policy_Holder__c.Name__c';
import DOB from '@salesforce/schema/Policy_Holder__c.Date_of_Birth__c';
import GENDER from '@salesforce/schema/Policy_Holder__c.Gender__c';
import PHONE from '@salesforce/schema/Policy_Holder__c.Phone__c';
import EMAIL from '@salesforce/schema/Policy_Holder__c.Email__c';
import OCCUPATION from '@salesforce/schema/Policy_Holder__c.Occupation__c';
import INCOME from '@salesforce/schema/Policy_Holder__c.Income__c';
import ADDRESS from '@salesforce/schema/Policy_Holder__c.Street__c'; 
import AGENTID from '@salesforce/schema/Policy_Holder__c.Agent_ID__c'; 

export default class LwcPolicyHolderRegistration extends LightningElement {

    objApi=POLICY_HOLDER;
    fieldArray;
    Name = NAME;
    DOB = DOB;
    Gender = GENDER;
    Phone = PHONE;
    Email = EMAIL;
    Occupation = OCCUPATION;
    Income = INCOME;
    Address = ADDRESS;
    AgentID = AGENTID;
    formHandler()
    {
        this.dispatchEvent(new ShowToastEvent(
            {
                title:'Policy Request',
                message:'Registered sucessfully.You will get notified once Approved by admin',
                variant: "success",
                mode:'sticky'
            }
        ));

        const fieldArray = this.template.querySelectorAll('lightning-input-field');
        if(fieldArray)
        {
            fieldArray.forEach((field)=>{field.reset();});
        }
        console.log('Registered');
    }

}