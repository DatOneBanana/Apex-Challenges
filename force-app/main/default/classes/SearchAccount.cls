public with sharing class SearchAccount {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String searchKey) {
        String searchKeyPattern = '%' + searchKey + '%';
        return [SELECT Id, Name FROM Account WHERE Name LIKE :searchKeyPattern];
    }
}