global class ScheduleDeleteStaleAccounts implements Schedulable {
    global void execute(SchedulableContext sc) {
    
        DeleteStaleAccountsBatch batch = new DeleteStaleAccountsBatch();
        Database.executeBatch(batch);
    }
}