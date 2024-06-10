"use strict";

function deleteOrder(id) {
  if (!id) {
    throw new Error("Order Id is required for deleting the Order");
  }

  return {};
}

module.exports = deleteOrder;
