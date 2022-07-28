import { LightningElement, wire } from 'lwc';
import getPolicyHolderInfo from '@salesforce/apex/InsLifeInsuranceHandler.getPolicyHolderInfo';
import getInsuranceList from '@salesforce/apex/InsMotorInsuranceHandler.getInsuranceList';
const LICCOLOUM =[ { label: 'Customer Name',fieldName:'Customer_Name__c' },
                { label: 'Insurance Id',fieldName:'Name',sortable: true },
                { label: 'Premium Amount',fieldName:'Premium_Amount__c'},
                { label: 'Premium Type',fieldName:'Premium_Type__c'}]
const MICOLOUM =[ { label: 'Customer Name',fieldName:'Customer_Name__c' },
                { label: 'Insurance Id',fieldName:'Name',sortable: true },
                { label: 'Premium Amount',fieldName:'Premium_Amount__c'},
                { label: 'Premium Type',fieldName:'Premium_Type__c'},
                {label: 'Motor Type',fieldName:'Motor_Type__c'}   ]
export default class LwcRetriveClient extends LightningElement
{
    InputValue='';
    LICHeading=LICCOLOUM;
    LICrecords;
    rowOffset = 0;
    MIrecords;
    MIHeading =MICOLOUM;
    UserInput(event)
    {
        this.InputValue = event.target.value;
    }
    HandleName()
    {
        getPolicyHolderInfo({Agentid:this.InputValue})
        .then((result=>
            {
                this.LICrecords =result;
            }
            ))
            .catch((error)=>
            {
                this.LICrecords = undefined;
            }
            
            );
        getInsuranceList({Agentid:this.InputValue})
            .then((result =>
                {
                    this.MIrecords = result;
                }
                ))
            .catch((error) =>
                {
                    this.MIrecords = undefined;    
                }
            );
    }
}