public with sharing class ContactController {

    @AuraEnabled
    public static void createContact(Contact contact){
        try {
            insert contact;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}