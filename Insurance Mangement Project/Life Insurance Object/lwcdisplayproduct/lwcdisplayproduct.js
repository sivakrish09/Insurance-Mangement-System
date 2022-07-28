import { LightningElement, wire } from 'lwc';
import getClientInfo from '@salesforce/apex/InsLifeInsuranceHandler.getClientInfo';
import getMotorList from '@salesforce/apex/InsMotorInsuranceHandler.getMotorList';
const LICCOLOUM =[ { label: 'Customer Name',fieldName:'Customer_Name__c' },
                { label: 'Insurance Id',fieldName:'Name',sortable: true },
                { label: 'Premium Amount',fieldName:'Premium_Amount__c'},
                { label: 'Premium Type',fieldName:'Premium_Type__c'},
				{ label: 'Total Amount Paid', fieldName: 'Total_Amount_Paid__c'}]
				
const MICOLOUM =[ { label: 'Customer Name',fieldName:'Customer_Name__c' },
                { label: 'Insurance Id',fieldName:'Name',sortable: true },
                { label: 'Premium Amount',fieldName:'Premium_Amount__c'},
                { label: 'Premium Type',fieldName:'Premium_Type__c'},
                {label: 'Motor Type',fieldName:'Motor_Type__c'}   ]

export default class Lwcdisplayproduct extends LightningElement {
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
        getClientInfo({PhId:this.InputValue})
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
        getMotorList({PhId:this.InputValue})
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