public with sharing class AccountContactController {
    public List<Account> accounts { get; set; }
    
    public AccountContactController() {
        accounts = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account];
    }
    
    public String getContactNames(Account acc) {
        List<String> contactNames = new List<String>();
        for (Contact con : acc.Contacts) {
            contactNames.add(con.Name);
        }
        return String.join(contactNames, ', ');
    }
}