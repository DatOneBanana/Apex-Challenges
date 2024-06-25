trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            ContactHelper2.setDefaultEmail(Trigger.new);
            //ContactHelper.checkEmail(Trigger.new);
        }
        when BEFORE_UPDATE {
            //ContactHelper.checkEmail(Trigger.new);
        }
        when BEFORE_DELETE {

        }
        when AFTER_INSERT {

        }
        when AFTER_UPDATE {
            ContactHelper2.updateAccountPhone(Trigger.new, Trigger.oldMap);
        }
        when AFTER_DELETE {

        }
        when AFTER_UNDELETE {

        }
    }
}