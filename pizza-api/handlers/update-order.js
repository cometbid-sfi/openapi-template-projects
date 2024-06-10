"use strict";

function updateOrder(id, updates) {
  if (!id || !updates) {
    throw new Error(
      "Order Id and updates object are required for updating the order"
    );
  }

  return {
    message: `Order ${id} was successfully updated`,
  };
}

module.exports = updateOrder;
