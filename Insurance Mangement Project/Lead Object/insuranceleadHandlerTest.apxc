@isTest
public class insuranceleadHandlerTest
{
    @testSetup static void setup()
    {
         // create lead record
        lead l = new Lead();
        l.LastName = 'TestRecord';
        l.Company  = 'TestAcadamy';
        l.Status   = 'Open - Not Contacted';
        l.Phone  = '1234567890';
        l.Email  = 'testrecord@testacadamy.net';
       	insert l;
    }
    
	@isTest
    public static void TestFunction()
    {
               
        // query inserted record
        lead leadRecord = [SELECT Id FROM Lead WHERE Email = 'testrecord@testacadamy.net' ];
        leadRecord.Lead_is_Qulified__c ='Yes';
        Update leadRecord;
        
       //check new policy record created or not
       
        Policy_Holder__c ph = new Policy_Holder__c();
        ph = [SELECT id,Email__c FROM Policy_Holder__c WHERE Email__c = 'testrecord@testacadamy.net'];
        System.assertEquals('testrecord@testacadamy.net', ph.Email__c);
       
    }

}
