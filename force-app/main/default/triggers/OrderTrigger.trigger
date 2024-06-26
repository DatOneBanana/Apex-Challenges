trigger AddDefaultProductToOrder on Order (after insert) {
    OrderHelper.addDefaultProduct(Trigger.new);
}