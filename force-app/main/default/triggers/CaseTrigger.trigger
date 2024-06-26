trigger CaseStatusTrigger on Case (before insert, before update) {
    CaseHelper.handleCaseStatus(Trigger.new, Trigger.oldMap, Trigger.isInsert);
}