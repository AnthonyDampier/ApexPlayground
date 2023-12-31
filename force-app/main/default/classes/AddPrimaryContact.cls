/**
 * @description       : 
 * @author            : Anthony.d@digitalmass.com
 * @group             : 
 * @last modified on  : 08-24-2023
 * @last modified by  : Anthony.d@digitalmass.com
**/
public class AddPrimaryContact implements Queueable {
    public contact c;
    public String state;
    
    public AddPrimaryContact(Contact c, String state) {
        this.c = c;
        this.state = state;
    }
    
    public void execute(QueueableContext qc) {
        system.debug('this.c = '+this.c+' this.state = '+this.state);
        List<Account> accList = new List<account>([select id, name, BillingState from account where account.BillingState = :this.state limit 200]);
        List<contact> cList = new List<contact>();
        for(account a: accList) {
            contact c = new contact();
            c = this.c.clone(false, false, false, false);
            c.AccountId = a.Id;
            cList.add(c);
        }
        insert cList;
    }

}