/**
 * @description       : 
 * @author            : Anthony.d@digitalmass.com
 * @group             : 
 * @last modified on  : 08-24-2023
 * @last modified by  : Anthony.d@digitalmass.com
**/
@IsTest
public class AddPrimaryContactTest {
    @IsTest
    public static void testing() {
        List<account> accList = new List<account>();
        for (Integer i=0; i<50;i++) {
            account a = new account(name=string.valueOf(i),billingState='NY');
            system.debug('account a = '+a);
            accList.add(a);
        }
        for (Integer i=0; i<50;i++) {
            account a = new account(name=string.valueOf(50+i),billingState='CA');
            system.debug('account a = '+a);
            accList.add(a);
        }      
        insert accList;
        Test.startTest();
        Contact c = new Contact(lastname='alex');
        AddPrimaryContact addPrimaryContact = new AddPrimaryContact(c,'CA');
        system.debug('addPrimaryContact = '+addPrimaryContact);
        System.enqueueJob(addPrimaryContact);
        Test.stopTest();
        List<Contact> contactList = new List<Contact>([SELECT id FROM Contact]);
        Integer size = contactList.size();
        system.assertEquals(50, size);
    }

}