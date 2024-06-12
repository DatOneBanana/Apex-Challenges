public with sharing class DataLord {

    public static Integer NumAccounts() {
        return [SELECT COUNT() FROM Account];
    }

    public static Integer NumHot() {
        return [SELECT COUNT() FROM Account WHERE Rating = 'Hot'];
    }

    public static Integer NumComplex(){
        return [SELECT COUNT() FROM Account WHERE Name LIKE '%&%'];
    }

    public static List<Account> BigFive() {
        return [SELECT Id, Name, AnnualRevenue FROM Account ORDER BY AnnualRevenue DESC LIMIT 5];
    }

    public static Opportunity LastBigOpportunity() {
        return [SELECT Id, Name, CloseDate, Amount FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate DESC LIMIT 1];
    }

    public static List<Contact> MajorPlayers() {
        return [SELECT Id, Name, Account.Name FROM Contact WHERE Account.Rating = 'Hot'];
    }

    public static String MostPopularAccount() {
        return [SELECT Account.Name FROM Contact GROUP BY Account.Name ORDER BY COUNT(Id) DESC LIMIT 1][0].Account.Name;
    }

    public static List<Opportunity> TopClosingLeadSources() {
        return [
            SELECT LeadSource, COUNT(Id) numClosed
            FROM Opportunity
            WHERE IsClosed = TRUE AND LeadSource != NULL
            GROUP BY LeadSource
            ORDER BY numClosed DESC
            LIMIT 5
        ];
    }

    public static List<List<SObject>> searchContactsLeads() {
        List<List<SObject>> searchResults = [
            FIND 'Tom' IN NAME FIELDS RETURNING Contact(Name), Lead(Name)
        ];
        return searchResults;
    }

    public static List<List<SObject>> searchAccounts() {
        List<List<SObject>> searchResults = [
            FIND '(a AND o)' IN ALL FIELDS RETURNING Account(Name, Industry)
        ];
        return searchResults;
    }

    public static String searchPhoneNumbers() {
        String name = null;
        
        List<List<SObject>> searchList = [
            FIND '1000' IN PHONE FIELDS RETURNING Account(Name), Contact(Name), Lead(Name)
        ];
        
        for (List<SObject> searchResultsList : searchList) {
            for (SObject result : searchResultsList) {
                if (result.get('Name') != null) {
                    name = (String) result.get('Name');
                    break;
                }
            }
            if (name != null) {
                break;
            }
        }
        
        return name;
    }

    public static void spawnContacts() {
        List<Contact> contactsToInsert = new List<Contact>();
        
        for (Integer i = 1; i <= 200; i++) {
            Contact newContact = new Contact(
                FirstName = 'Contact_' + i,
                LastName = 'Last_' + i,
                Email = 'contact' + i + '@example.com'
            );
            contactsToInsert.add(newContact);
        }
        
        insert contactsToInsert;

    }

    public static void createHomes() {
        List<Account> accountsToInsert = new List<Account>();
        
        for (Integer i = 1; i <= 3; i++) {
            Account newAccount = new Account(
                Name = 'Home_' + i,
                Industry = 'Real Estate'
            );
            accountsToInsert.add(newAccount);
        }

        insert accountsToInsert;
    }

    public static void relocate() {
        List<Contact> contactsToDelete = [SELECT Id FROM Contact ORDER BY CreatedDate DESC LIMIT 50];
        
        delete contactsToDelete;
    }

    private static final String[] accountNames = new String[] {
        'Home_1',
        'Home_2',
        'Home_3'
    };

    public static void assignHomes() {
        List<Contact> contactsToUpdate = new List<Contact>();
        
        List<Contact> contacts = [SELECT Id FROM Contact WHERE CreatedDate = LAST_N_DAYS:1];
        
        for (Contact contact : contacts) {
            Integer randomIndex = Math.mod(Crypto.getRandomInteger(), accountNames.size());

            String accountName = accountNames[randomIndex];

            Account relatedAccount = [SELECT Id FROM Account WHERE Name = :accountName LIMIT 1];
            
            if (relatedAccount != null) {
                contact.AccountId = relatedAccount.Id;
                contactsToUpdate.add(contact);
            }
        }
        
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }

    public static void play() {
        Savepoint sp = Database.setSavepoint();
        
        try {
            ContactCreation.spawnContacts();
            AccountCreation.createHomes();
            ContactDeletion.relocate();
            ContactAssignment.assignHomes();
            
            printDatabaseStatistics();
        } catch (Exception e) {
            System.debug('An error occurred: ' + e.getMessage());
            Database.rollback(sp);
        }
    }

    private static void printDatabaseStatistics() {
        // num of contacts at the start
        Integer initialContacts = [SELECT COUNT() FROM Contact];
        
        // num of accounts at the start
        Integer initialAccounts = [SELECT COUNT() FROM Account];
        
        // current num of contacts
        Integer currentContacts = [SELECT COUNT() FROM Contact];
        
        // current num of accounts
        Integer currentAccounts = [SELECT COUNT() FROM Account];
        
        // num of related contacts for each account
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account];
        
        // Output statistics to Debug Log
        System.debug('*** Database Statistics ***');
        System.debug('Number of Contacts at the start: ' + initialContacts);
        System.debug('Number of Accounts at the start: ' + initialAccounts);
        System.debug('Number of Contacts currently: ' + currentContacts);
        System.debug('Number of Accounts currently: ' + currentAccounts);
        
        for (Account acc : accounts) {
            System.debug('Number of Related Contacts for Account ' + acc.Name + ': ' + acc.Contacts.size());
        }
    }
    
}