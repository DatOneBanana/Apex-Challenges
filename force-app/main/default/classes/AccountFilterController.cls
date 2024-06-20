public with sharing class AccountFilterController {
    public String accountNameFilter { get; set; }
    
    public List<Account> filteredAccounts { get; set; }
    
    public Boolean showFilteredAccounts { get; set; }
    
    public AccountFilterController() {
        showFilteredAccounts = false;
    }
    
    public void filterAccounts() {
        String query = 'SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account';
        
        if (accountNameFilter != null && !accountNameFilter.trim().isEmpty()) {
            query += ' WHERE Name LIKE \'%' + String.escapeSingleQuotes(accountNameFilter) + '%\'';
        }
        
        filteredAccounts = Database.query(query);
        showFilteredAccounts = true;
    }
}