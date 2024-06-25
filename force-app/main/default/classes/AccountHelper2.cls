public with sharing class AccountHelper2 {
    public void preventAccountDeletion(List<Account> accList){
        Set<Id> accIds = new Set<Id>();

        for(Accoutn acc : accList){
            accIds.add(acc.Id);
        }


        // Map to track Account Ids to respective Contacts
        List<Contact> relatedContacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds];
        Map<Id, Boolean> accountHasContacts = new Map<Id, Boolean>();
        
        for (Contact con : relatedContacts) {
            accountHasContacts.put(con.AccountId, true);
        }

        // Add Error
        for (Account acc : accounts) {
            if (accountHasContacts.containsKey(acc.Id)) {
                acc.addError('This account has related contacts and cannot be deleted.');
            }
        }
    }

    public static void createRelatedContact(List<Account> accList){
        List<Contact> contactsToInsert = new List<Contact>();
        
        for (Account acc : accounts) {
            Contact newContact = new Contact(
                FirstName = 'Default',
                LastName = 'Contact',
                Email = 'default@example.com',
                AccountId = acc.Id
            );
            contactsToInsert.add(newContact);
        }
    
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}