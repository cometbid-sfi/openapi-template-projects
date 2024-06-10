"use strict";

const AWS = require("aws-sdk"); // using the SDK
const documentClient = new AWS.DynamoDB.DocumentClient(); // Initialise Dynamodb DocumentClient

function createOrder(request) {
  if (!request || !request.pizza || !request.address) {
    throw new Error(
      "To order pizza, please provide pizza type and address where pizza should be delivered"
    );
  }

  return documentClient
    .put({
      TableName: "pizza-orders",
      Item: {
        orderId: "some-id",
        pizza: request.pizza,
        address: request.address,
        orderStatus: "pending",
      },
    })
    .promise()
    .then((res) => {
      console.log("Order is saved!", res);
      return res;
    })
    .catch((saveError) => {
      console.log(`Oops, order is not saved :(`, saveError);
      return saveError;
    });
}

module.exports = createOrder;
