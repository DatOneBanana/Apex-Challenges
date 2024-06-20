public with sharing class AccountLookupController {
    private ApexPages.StandardController stdController;
    public List<Contact> relatedContacts { get; set; }
    
    public AccountLookupController(ApexPages.StandardController controller) {
        stdController = controller;
        relatedContacts = new List<Contact>();
    }
    
    public void lookupAccount() {
        try {
            Account acc = (Account)stdController.getRecord();
            acc = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id = :acc.Id LIMIT 1];
            relatedContacts = acc.Contacts;
            stdController.setRecord(acc);
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No account found with the provided input.'));
        }
    }
}