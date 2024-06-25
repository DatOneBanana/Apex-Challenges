public with sharing class ContactHelper2 {
    public static void setDefaultEmail(List<Contact> contacts) {
        
        String defaultEmail = 'default@gamil.com';

        for (Contact con : contacts) {
            // Check if email field is empty
            if (con.Email == null || con.Email.trim() == '') {
                con.Email = defaultEmail;
            }
        }
    }

    public static void updateAccountPhone(List<Contact> newContacts, Map<Id, Contact> oldContactMap){
        Map<Id, String> accountPhoneMap = new Map<Id, String>();
        
        for (Contact newCon : newContacts) {
            Contact oldCon = oldContactMap.get(newCon.Id);
            if (newCon.Phone != oldCon.Phone) {
                accountPhoneMap.put(newCon.AccountId, newCon.Phone);
            }
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Id accountId : accountPhoneMap.keySet()) {
            Account acc = new Account(Id = accountId, Phone = accountPhoneMap.get(accountId));
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}