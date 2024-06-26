public with sharing class CaseHelper {
    public static void handleCaseStatus(List<Case> newCases, Map<Id, Case> oldCaseMap, Boolean isInsert) {
        for (Case newCase : newCases) {
            // Set to new for newly inserted cases
            if (isInsert) {
                newCase.Status = 'New';
            } else {
                // Update Status to working if comments are added and status is new
                Case oldCase = oldCaseMap.get(newCase.Id);
                if (newCase.Internal_Comments__c != null && oldCase.Internal_Comments__c == null && newCase.Status == 'New') {
                    newCase.Status = 'Working';
                }
            }
        }
    }
}