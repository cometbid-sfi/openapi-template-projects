"use strict";

const Api = require("claudia-api-builder");
const api = new Api();

const getPizzas = require("./handlers/get-pizzas");
const createOrder = require("./handlers/create-order");
const updateOrder = require("./handlers/update-order");
const deleteOrder = require("./handlers/delete-order");
const listOrder = require("./handlers/list-order");

// Define Routes
// 1. Home Pizzas Route
api.get("/", () => "Welcome to Pizza API");

// 2. GET Pizzas Route
api.get("/pizzas", () => {
  return getPizzas();
});

// 3. GET Pizzas by Id Route
api.get(
  "/pizzas/{id}",
  (request) => {
    return getPizzas(request.pathParams.id);
  },
  {
    error: 404,
  }
);

// 4. POST pizza order Route
api.post(
  "/orders",
  (request) => {
    return createOrder(request.body);
  },
  { success: 201, error: 400 }
);

// 5. PUT pizza order Route
api.put(
  "/orders/{id}",
  (request) => {
    return updateOrder(request.pathParams.id, request.body);
  },
  { error: 400 }
);

// 6. DELETE pizza order Route
api.delete(
  "/orders/{id}",
  (request) => {
    return deleteOrder(request.pathParams.id);
  },
  { error: 400 }
);

// 6. LIST pizza order Route
api.get("/orders", (request) => {
  return listOrder();
});

module.exports = api;
