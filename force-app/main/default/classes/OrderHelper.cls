public with sharing class OrderHelper {
    private static final Id DEFAULT_PRODUCT_ID = 'ID_HERE'; 

    public static void addDefaultProduct(List<Order> newOrders) {
        List<OrderItem> orderItemsToInsert = new List<OrderItem>();

        for (Order ord : newOrders) {
            Integer existingProductCount = [SELECT COUNT() FROM OrderItem WHERE OrderId = :ord.Id AND Product2Id = :DEFAULT_PRODUCT_ID];

            if (existingProductCount == 0) {
                OrderItem newOrderItem = new OrderItem(
                    OrderId = ord.Id,
                    Product2Id = DEFAULT_PRODUCT_ID,
                    UnitPrice = 0, 
                    Quantity = 1
                );

                orderItemsToInsert.add(newOrderItem);
            }
        }

        if (!orderItemsToInsert.isEmpty()) {
            insert orderItemsToInsert;
        }
    }
}