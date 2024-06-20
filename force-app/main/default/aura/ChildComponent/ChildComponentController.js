({
    sendMessage: function(component, event, helper) {
        var message = component.get("v.message");
        var messageEvent = component.getEvent("sendMessage");
        messageEvent.setParams({ "message": message });
        messageEvent.fire();
    },
    
    clearInput: function(component, event, helper) {
        component.set("v.message", "");
    }
})