"use strict";

const orders = require("../data/orders.json");

function listOrder(orderId) {
    if (!orderId) {
        return orders;
      }
    
      const orderFound = orders.find((order) => {
        return order.orderId == orderId;
      });
    
      if (orderFound) {
        return orderFound;
      }
    
      throw new Error("The order you requested was not found");
}

module.exports = listOrder;
