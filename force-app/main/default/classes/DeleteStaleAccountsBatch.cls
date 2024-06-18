global class DeleteStaleAccountsBatch implements Database.Batchable<SObject>{
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // query to find accounts with no related open opportunities in the last 6 months
        String query = 'SELECT Id FROM Account WHERE Id NOT IN (SELECT AccountId FROM Opportunity WHERE CloseDate = LAST_6_MONTHS AND StageName != \'Closed Won\' AND StageName != \'Closed Lost\')';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Account> scope) {
        // delete the stale accounts
        delete scope;
    }

    global void finish(Database.BatchableContext BC) {
        // Optionally add post-processing logic here
    }
}